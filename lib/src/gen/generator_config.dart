const String kDefaultNamespace = 'intl';
const String kDefaultLangPrefix = r'[A-Za-z]{2}|schema';
const String kDefaultLocalizationClassName = 'LocalizationMessages';
const String kDefaultPackageName = 'localization';
const String kDefaultPackageDescription = 'Generated localization package';
const String kDefaultPackageVersion = '1.0.0';
const String kDefaultPackagePath = './';

class GeneratorConfig {
  const GeneratorConfig({
    this.dartSdk = '',
    this.namespace = kDefaultNamespace,
    this.languagePattern = kDefaultLangPrefix,
    this.localizationsClassName = kDefaultLocalizationClassName,
    this.packageName = kDefaultPackageName,
    this.packageDescription = kDefaultPackageDescription,
    this.packageVersion = kDefaultPackageVersion,
    this.packagePath = kDefaultPackagePath,
    this.runtimeLocales = const [],
    this.excludedPatterns = const [],
    this.formatOutput = false,
    this.withRuntime = false,
    RegExp? regExp,
  }) : _regExp = regExp;

  final String namespace;
  final Pattern languagePattern;
  final String localizationsClassName;
  final String packageName;
  final String dartSdk;
  final String packageDescription;
  final String packageVersion;
  final String packagePath;
  final List<String> runtimeLocales;
  final List<String> excludedPatterns;
  final bool formatOutput;
  final bool withRuntime;

  final RegExp? _regExp;

  RegExp get regExp => _regExp ?? RegExp('(?<lang>$languagePattern)_(?<pattern>$namespace).(ya?ml|json)\$');
}
