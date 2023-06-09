import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../gen/generator_config.dart';
import '../type/mappers.dart';
import '../type/types.dart';
import 'content_loader.dart';
import 'language_localization.dart';
import 'pubspec_loader.dart';

const kFlutter = 'flutter';
const kAssets = 'assets';
const kDependencies = 'dependencies';
const kIntl = 'intl';
const kEnv = 'environment';
const kSdk = 'sdk';

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
    _pubspecContent = PubspecLoader().load();
    final YamlMap? flutter = _pubspecContent[kFlutter];
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
    final Map<String, LanguageLocalization> localizationsCache = {};
    final Set<String> languagesCache = {};

    for (final dynamic asset in assets) {
      if (asset is String) {
        final String dirPath = join(Directory.current.path, asset);
        final (List<File> matchedFiles, List<LanguageLocalization> localizations) = _scanDir(Directory(dirPath));
        for (int i = 0; i < matchedFiles.length; i++) {
          final File file = matchedFiles[i];
          final LanguageLocalization localization = localizations[i];
          localizationsCache[file.path] = localization;
        }
      }
    }
    for (final MapEntry(:value) in localizationsCache.entries) {
      if (languagesCache.contains(value.language)) {
        throw Exception('Found more than one localization source for the language "${value.language}":\n$localizationsCache');
      }
      languagesCache.add(value.language);
      result.add(value);
    }
    return result;
  }

  (List<File>, List<LanguageLocalization>) _scanDir(Directory directory) {
    final List<LanguageLocalization> localizationFiles = [];
    final List<File> matchedFiles = [];
    final List<File> allFiles = directory.listSync(recursive: true).whereType<File>().toList();
    for (final File file in allFiles) {
      final String filename = file.path.replaceFirst(file.parent.path, '');
      bool isExcluded = false;
      for (final String exclusion in config.excludedPatterns) {
        isExcluded = RegExp(exclusion).hasMatch(filename);
        if (isExcluded) {
          break;
        }
      }
      if (isExcluded) {
        continue;
      }
      final RegExpMatch? match = config.regExp.firstMatch(file.path);

      if (match != null) {
        final String language = match.namedGroup('lang')!;
        final Json content = yamlMapToJson(loadYaml(file.readAsStringSync()));
        localizationFiles.add(LanguageLocalization(language: language, content: content));
        matchedFiles.add(file);
      }
    }
    return (matchedFiles, localizationFiles);
  }
}
