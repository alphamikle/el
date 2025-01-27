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

class ContentList extends Iterable<Object?> {
  const ContentList(this._contentList);

  final List<Object?> _contentList;

  Object? at(int index) {
    if (index >= _contentList.length || index < 0) {
      return null;
    }
    return _contentList[index];
  }

  Object? operator [](int index) => at(index);

  Iterator<Object?> get iterator => _contentList.iterator;
}

class ContentMap extends Iterable<MapEntry<String, Object?>> {
  const ContentMap(this._contentMap);

  final Map<String, Object?> _contentMap;

  Object? at(String key) => _contentMap[key];

  Object? operator [](String key) => at(key);

  Iterator<MapEntry<String, Object?>> get iterator =>
      _contentMap.entries.iterator;
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

class Users {
  const Users({
    required this.cities,
  });
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      cities:
          UsersCities.fromJson((json['cities'] as Map).cast<String, dynamic>()),
    );
  }
  final UsersCities cities;

  Map<String, Object> get _content => {
        r'''cities''': cities,
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

class UsersCities {
  const UsersCities({
    required this.mainCity,
  });
  factory UsersCities.fromJson(Map<String, dynamic> json) {
    return UsersCities(
      mainCity: ContentList(
          (json['main_city*'] ?? json['main_city']) is List<Object?>
              ? (json['main_city*'] ?? json['main_city'])
              : <Object?>[]),
    );
  }
  final ContentList mainCity;
  Map<String, Object> get _content => {
        r'''main_city*''': mainCity,
        r'''main_city''': mainCity,
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

class DynamicMapInside {
  const DynamicMapInside({
    required this.categories,
  });
  factory DynamicMapInside.fromJson(Map<String, dynamic> json) {
    return DynamicMapInside(
      categories: ContentMap(
          (json['categories*'] ?? json['categories']) is Map<String, Object?>
              ? (json['categories*'] ?? json['categories'])
              : <String, Object?>{}),
    );
  }
  final ContentMap categories;
  Map<String, Object> get _content => {
        r'''categories*''': categories,
        r'''categories''': categories,
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

class OurAchievements {
  const OurAchievements({
    required this.bulletPoints,
  });
  factory OurAchievements.fromJson(Map<String, dynamic> json) {
    return OurAchievements(
      bulletPoints: ContentList(
          (json['bullet_points*'] ?? json['bullet_points']) is List<Object?>
              ? (json['bullet_points*'] ?? json['bullet_points'])
              : <Object?>[]),
    );
  }
  final ContentList bulletPoints;
  Map<String, Object> get _content => {
        r'''bullet_points*''': bulletPoints,
        r'''bullet_points''': bulletPoints,
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
    required this.source,
    required this.appTitle,
    required this.language,
    required this.mainScreen,
    required this.author,
    required this.privacyPolicyUrl,
    required this.employees,
    required this.dynamicListOfStrings,
    required this.dynamicListOfObjects,
    required this.users,
    required this.dynamicMapInside,
    required this.categories,
    required this.ourAchievements,
  });
  factory LocalizationMessages.fromJson(Map<String, dynamic> json) {
    return LocalizationMessages(
      source: (json['source'] ?? '').toString(),
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
      employees: ContentList(
          (json['employees*'] ?? json['employees']) is List<Object?>
              ? (json['employees*'] ?? json['employees'])
              : <Object?>[]),
      dynamicListOfStrings: ContentList((json['dynamic_list_of_strings*'] ??
              json['dynamic_list_of_strings']) is List<Object?>
          ? (json['dynamic_list_of_strings*'] ??
              json['dynamic_list_of_strings'])
          : <Object?>[]),
      dynamicListOfObjects: ContentList((json['dynamic_list_of_objects*'] ??
              json['dynamic_list_of_objects']) is List<Object?>
          ? (json['dynamic_list_of_objects*'] ??
              json['dynamic_list_of_objects'])
          : <Object?>[]),
      users: Users.fromJson((json['users'] as Map).cast<String, dynamic>()),
      dynamicMapInside: DynamicMapInside.fromJson(
          (json['dynamic_map_inside'] as Map).cast<String, dynamic>()),
      categories: ContentMap(
          (json['categories*'] ?? json['categories']) is Map<String, Object?>
              ? (json['categories*'] ?? json['categories'])
              : <String, Object?>{}),
      ourAchievements: OurAchievements.fromJson(
          (json['our_achievements'] as Map).cast<String, dynamic>()),
    );
  }
  final String source;
  final String appTitle;
  final String Function({required String language, required String country})
      language;

  final MainScreen mainScreen;

  final String Function(Gender gender, {required String name}) author;

  final String privacyPolicyUrl;
  final ContentList employees;
  final ContentList dynamicListOfStrings;
  final ContentList dynamicListOfObjects;
  final Users users;

  final DynamicMapInside dynamicMapInside;

  final ContentMap categories;
  final OurAchievements ourAchievements;

  Map<String, Object> get _content => {
        r'''source''': source,
        r'''app_title''': appTitle,
        r'''language''': language,
        r'''main_screen''': mainScreen,
        r'''author''': author,
        r'''privacy_policy_url''': privacyPolicyUrl,
        r'''employees*''': employees,
        r'''employees''': employees,
        r'''dynamic_list_of_strings*''': dynamicListOfStrings,
        r'''dynamic_list_of_strings''': dynamicListOfStrings,
        r'''dynamic_list_of_objects*''': dynamicListOfObjects,
        r'''dynamic_list_of_objects''': dynamicListOfObjects,
        r'''users''': users,
        r'''dynamic_map_inside''': dynamicMapInside,
        r'''categories*''': categories,
        r'''categories''': categories,
        r'''our_achievements''': ourAchievements,
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
  source: 'Easiest Localization',
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
  employees: ContentList([
    "John Smith",
    "Alice Johnson",
    "Michael Brown",
    "Emma Davis",
    "William Taylor",
    "Mr. Nobody"
  ]),
  dynamicListOfStrings:
      ContentList(["John Smith", "Alex Black", "Mike Fart", "Pick Chart"]),
  dynamicListOfObjects: ContentList([
    {"id": 123, "name": "Mike", "lastname": "Alfa"},
    {"id": 456, "name": "John", "lastname": "Pies"}
  ]),
  users: Users(
    cities: UsersCities(
      mainCity: ContentList([
        {"id": 1, "name": "Mike"},
        {"id": 2, "name": "Alena"},
        {"id": 3, "name": "Grace"}
      ]),
    ),
  ),
  dynamicMapInside: DynamicMapInside(
    categories: ContentMap({
      "abc": "Hello",
      "bcd": "How are you?",
      "cde": "We are here!",
      "def": "Let's go with us!",
      "efg": {"id": 123, "name": "Mike", "talk": true}
    }),
  ),
  categories:
      ContentMap({"1": "Sport", "2": "Fun", "3": "Cinema", "4": "Guns"}),
  ourAchievements: OurAchievements(
    bulletPoints: ContentList([
      {
        "title": "Best UI/UX Design",
        "subtitle": "Awarded by Design Critics International 2022"
      },
      {
        "title": "1M+ Downloads",
        "subtitle": "Achieved within the first month of release"
      },
      {
        "title": "Rising Star Startup",
        "subtitle": "Recognized by Global Tech Summit 2023"
      },
      {
        "title": "99% Crash-Free Rate",
        "subtitle": "Verified by App Health Monitor"
      },
      {
        "title": "Multi-Platform Support",
        "subtitle": "Fully functional on iOS, Android, and the Web"
      }
    ]),
  ),
);
final LocalizationMessages ru = LocalizationMessages(
  source: 'Easiest Localization',
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
  employees: ContentList([
    "Джон Смит",
    "Алиса Джонсон",
    "Майкл Браун",
    "Эмма Дэвис",
    "Уильям Тейлор",
    "Mr. Nobody"
  ]),
  dynamicListOfStrings:
      ContentList(["John Smith", "Alex Black", "Mike Fart", "Pick Chart"]),
  dynamicListOfObjects: ContentList([
    {"id": 123, "name": "Mike", "lastname": "Alfa"},
    {"id": 456, "name": "John", "lastname": "Pies"}
  ]),
  users: Users(
    cities: UsersCities(
      mainCity: ContentList([
        {"id": 1, "name": "Mike"},
        {"id": 2, "name": "Alena"},
        {"id": 3, "name": "Grace"}
      ]),
    ),
  ),
  dynamicMapInside: DynamicMapInside(
    categories: ContentMap({
      "abc": "Hello",
      "bcd": "How are you?",
      "cde": "We are here!",
      "def": "Let's go with us!",
      "efg": {"id": 123, "name": "Mike", "talk": true}
    }),
  ),
  categories:
      ContentMap({"1": "Sport", "2": "Fun", "3": "Cinema", "4": "Guns"}),
  ourAchievements: OurAchievements(
    bulletPoints: ContentList([
      {
        "title": "Best UI/UX Design",
        "subtitle": "Awarded by Design Critics International 2022"
      },
      {
        "title": "1M+ Downloads",
        "subtitle": "Achieved within the first month of release"
      },
      {
        "title": "Rising Star Startup",
        "subtitle": "Recognized by Global Tech Summit 2023"
      },
      {
        "title": "99% Crash-Free Rate",
        "subtitle": "Verified by App Health Monitor"
      },
      {
        "title": "Multi-Platform Support",
        "subtitle": "Fully functional on iOS, Android, and the Web"
      }
    ]),
  ),
);
final LocalizationMessages en_CA = LocalizationMessages(
  source: 'Easiest Localization',
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
  employees: ContentList([
    "John Smith",
    "Alice Johnson",
    "Michael Brown",
    "Emma Davis",
    "William Taylor",
    "Mr. Nobody"
  ]),
  dynamicListOfStrings:
      ContentList(["John Smith", "Alex Black", "Mike Fart", "Pick Chart"]),
  dynamicListOfObjects: ContentList([
    {"id": 123, "name": "Mike", "lastname": "Alfa"},
    {"id": 456, "name": "John", "lastname": "Pies"}
  ]),
  users: Users(
    cities: UsersCities(
      mainCity: ContentList([
        {"id": 1, "name": "Mike"},
        {"id": 2, "name": "Alena"},
        {"id": 3, "name": "Grace"}
      ]),
    ),
  ),
  dynamicMapInside: DynamicMapInside(
    categories: ContentMap({
      "abc": "Hello",
      "bcd": "How are you?",
      "cde": "We are here!",
      "def": "Let's go with us!",
      "efg": {"id": 123, "name": "Mike", "talk": true}
    }),
  ),
  categories:
      ContentMap({"1": "Sport", "2": "Fun", "3": "Cinema", "4": "Guns"}),
  ourAchievements: OurAchievements(
    bulletPoints: ContentList([
      {
        "title": "Best UI/UX Design",
        "subtitle": "Awarded by Design Critics International 2022"
      },
      {
        "title": "1M+ Downloads",
        "subtitle": "Achieved within the first month of release"
      },
      {
        "title": "Rising Star Startup",
        "subtitle": "Recognized by Global Tech Summit 2023"
      },
      {
        "title": "99% Crash-Free Rate",
        "subtitle": "Verified by App Health Monitor"
      },
      {
        "title": "Multi-Platform Support",
        "subtitle": "Fully functional on iOS, Android, and the Web"
      }
    ]),
  ),
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
