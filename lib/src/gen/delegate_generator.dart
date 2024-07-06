import '../loader/language_localization.dart';
import 'generator_config.dart';

class DelegateGenerator {
  DelegateGenerator({
    required this.config,
    required this.localizations,
  });

  final GeneratorConfig config;
  final List<LanguageLocalization> localizations;

  String generate() {
    final String className = config.localizationsClassName;
    final Set<String> languages = {
      ...localizations.map((LanguageLocalization localization) => localization.name),
      ...config.runtimeLocales,
    };

    return '''
final Map<String, $className> _languageMap = {
  ${config.fallbackLocales.entries.map((MapEntry<String, String> entry) => "'${entry.key}': ${entry.value},").join('\n')}
  ${localizations.map((LanguageLocalization localization) => "'${localization.name}': ${localization.name},").join('\n')}
};

final Map<String, $className> _providersLanguagesMap = {};

class EasiestLocalizationDelegate extends LocalizationsDelegate<$className> {
  EasiestLocalizationDelegate({
    List<LocalizationProvider> providers = const [],
  }) {
    providers.map(registerProvider);
  }

  final List<LocalizationProvider> _providers = [];

  void registerProvider(LocalizationProvider provider) {
    _providers.add(provider);
  }

  @override
  bool isSupported(Locale locale) {
    return _languageMap.keys.contains(locale.languageCode) || _providers.firstWhereOrNull((LocalizationProvider value) => value.canLoad(locale)) != null;
  }
  
  Future<$className> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();

    LocalizationProvider? localizationProvider;

    for (final provider in _providers) {
      if (provider.canLoad(locale)) {
        localizationProvider = provider;
        break;
      }
    }

    $className? localeContent;

    if (localizationProvider != null) {
      try {
        localeContent = await localizationProvider.fetchLocalization(locale);
        _providersLanguagesMap[locale.toString()] = localeContent;
      } catch (error, stackTrace) {
        log('Error on loading localization with provider "\${localizationProvider.name}"', error: error, stackTrace: stackTrace);
      }
    }

    localeContent ??= _languageMap[locale.languageCode] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<$className> old) => false;
}

class Messages {
  static $className of(BuildContext context) => Localizations.of(context, $className)!;

  static $className? getContent(String language) => _languageMap[language];

  static $className get el {
    $className? localeContent = _providersLanguagesMap[Intl.defaultLocale] ?? _providersLanguagesMap['*'];
    localeContent ??= _languageMap[Intl.defaultLocale] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }
}

$className get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

List<LocalizationsDelegate> localizationsDelegatesWithProviders(List<LocalizationProvider> providers) {
  return [
    EasiestLocalizationDelegate(providers: providers),
    ...GlobalMaterialLocalizations.delegates,
  ];
}

const List<Locale> supportedLocales = [
  ${config.fallbackLocales.keys.where((String language) => language != '*').map((String language) => "Locale('$language'),").join('\n')}
  ${languages.map((String language) => "Locale('$language'),").join('\n')}
];

List<Locale> supportedLocalesWithProviders(List<LocalizationProvider> providers) => [
      for (final LocalizationProvider provider in providers) ...provider.supportedLocales,
      ...supportedLocales,
    ];

extension EasiestLocalizationContext on BuildContext {
  $className get el {
    return Messages.of(this);
  }

  dynamic tr(String key) => key.tr();
}

extension EasiestLocalizationString on String {
  dynamic get el {
    final List<String> groupOfStrings = contains('.') ? split('.') : [this];
    dynamic targetContent;
    for (int i = 0; i < groupOfStrings.length; i++) {
      final String key = groupOfStrings[i];
      if (i == 0) {
        targetContent = Messages.el[key];
        if (targetContent == null) {
          return '';
        }
      } else {
        try {
          targetContent = targetContent[key];
          if (targetContent == null) {
            return '';
          }
        } catch (error) {
          if (kDebugMode) {
            print('[ERROR] Incorrect retrieving of value by key "\$key" from value "\$targetContent"; Original key was "\$this"');
          }
          return '';
        }
      }
    }
    return targetContent;
  }

  dynamic tr() => el;
}

dynamic tr(String key) => key.tr();

abstract interface class LocalizationProvider {
  String get name;

  List<Locale> get supportedLocales;

  Future<$className> fetchLocalization(Locale locale);

  bool canLoad(Locale locale);
}
''';
  }
}
