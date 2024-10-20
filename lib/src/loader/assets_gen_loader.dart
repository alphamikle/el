import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

import '../gen/generator_config.dart';
import '../tools/log.dart';
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

  String? get intlVersion =>
      _dependencies == null ? null : _dependencies![kIntl];

  String? get dartSdk => _pubspecContent[kEnv][kSdk];

  @override
  List<LanguageLocalization> load() {
    final List<String> assets = PubspecLoader(config: config).loadAssetsPaths();
    final Map<String, LanguageLocalization> localizationsCache = {};
    final List<LanguageLocalization> result = [];

    for (final String asset in assets) {
      final String dirPath = join(Directory.current.path, asset);
      final (
        List<File> matchedFiles,
        List<LanguageLocalization> localizations
      ) = _scanDir(Directory(dirPath));
      for (int i = 0; i < matchedFiles.length; i++) {
        final File file = matchedFiles[i];
        final LanguageLocalization localization = localizations[i];
        localizationsCache[file.path] = localization;
      }
    }

    for (final MapEntry(:value) in localizationsCache.entries) {
      result.add(value);
    }

    return result;
  }

  (List<File>, List<LanguageLocalization>) _scanDir(Directory directory) {
    final List<LanguageLocalization> localizationFiles = [];
    final List<File> allFiles =
        PubspecLoader(config: config).loadSupportedFiles();

    for (final File file in allFiles) {
      final RegExpMatch? match = config.regExp.firstMatch(file.path);

      if (match != null) {
        final String? language = match.namedGroup('lang');

        if (language == null || language.length != 2) {
          log('Language code "$language" is not valid'.asRed());
          continue;
        }

        String? country;

        try {
          country = match.namedGroup('country');
        } catch (error) {
          log('Error on getting country from the RegExp(${config.regExp.toString()})'
              .asRed());
        }

        final String rawContent = file.readAsStringSync();
        if (rawContent.isEmpty) {
          logOnce(
              'File "${file.path}" have no localization content'.asYellow());
          continue;
        }
        final Json content = yamlMapToJson(loadYaml(rawContent));
        localizationFiles.add(LanguageLocalization(
            language: language.toLowerCase(),
            country: country?.toUpperCase(),
            content: content));
      }
    }
    return (allFiles, localizationFiles);
  }
}
