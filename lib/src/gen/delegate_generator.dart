import '../loader/language_localization.dart';
import 'generator_config.dart';

typedef LocaleInfo = (String language, String? country);

class DelegateGenerator {
  DelegateGenerator({
    required this.config,
    required this.localizations,
    required this.scheme,
  });

  final GeneratorConfig config;
  final List<LanguageLocalization> localizations;
  final LanguageLocalization scheme;

  String generate() {
    final String className = config.localizationsClassName;
    final Set<LocaleInfo> languages = {
      ...localizations.map((LanguageLocalization localization) => (localization.language.toLowerCase(), localization.country?.toUpperCase())),
    };

    return '''
final Map<Locale, $className> _languageMap = {
  ${localizations.map((LanguageLocalization localization) => '${localization.localeAsString}: ${localization.name},').join('\n')}
};

final Map<Locale, $className> _providersLanguagesMap = {};

class EasiestLocalizationDelegate extends LocalizationsDelegate<$className> {
  EasiestLocalizationDelegate({
    List<LocalizationProvider<$className>> providers = const [],
  }) {
    providers.forEach(registerProvider);
  }

  final List<LocalizationProvider<$className>> _providers = [];

  void registerProvider(LocalizationProvider<$className> provider) {
    _providers.add(provider);
  }

  @override
  bool isSupported(Locale locale) {
    final bool supportedByProviders = _providers.any((LocalizationProvider value) => value.canLoad(locale));
    if (supportedByProviders) {
      return true;
    }
    final bool hasInLanguageMap = _languageMap.containsKey(locale);
    if (hasInLanguageMap) {
      return true;
    }
    for (final Locale supportedLocale in _languageMap.keys) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
  
  Future<$className> load(Locale locale) async {
    Intl.defaultLocale = locale.toString();

    LocalizationProvider<$className>? localizationProvider;

    for (final LocalizationProvider<$className> provider in _providers) {
      if (provider.canLoad(locale)) {
        localizationProvider = provider;
        break;
      }
    }

    $className? localeContent;

    if (localizationProvider != null) {
      try {
        localeContent = await localizationProvider.fetchLocalization(locale);
        _providersLanguagesMap[locale] = localeContent;
      } catch (error, stackTrace) {
        log('Error on loading localization with provider "\${localizationProvider.name}"', error: error, stackTrace: stackTrace);
      }
    }

    localeContent ??= _loadLocalLocale(locale) ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<$className> old) => old != this;
}

class Messages {
  static $className of(BuildContext context) => Localizations.of(context, $className)!;

  static $className? getContent(Locale locale) => _loadLocalLocale(locale);

  static $className get el {
    final String? defaultLocaleString = Intl.defaultLocale;
    final List<String> localeParticles = defaultLocaleString == null ? [] : defaultLocaleString.split(RegExp(r'[_-]'));
    final Locale? defaultLocale = localeParticles.isEmpty ? null : Locale(localeParticles.first, localeParticles.length > 1 ? localeParticles[1] : null);
    LocalizationMessages? localeContent = _providersLanguagesMap[defaultLocale];
    localeContent ??= _languageMap[defaultLocale] ?? _languageMap.values.first;
    return localeContent;
  }
}

LocalizationMessages? _loadLocalLocale(Locale locale) {
  final bool hasInLanguageMap = _languageMap.containsKey(locale);
  if (hasInLanguageMap) {
    return _languageMap[locale];
  }
  for (final Locale supportedLocale in _languageMap.keys) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return _languageMap[supportedLocale];
    }
  }
  return null;
}

$className get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

List<LocalizationsDelegate> localizationsDelegatesWithProviders(List<LocalizationProvider<$className>> providers) {
  return [
    EasiestLocalizationDelegate(providers: providers),
    ...GlobalMaterialLocalizations.delegates,
  ];
}

// Supported locales: ${languages.map((LocaleInfo it) => [it.$1, if (it.$2 != null) it.$2].join('_')).join(', ')}
const List<Locale> supportedLocales = [
  ${languages.map((LocaleInfo it) => "Locale('${it.$1}'${it.$2 == null ? '' : ", '${it.$2}'"}),").join('\n')}
];

List<Locale> supportedLocalesWithProviders(List<LocalizationProvider<$className>> providers) => [
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
''';
  }
}
