import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

import '../gen/generator_config.dart';
import '../tools/log.dart';
import 'assets_gen_loader.dart';

final RegExp _pubspecRegExp = RegExp(r'pubspec.ya?ml$');
final RegExp validFilesMimeRegExp = RegExp(r'(ya?ml|json)$');

class PubspecLoader {
  const PubspecLoader({
    required this.config,
  });

  final GeneratorConfig? config;

  YamlMap load() {
    final List<File> files = Directory.current.listSync().whereType<File>().toList();
    final File pubspec = files.firstWhere((File it) => it.path.contains(_pubspecRegExp), orElse: () => throw Exception('Not found pubspec.yaml file'));
    final YamlMap pubspecContent = loadYaml(pubspec.readAsStringSync()) as YamlMap;
    return pubspecContent;
  }

  List<String> loadAssetsPaths() {
    final YamlMap pubspecContent = load();
    final YamlMap? flutter = pubspecContent[kFlutter];

    if (flutter == null) {
      throw Exception('Not found "flutter" section in pubspec.yaml');
    }

    final YamlList? assets = flutter[kAssets];

    if (assets == null || assets.isEmpty) {
      throw Exception('''
Not found "assets" section in the pubspec.yaml file or this section is empty. Please, add at least one folder to assets section like that:
# pubspec.yaml
#...
flutter:
  #...
  assets: <-- 1
    - assets/ <-- 2 # or name of your assets folder
#...
''');
    }

    final List<String> assetsPaths = [];

    for (final dynamic asset in assets) {
      if (asset is String) {
        final String dirPath = path.join(Directory.current.path, asset);
        assetsPaths.add(dirPath);
      }
    }

    return assetsPaths;
  }

  List<File> loadSupportedFiles() {
    assert(config != null, '"loadSupportedFiles" required GeneratorConfig');

    final List<String> assets = loadAssetsPaths();
    final Set<File> supportedFiles = {};

    final List<File> allFiles = [];

    for (final String path in assets) {
      if (FileSystemEntity.isFileSync(path)) {
        allFiles.add(File(path));
      } else if (FileSystemEntity.isDirectorySync(path)) {
        allFiles.addAll(Directory(path).listSync().whereType<File>());
      }
    }

    for (final File file in allFiles) {
      if (isSupportedFile(file)) {
        supportedFiles.add(file);
      }
    }

    return supportedFiles.toList();
  }

  bool isSupportedFile(File file) {
    if (validFilesMimeRegExp.hasMatch(file.path) == false) {
      return false;
    }

    bool isExcluded = false;
    String? exclusionPattern;

    for (final String excludedPattern in config!.excludedPatterns) {
      final RegExp excludedRegExp = RegExp(excludedPattern);

      isExcluded = excludedRegExp.hasMatch(file.path);

      if (isExcluded) {
        exclusionPattern = excludedPattern;
      }
    }

    if (isExcluded) {
      logOnce('File "${file.path}" was excluded from generation by pattern "$exclusionPattern"'.asYellow());
      return false;
    }

    final RegExpMatch? match = config!.regExp.firstMatch(file.path);

    if (match != null) {
      final String? language = match.namedGroup('lang');

      if (language == null || language.length != 2) {
        log('Language code "$language" is not valid'.asRed());
        return false;
      }

      final String rawContent = file.readAsStringSync();

      if (rawContent.isEmpty) {
        logOnce('File "${file.path}" have no localization content'.asYellow());
        return false;
      }

      return true;
    }

    return false;
  }
}
