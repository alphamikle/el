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
      ...localizations.map((LanguageLocalization localization) => localization.language),
      ...config.runtimeLocales,
    };

    return '''
final Map<String, $className> _languageMap = {
  ${config.fallbackLocales.entries.map((MapEntry<String, String> entry) => "'${entry.key}': ${entry.value},").join('\n')}
  ${localizations.map((LanguageLocalization localization) => "'${localization.language}': ${localization.language},").join('\n')}
};    

class EasiestLocalizationDelegate extends LocalizationsDelegate<$className> {
  @override
  bool isSupported(Locale locale) => _languageMap.keys.contains(locale.languageCode);

  @override
  Future<$className> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();
    final $className localeContent = _languageMap[locale.languageCode] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<$className> old) => false;
}

class Messages {
  static $className of(BuildContext context) => Localizations.of(context, $className)!;

  static $className? getContent(String language) => _languageMap[language];
  
  static $className get el {
    final $className localeContent = _languageMap[Intl.defaultLocale] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }
}

$className get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

const List<Locale> supportedLocales = [
  ${config.fallbackLocales.keys.where((String language) => language != '*').map((String language) => "Locale('$language'),").join('\n')}
  ${languages.map((String language) => "Locale('$language'),").join('\n')}
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
