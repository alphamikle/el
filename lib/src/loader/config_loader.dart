import 'package:yaml/yaml.dart';

import '../../easiest_localization.dart';
import '../type/mappers.dart';
import 'pubspec_loader.dart';

const String kEnv = 'environment';
const String kSdk = 'sdk';
const String kConfig = 'easiest_localization';
const String kExcludedPatterns = 'excluded';
const String kNamespace = 'namespace';
const String kLangPrefix = 'language_prefix';
const String kClassName = 'class_name';
const String kDescription = 'description';
const String kPackageName = 'package_name';
const String kPackagePath = 'package_path';
const String kPackageVersion = 'package_version';
const String kFormatOutput = 'format_output';
const String kRegExp = 'reg_exp';
const String kFallbackLocales = 'fallback_locales';

// Under development for now
const String kRuntimeLocales = 'runtime_locales';
const String kWithRuntime = 'runtime_enabled';

class ConfigLoader {
  GeneratorConfig load() {
    final YamlMap pubspecContent = PubspecLoader().load();
    final YamlMap? config = pubspecContent[kConfig];
    final String dartSdk = (pubspecContent[kEnv] as YamlMap)[kSdk] as String;

    if (config == null) {
      return GeneratorConfig(dartSdk: dartSdk);
    }

    final String? pattern = config[kRegExp];
    final RegExp? regExp = pattern == null ? null : RegExp(pattern);
    final YamlList? excludedPatterns = config[kExcludedPatterns];

    return GeneratorConfig(
      namespace: config[kNamespace] ?? kDefaultNamespace,
      excludedPatterns: excludedPatterns == null ? [] : excludedPatterns.map((dynamic it) => it.toString()).toList(),
      dartSdk: dartSdk,
      languagePattern: config[kLangPrefix] ?? kDefaultLangPrefix,
      localizationsClassName: config[kClassName] ?? kDefaultLocalizationClassName,
      packageDescription: config[kDescription] ?? kDefaultPackageDescription,
      packageName: config[kPackageName] ?? kDefaultPackageName,
      packagePath: config[kPackagePath] ?? kDefaultPackagePath,
      packageVersion: config[kPackageVersion] ?? kDefaultPackageVersion,
      regExp: regExp,
      fallbackLocales: yamlMapToFallbackLocales(config[kFallbackLocales]),
      formatOutput: bool.tryParse(config[kFormatOutput].toString()) ?? false,
    );
  }
}
