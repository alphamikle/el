const String kDefaultLocalizationClassName = 'LocalizationMessages';
const String kDefaultPackageName = 'localization';
const String kDefaultPackageDescription = 'Generated localization package';
const String kDefaultPackageVersion = '1.0.0';
const String kDefaultPackagePath = './';

/// Config rules for code generation
class GeneratorConfig {
  const GeneratorConfig({
    this.dartSdk = '',
    this.localizationsClassName = kDefaultLocalizationClassName,
    this.packageName = kDefaultPackageName,
    this.packageDescription = kDefaultPackageDescription,
    this.easiestLocalizationVersion = 'any',
    this.packageVersion = kDefaultPackageVersion,
    this.packagePath = kDefaultPackagePath,
    this.excludedPatterns = const [],
    this.formatOutput = false,
    this.primaryLocalization,
    this.saveMergedFilesAs,
    this.version,
    this.watch = false,
    this.initPubspec = true,
    RegExp? regExp,
  }) : _regExp = regExp;

  /// Default name of localization output class. In most cases you will not change it at any time
  final String localizationsClassName;

  /// Default name of generated package. Can be useful, if you want a custom name
  final String packageName;

  /// You can specify special version of the sdk, or will be taken your pubspec.yaml version
  final String dartSdk;

  /// Description of generated package
  final String packageDescription;

  /// Version of the package [easiest_localization], which will be a dependency of the generated package
  final String easiestLocalizationVersion;

  /// Version of generated package
  final String packageVersion;

  /// Path to generated package (excluding package name)
  /// Example: path = "./" and name = "i18n" will place package folder at "your_app_path/i18n"
  final String packagePath;

  /// A list of patterns whose presence in the path or name of localization files will cause them to be excluded
  final List<String> excludedPatterns;

  /// Will generated package be proceeded with "dart fix --apply" command or not
  final bool formatOutput;

  final RegExp? _regExp;

  /// The master locale, which will be used as fallback if some value is missing in some third-party locale.
  /// In case if there is null here - there will be empty strings instead of values.
  final String? primaryLocalization;

  /// Whether or not to generate json files containing full content for each language variation for later use from remote servers
  final String? saveMergedFilesAs;

  /// Version of the generated content.
  /// Will take effect only for merged generated files (yaml or json), which can help you to have several version of the remote content for old users
  final String? version;

  /// Determines whether changes to localization files and settings in pubspec.yaml will be watched in real time
  final bool watch;

  /// Needed or not to install a generated package into the pubspec and call [flutter pub get]
  final bool initPubspec;

  /// RegExp for localization files
  RegExp get regExp =>
      _regExp ??
      RegExp(
          r'(\W)(el_)?(?<lang>[a-z]{2})[_-]?(?<country>[a-zA-Z]{2})?.(ya?ml|json)$');

  GeneratorConfig copyWith({
    String? localizationsClassName,
    String? packageName,
    String? dartSdk,
    String? packageDescription,
    String? easiestLocalizationVersion,
    String? packageVersion,
    String? packagePath,
    List<String>? excludedPatterns,
    bool? formatOutput,
    String? primaryLocalization,
    RegExp? regExp,
    String? saveMergedFilesAs,
    String? version,
    bool? watch,
    bool? initPubspec,
  }) {
    return GeneratorConfig(
      localizationsClassName:
          localizationsClassName ?? this.localizationsClassName,
      packageName: packageName ?? this.packageName,
      dartSdk: dartSdk ?? this.dartSdk,
      packageDescription: packageDescription ?? this.packageDescription,
      easiestLocalizationVersion:
          easiestLocalizationVersion ?? this.easiestLocalizationVersion,
      packageVersion: packageVersion ?? this.packageVersion,
      packagePath: packagePath ?? this.packagePath,
      excludedPatterns: excludedPatterns ?? this.excludedPatterns,
      formatOutput: formatOutput ?? this.formatOutput,
      primaryLocalization: primaryLocalization ?? this.primaryLocalization,
      regExp: regExp ?? _regExp,
      saveMergedFilesAs: saveMergedFilesAs ?? this.saveMergedFilesAs,
      version: version ?? this.version,
      watch: watch ?? this.watch,
      initPubspec: initPubspec ?? this.initPubspec,
    );
  }
}
