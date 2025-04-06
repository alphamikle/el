import 'package:yaml/yaml.dart';

import '../gen/generator_config.dart';
import 'assets_gen_loader.dart';
import 'pubspec_loader.dart';

const String kEnv = 'environment';
const String kSdk = 'sdk';
const String kConfig = 'easiest_localization';
const String kExcludedPatterns = 'excluded';
const String kClassName = 'class_name';
const String kDescription = 'description';
const String kEasiestLocalization = 'easiest_localization_version';
const String kPackageName = 'package_name';
const String kPackagePath = 'package_path';
const String kPackageVersion = 'package_version';
const String kFormatOutput = 'format_output';
const String kRemoteVersion = 'remote_version';
const String kRegExp = 'reg_exp';
const String kWatchMode = 'watch';
const String kPrimaryLocalization = 'primary_localization';
const String kSaveMergedFilesAs = 'save_merged_files_as';
const String kUnitPubspec = 'init_pubspec';

class ConfigLoader {
  GeneratorConfig load() {
    final YamlMap pubspecContent = PubspecLoader(config: null).load();
    final YamlMap? config = pubspecContent[kConfig];
    final String dartSdk = (pubspecContent[kEnv] as YamlMap)[kSdk] as String;

    if (config == null) {
      return GeneratorConfig(dartSdk: dartSdk);
    }

    final String? pattern = config[kRegExp];
    final RegExp? regExp = pattern == null ? null : RegExp(pattern);
    final YamlList? excludedPatterns = config[kExcludedPatterns];

    return GeneratorConfig(
      excludedPatterns: excludedPatterns == null ? [] : excludedPatterns.map((dynamic it) => it.toString()).toList(),
      dartSdk: dartSdk,
      localizationsClassName: config[kClassName] ?? kDefaultLocalizationClassName,
      packageDescription: config[kDescription] ?? kDefaultPackageDescription,
      easiestLocalizationVersion: config[kEasiestLocalization] ?? pubspecContent[kDependencies]?[kConfig]?.toString() ?? 'any',
      packageName: config[kPackageName] ?? kDefaultPackageName,
      packagePath: config[kPackagePath] ?? kDefaultPackagePath,
      packageVersion: config[kPackageVersion] ?? kDefaultPackageVersion,
      regExp: regExp,
      primaryLocalization: config[kPrimaryLocalization],
      formatOutput: bool.tryParse(config[kFormatOutput].toString()) ?? false,
      saveMergedFilesAs: config[kSaveMergedFilesAs]?.toString(),
      version: config[kRemoteVersion]?.toString(),
      watch: bool.tryParse(config[kWatchMode].toString()) ?? false,
      initPubspec: bool.tryParse(config[kUnitPubspec].toString()) ?? true,
    );
  }
}
