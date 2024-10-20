/// This is generated content. There is no point to change it by hands.

// ignore_for_file: type=lint

import 'dart:developer' show log;

import 'package:easiest_localization/easiest_localization.dart'
    show LocalizationProvider;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart'
    show BuildContext, Locale, Localizations, LocalizationsDelegate;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalMaterialLocalizations;
import 'package:intl/intl.dart' show Intl;

final RegExp _variableRegExp = RegExp(r'\$\{[^}]+\} ?');

typedef Checker<T> = bool Function(T value);

const String localizationPackageVersion = r'1.0.0';

const String? localizationVersion = null;

enum Gender {
  male,
  female,
  other,
}

class MainScreen {
  const MainScreen({
    required this.greetings,
    required this.books,
    required this.todayDateFormat,
    required this.welcome,
  });

  factory MainScreen.fromJson(Map<String, dynamic> json) {
    return MainScreen(
      greetings: ({required String username}) => (json['greetings'] ?? '')
          .toString()
          .replaceAll(r'${username}', username)
          .replaceAll(_variableRegExp, ''),
      books: MainScreenBooks.fromJson(
          (json['books'] as Map).cast<String, dynamic>()),
      todayDateFormat: (json['today_date_format'] ?? '').toString(),
      welcome: (json['welcome'] ?? '').toString(),
    );
  }

  final String Function({required String username}) greetings;

  final MainScreenBooks books;

  final String todayDateFormat;
  final String welcome;

  Map<String, Object> get _content => {
        r'''greetings''': greetings,
        r'''books''': books,
        r'''today_date_format''': todayDateFormat,
        r'''welcome''': welcome,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key with type $T');
  }

  Map<String, Object> get content => _content;

  List<Object> get contentList => _content.values.toList();

  int get length => _content.length;

  Object? operator [](Object? key) {
    final Object? value = _content[key];
    if (value == null && key is String) {
      final int? index = int.tryParse(key);
      if (index == null || index >= contentList.length || index < 0) {
        return null;
      }

      return contentList[index];
    }
    return value;
  }
}

class MainScreenBooks {
  const MainScreenBooks({
    required this.add,
    required this.amountOfNew,
  });

  factory MainScreenBooks.fromJson(Map<String, dynamic> json) {
    return MainScreenBooks(
      add: (json['add'] ?? '').toString(),
      amountOfNew: (num howMany, {int? precision}) => Intl.plural(
        howMany,
        name: 'amount_of_new',
        zero: json['amount_of_new']['zero'] == null ||
                json['amount_of_new']['zero'].toString().trim() == ''
            ? null
            : json['amount_of_new']['zero']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString()),
        one: (json['amount_of_new']['one'] ?? '')
            .toString()
            .replaceAll(r'${howMany}', howMany.toString()),
        two: json['amount_of_new']['two'] == null ||
                json['amount_of_new']['two'].toString().trim() == ''
            ? null
            : json['amount_of_new']['two']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString()),
        few: json['amount_of_new']['few'] == null ||
                json['amount_of_new']['few'].toString().trim() == ''
            ? null
            : json['amount_of_new']['few']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString()),
        many: json['amount_of_new']['many'] == null ||
                json['amount_of_new']['many'].toString().trim() == ''
            ? null
            : json['amount_of_new']['many']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString()),
        other: (json['amount_of_new']['other'] ?? '')
            .toString()
            .replaceAll(r'${howMany}', howMany.toString()),
        precision: precision,
      ),
    );
  }

  final String add;

  final String Function(num howMany, {int? precision}) amountOfNew;

  Map<String, Object> get _content => {
        r'''add''': add,
        r'''amount_of_new''': amountOfNew,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key with type $T');
  }

  Map<String, Object> get content => _content;

  List<Object> get contentList => _content.values.toList();

  int get length => _content.length;

  Object? operator [](Object? key) {
    final Object? value = _content[key];
    if (value == null && key is String) {
      final int? index = int.tryParse(key);
      if (index == null || index >= contentList.length || index < 0) {
        return null;
      }

      return contentList[index];
    }
    return value;
  }
}

class Employees {
  const Employees({
    required this.n0,
    required this.n1,
    required this.n2,
    required this.n3,
    required this.n4,
  });

  factory Employees.fromJson(Map<String, dynamic> json) {
    return Employees(
      n0: (json['0'] ?? '').toString(),
      n1: (json['1'] ?? '').toString(),
      n2: (json['2'] ?? '').toString(),
      n3: (json['3'] ?? '').toString(),
      n4: (json['4'] ?? '').toString(),
    );
  }

  final String n0;
  final String n1;
  final String n2;
  final String n3;
  final String n4;

  Map<String, Object> get _content => {
        r'''0''': n0,
        r'''1''': n1,
        r'''2''': n2,
        r'''3''': n3,
        r'''4''': n4,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key with type $T');
  }

  Map<String, Object> get content => _content;

  List<Object> get contentList => _content.values.toList();

  int get length => _content.length;

  Object? operator [](Object? key) {
    final Object? value = _content[key];
    if (value == null && key is String) {
      final int? index = int.tryParse(key);
      if (index == null || index >= contentList.length || index < 0) {
        return null;
      }

      return contentList[index];
    }
    return value;
  }
}

class LocalizationMessages {
  LocalizationMessages({
    required this.appTitle,
    required this.language,
    required this.mainScreen,
    required this.author,
    required this.privacyPolicyUrl,
    required this.employees,
    required this.source,
  });

  factory LocalizationMessages.fromJson(Map<String, dynamic> json) {
    return LocalizationMessages(
      appTitle: (json['app_title'] ?? '').toString(),
      language: ({required String language, required String country}) =>
          (json['language'] ?? '')
              .toString()
              .replaceAll(r'${language}', language)
              .replaceAll(r'${country}', country)
              .replaceAll(_variableRegExp, ''),
      mainScreen: MainScreen.fromJson(
          (json['main_screen'] as Map).cast<String, dynamic>()),
      author: (Gender gender, {required String name}) => Intl.gender(
        gender.name,
        name: 'author',
        female: json['author']['female'] == null ||
                json['author']['female'].toString().trim() == ''
            ? null
            : json['author']['female']
                .toString()
                .replaceAll(r'${name}', name)
                .replaceAll(_variableRegExp, ''),
        male: json['author']['male'] == null ||
                json['author']['male'].toString().trim() == ''
            ? null
            : json['author']['male']
                .toString()
                .replaceAll(r'${name}', name)
                .replaceAll(_variableRegExp, ''),
        other: (json['author']['other'] ?? '')
            .toString()
            .replaceAll(r'${name}', name)
            .replaceAll(_variableRegExp, ''),
      ),
      privacyPolicyUrl: (json['privacy_policy_url'] ?? '').toString(),
      employees: Employees.fromJson(
          (json['employees'] as Map).cast<String, dynamic>()),
      source: (json['source'] ?? '').toString(),
    );
  }

  final String appTitle;
  final String Function({required String language, required String country})
      language;

  final MainScreen mainScreen;

  final String Function(Gender gender, {required String name}) author;

  final String privacyPolicyUrl;
  final Employees employees;

  final String source;

  Map<String, Object> get _content => {
        r'''app_title''': appTitle,
        r'''language''': language,
        r'''main_screen''': mainScreen,
        r'''author''': author,
        r'''privacy_policy_url''': privacyPolicyUrl,
        r'''employees''': employees,
        r'''source''': source,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key with type $T');
  }

  Map<String, Object> get content => _content;

  List<Object> get contentList => _content.values.toList();

  int get length => _content.length;

  Object? operator [](Object? key) {
    final Object? value = _content[key];
    if (value == null && key is String) {
      final int? index = int.tryParse(key);
      if (index == null || index >= contentList.length || index < 0) {
        return null;
      }

      return contentList[index];
    }
    return value;
  }
}

final LocalizationMessages en = LocalizationMessages(
  appTitle: 'Library App',
  language: ({required String language, required String country}) =>
      '''Lang: ${language}''',
  mainScreen: MainScreen(
    greetings: ({required String username}) => '''Hello, ${username}!''',
    books: MainScreenBooks(
      add: 'Add Book',
      amountOfNew: (num howMany, {int? precision}) => Intl.plural(
        howMany,
        name: 'amount_of_new',
        zero: 'There are no new books available at the moment :(',
        one: '''There is ${howMany} new book available :)''',
        two: null,
        few: null,
        many: null,
        other: '''There are ${howMany} new books available :)''',
        precision: precision,
      ),
    ),
    todayDateFormat: 'MM/dd/yyyy',
    welcome: '''# Welcome to our library!
---
## We are very happy to see you and would like you to enjoy reading our books.
''',
  ),
  author: (Gender gender, {required String name}) => Intl.gender(
    gender.name,
    name: 'author',
    female: '''${name} - she is the author of that book!''',
    male: '''${name} - he is the author of that book!''',
    other: '''${name} - they are the author of that book!''',
  ),
  privacyPolicyUrl: 'https://library.app/privacy_us.pdf',
  employees: Employees(
    n0: 'John Smith',
    n1: 'Alice Johnson',
    n2: 'Michael Brown',
    n3: 'Emma Davis',
    n4: 'William Taylor',
  ),
  source: 'Easiest Localization',
);
final LocalizationMessages ru = LocalizationMessages(
  appTitle: 'Библиотека',
  language: ({required String language, required String country}) =>
      '''Язык: ${language}''',
  mainScreen: MainScreen(
    greetings: ({required String username}) => '''Привет, ${username}!''',
    books: MainScreenBooks(
      add: 'Добавить книгу',
      amountOfNew: (num howMany, {int? precision}) => Intl.plural(
        howMany,
        name: 'amount_of_new',
        zero: 'В настоящий момент доступных новых книг нет :(',
        one: '''В настоящий момент доступна ${howMany} новая книга :)''',
        two: '''В настоящий момент доступны ${howMany} новые книги :)''',
        few: '''В настоящий момент доступно ${howMany} новые книги :)''',
        many: '''В настоящий момент доступно ${howMany} новых книг :)''',
        other: '''В настоящий момент доступно ${howMany} новые книги :)''',
        precision: precision,
      ),
    ),
    todayDateFormat: 'dd MMM yyyy',
    welcome: '''# Добро пожаловать в нашу библиотеку!
---
## Мы очень рады вас видеть и хотели бы, чтобы вы получали удовольствие от чтения наших книг.
''',
  ),
  author: (Gender gender, {required String name}) => Intl.gender(
    gender.name,
    name: 'author',
    female: '''${name} - она автор этой книги!''',
    male: '''${name} - он автор этой книги!''',
    other: '''${name} - автор этой книги!''',
  ),
  privacyPolicyUrl: 'https://library.app/privacy_ru.pdf',
  employees: Employees(
    n0: 'Джон Смит',
    n1: 'Алиса Джонсон',
    n2: 'Майкл Браун',
    n3: 'Эмма Дэвис',
    n4: 'Уильям Тейлор',
  ),
  source: '',
);
final LocalizationMessages en_CA = LocalizationMessages(
  appTitle: 'Library App',
  language: ({required String language, required String country}) =>
      '''Lang: ${language}; Country: ${country}''',
  mainScreen: MainScreen(
    greetings: ({required String username}) => '''Hello, ${username}!''',
    books: MainScreenBooks(
      add: 'Add Book',
      amountOfNew: (num howMany, {int? precision}) => Intl.plural(
        howMany,
        name: 'amount_of_new',
        zero: 'There are no new books available at the moment :(',
        one: '''There is ${howMany} new book available :)''',
        two: null,
        few: null,
        many: null,
        other: '''There are ${howMany} new books available :)''',
        precision: precision,
      ),
    ),
    todayDateFormat: 'dd/MM/yyyy',
    welcome: '''# Welcome to our library!
---
## We are very happy to see you and would like you to enjoy reading our books.
''',
  ),
  author: (Gender gender, {required String name}) => Intl.gender(
    gender.name,
    name: 'author',
    female: '''${name} - she is the author of that book!''',
    male: '''${name} - he is the author of that book!''',
    other: '''${name} - they are the author of that book!''',
  ),
  privacyPolicyUrl: 'https://library.app/privacy_ca.pdf',
  employees: Employees(
    n0: 'John Smith',
    n1: 'Alice Johnson',
    n2: 'Michael Brown',
    n3: 'Emma Davis',
    n4: 'William Taylor',
  ),
  source: 'Easiest Localization',
);
final Map<Locale, LocalizationMessages> _languageMap = {
  Locale('en'): en,
  Locale('ru'): ru,
  Locale('en', 'CA'): en_CA,
};

final Map<Locale, LocalizationMessages> _providersLanguagesMap = {};

class EasiestLocalizationDelegate
    extends LocalizationsDelegate<LocalizationMessages> {
  EasiestLocalizationDelegate({
    List<LocalizationProvider<LocalizationMessages>> providers = const [],
  }) {
    providers.forEach(registerProvider);
  }

  final List<LocalizationProvider<LocalizationMessages>> _providers = [];

  void registerProvider(LocalizationProvider<LocalizationMessages> provider) {
    _providers.add(provider);
  }

  @override
  bool isSupported(Locale locale) {
    final bool supportedByProviders =
        _providers.any((LocalizationProvider value) => value.canLoad(locale));
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

  Future<LocalizationMessages> load(Locale locale) async {
    Intl.defaultLocale = locale.toString();

    LocalizationProvider<LocalizationMessages>? localizationProvider;

    for (final LocalizationProvider<LocalizationMessages> provider
        in _providers) {
      if (provider.canLoad(locale)) {
        localizationProvider = provider;
        break;
      }
    }

    LocalizationMessages? localeContent;

    if (localizationProvider != null) {
      try {
        localeContent = await localizationProvider.fetchLocalization(locale);
        _providersLanguagesMap[locale] = localeContent;
      } catch (error, stackTrace) {
        log('Error on loading localization with provider "${localizationProvider.name}"',
            error: error, stackTrace: stackTrace);
      }
    }

    localeContent ??= _loadLocalLocale(locale) ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) =>
      old != this;
}

class Messages {
  static LocalizationMessages of(BuildContext context) =>
      Localizations.of(context, LocalizationMessages)!;

  static LocalizationMessages? getContent(Locale locale) =>
      _loadLocalLocale(locale);

  static LocalizationMessages get el {
    final String? defaultLocaleString = Intl.defaultLocale;
    final List<String> localeParticles = defaultLocaleString == null
        ? []
        : defaultLocaleString.split(RegExp(r'[_-]'));
    final Locale? defaultLocale = localeParticles.isEmpty
        ? null
        : Locale(localeParticles.first,
            localeParticles.length > 1 ? localeParticles[1] : null);
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

LocalizationMessages get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

List<LocalizationsDelegate> localizationsDelegatesWithProviders(
    List<LocalizationProvider<LocalizationMessages>> providers) {
  return [
    EasiestLocalizationDelegate(providers: providers),
    ...GlobalMaterialLocalizations.delegates,
  ];
}

// Supported locales: en, ru, en_CA
const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('ru'),
  Locale('en', 'CA'),
];

List<Locale> supportedLocalesWithProviders(
        List<LocalizationProvider<LocalizationMessages>> providers) =>
    [
      for (final LocalizationProvider provider in providers)
        ...provider.supportedLocales,
      ...supportedLocales,
    ];

extension EasiestLocalizationContext on BuildContext {
  LocalizationMessages get el {
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
            print(
                '[ERROR] Incorrect retrieving of value by key "$key" from value "$targetContent"; Original key was "$this"');
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
