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
  ${localizations.map((LanguageLocalization localization) => "'${localization.language}': ${localization.language},").join('\n')}
};    

class LocalizationDelegate extends LocalizationsDelegate<$className> {
  @override
  bool isSupported(Locale locale) => _languageMap.keys.contains(locale.languageCode);

  @override
  Future<$className> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();
    return _languageMap[locale.languageCode]!;
  }

  @override
  bool shouldReload(LocalizationsDelegate<$className> old) => false;
}

class Messages {
  static $className of(BuildContext context) => Localizations.of(context, $className)!;

  static $className getContent(String language) => _languageMap[language] as $className;
  
  static $className get el {
    if (Intl.defaultLocale == null) {
      throw Exception('Default locale is not setup');
    }
    return _languageMap[Intl.defaultLocale]!;
  }
}

$className get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  LocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates
];

const List<Locale> supportedLocales = [
  ${languages.map((String language) => "Locale('$language'),").join('\n')}
];

extension EasiestLocalization on BuildContext {
  $className get el {
    return Messages.of(this);
  }
}
''';
  }
}
