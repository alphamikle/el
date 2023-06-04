import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../gen/generator_config.dart';
import '../type/mappers.dart';
import '../type/types.dart';
import 'content_loader.dart';
import 'language_localization.dart';

const kFlutter = 'flutter';
const kAssets = 'assets';
const kDependencies = 'dependencies';
const kIntl = 'intl';
const kEnv = 'environment';
const kSdk = 'sdk';
final RegExp _pubspecRegExp = RegExp(r'pubspec.ya?ml$');

/// Used to load localizations in the generation-based flow
class AssetsGenLoader implements ContentLoader {
  AssetsGenLoader(this.config);

  final GeneratorConfig config;

  late YamlMap _pubspecContent;

  YamlMap? get _dependencies => _pubspecContent[kDependencies];

  String? get intlVersion => _dependencies == null ? null : _dependencies![kIntl];

  String? get dartSdk => _pubspecContent[kEnv][kSdk];

  @override
  List<LanguageLocalization> load() {
    final List<LanguageLocalization> result = [];
    final List<File> files = Directory.current.listSync().whereType<File>().toList();
    final File pubspec = files.firstWhere((File it) => it.path.contains(_pubspecRegExp), orElse: () => throw Exception('Not found pubspec.yaml file'));
    final YamlMap pubspecContent = _pubspecContent = loadYaml(pubspec.readAsStringSync()) as YamlMap;
    final YamlMap? flutter = pubspecContent[kFlutter];
    if (flutter == null) {
      throw Exception('Not found "flutter" section in pubspec.yaml');
    }
    final YamlList? assets = flutter[kAssets];
    if (assets == null || assets.isEmpty) {
      throw Exception('''
Not found "assets" block in pubspec.yaml file or this block is empty. Please, add at least a one folder to assets block like that:
pubspec.yaml
#...
flutter:
  #...
assets: <-- 1
  - assets/ <-- 2
#...
''');
    }
    final Set<String> languagesCache = {};
    for (final dynamic asset in assets) {
      if (asset is String) {
        final String dirPath = join(Directory.current.path, asset);
        final List<LanguageLocalization> dirFiles = _scanDir(Directory(dirPath));
        result.addAll(dirFiles);
        for (final LanguageLocalization file in dirFiles) {
          if (languagesCache.contains(file.language)) {
            throw Exception('Found more than one localization source for the language "${file.language}"');
          }
          languagesCache.add(file.language);
        }
      }
    }
    return result;
  }

  List<LanguageLocalization> _scanDir(Directory directory) {
    final List<LanguageLocalization> localizationFiles = [];
    final List<File> allFiles = directory.listSync(recursive: true).whereType<File>().toList();
    for (final File file in allFiles) {
      final RegExpMatch? match = config.regExp.firstMatch(file.path);

      if (match != null) {
        final String language = match.namedGroup('lang')!;
        final Json content = yamlMapToJson(loadYaml(file.readAsStringSync()));
        localizationFiles.add(LanguageLocalization(language: language, content: content));
      }
    }
    return localizationFiles;
  }
}
