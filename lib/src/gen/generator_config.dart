typedef MissedLocale = String;
typedef FallbackLocale = String;
typedef FallbackLocales = Map<MissedLocale, FallbackLocale>;

const String kDefaultNamespace = 'intl';
const String kDefaultLangPrefix = r'[A-Za-z]{2}|schema';
const String kDefaultLocalizationClassName = 'LocalizationMessages';
const String kDefaultPackageName = 'localization';
const String kDefaultFileName = 'localization';
const String kDefaultPackageDescription = 'Generated localization package';
const String kDefaultPackageVersion = '1.0.0';
const String kDefaultPackagePath = './';
const FallbackLocales kDefaultFallbackLocales = {'*': 'en'};

/// Config rules for code generation
class GeneratorConfig {
  const GeneratorConfig({
    this.dartSdk = '',
    this.namespace = kDefaultNamespace,
    this.languagePattern = kDefaultLangPrefix,
    this.localizationsClassName = kDefaultLocalizationClassName,
    this.packageName = kDefaultPackageName,
    this.fileName = kDefaultFileName,
    this.packageDescription = kDefaultPackageDescription,
    this.packageVersion = kDefaultPackageVersion,
    this.packagePath = kDefaultPackagePath,
    this.fallbackLocales = kDefaultFallbackLocales,
    this.runtimeLocales = const [],
    this.excludedPatterns = const [],
    this.formatOutput = false,
    this.withRuntime = false,
    RegExp? regExp,
  }) : _regExp = regExp;

  /// Special postfix of all localization files, which can be omitted
  final String namespace;

  /// Pattern of languages, like "en", "zh", "pt" and others. Or can be custom, like "[a-z]{2}_[A-Z]{2}" which will catch only "en_US", "en_UK", etc.
  final Pattern languagePattern;

  /// Default name of localization output class. In most cases you will not change it at any time
  final String localizationsClassName;

  /// Default name of generated package. Can be useful, if you want a custom name
  final String packageName;

  /// The same purpose as a package name, but for output file name
  /// Example: import 'package:<packageName>/<fileName>.dart';
  final String fileName;

  /// You can specify special version of the sdk, or will be taken your pubspec.yaml version
  final String dartSdk;

  /// Description of generated package
  final String packageDescription;

  /// Version of generated package
  final String packageVersion;

  /// Path to generated package (excluding package name)
  /// Example: path = "./" and name = "i18n" will place package folder at "<your_app_path>/i18n"
  final String packagePath;

  /// Map of missed locales, which you want to fallback to another existed
  final Map<String, String> fallbackLocales;

  /// List of locales, which are available at runtime (to loading from the remote source)
  /// This feature is under development
  final List<String> runtimeLocales;

  /// A list of patterns whose presence in the path or name of localization files will cause them to be excluded
  final List<String> excludedPatterns;

  /// Will generated package be proceeded with "dart fix --apply" command or not
  final bool formatOutput;

  /// Flag for enabling runtime localizations loading
  /// This feature is under development
  final bool withRuntime;

  final RegExp? _regExp;

  RegExp get regExp => _regExp ?? RegExp('(\\W)(?<lang>($languagePattern))_?(?<pattern>$namespace)?.(ya?ml|json)\$');

  GeneratorConfig copyWith({
    String? namespace,
    Pattern? languagePattern,
    String? localizationsClassName,
    String? packageName,
    String? fileName,
    String? dartSdk,
    String? packageDescription,
    String? packageVersion,
    String? packagePath,
    Map<String, String>? fallbackLocales,
    List<String>? runtimeLocales,
    List<String>? excludedPatterns,
    bool? formatOutput,
    bool? withRuntime,
    RegExp? regExp,
  }) {
    return GeneratorConfig(
      namespace: namespace ?? this.namespace,
      languagePattern: languagePattern ?? this.languagePattern,
      localizationsClassName: localizationsClassName ?? this.localizationsClassName,
      packageName: packageName ?? this.packageName,
      fileName: fileName ?? this.fileName,
      dartSdk: dartSdk ?? this.dartSdk,
      packageDescription: packageDescription ?? this.packageDescription,
      packageVersion: packageVersion ?? this.packageVersion,
      packagePath: packagePath ?? this.packagePath,
      fallbackLocales: fallbackLocales ?? this.fallbackLocales,
      runtimeLocales: runtimeLocales ?? this.runtimeLocales,
      excludedPatterns: excludedPatterns ?? this.excludedPatterns,
      formatOutput: formatOutput ?? this.formatOutput,
      withRuntime: withRuntime ?? this.withRuntime,
    );
  }
}
