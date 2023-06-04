const String kDefaultPrefix = 'intl';
const String kDefaultLanguagePattern = r'[A-Za-z]{2}|schema';
const String kDefaultLocalizationClassName = 'LocalizationMessages';
const String kDefaultPackageName = 'localization';
const String kDefaultPackageDescription = 'Generated localization package';
const String kDefaultPackageVersion = '1.0.0';
const String kDefaultPackagePath = './';

class GeneratorConfig {
  const GeneratorConfig({
    required this.dartSdk,
    this.prefix = kDefaultPrefix,
    this.languagePattern = kDefaultLanguagePattern,
    this.localizationsClassName = kDefaultLocalizationClassName,
    this.packageName = kDefaultPackageName,
    this.packageDescription = kDefaultPackageDescription,
    this.packageVersion = kDefaultPackageVersion,
    this.packagePath = kDefaultPackagePath,
    this.withRuntime = false,
    RegExp? regExp,
  }) : _regExp = regExp;

  final String prefix;
  final Pattern languagePattern;
  final String localizationsClassName;
  final String packageName;
  final String dartSdk;
  final String packageDescription;
  final String packageVersion;
  final String packagePath;
  final bool withRuntime;

  final RegExp? _regExp;

  RegExp get regExp => _regExp ?? RegExp('(?<lang>$languagePattern)_(?<pattern>$prefix).ya?ml\$');
}
