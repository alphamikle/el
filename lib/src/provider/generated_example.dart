/// This is generated content. There is no point in changing it by hand.

// ignore_for_file: type=lint

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

enum Gender {
  male,
  female,
  other,
}

/// ! OK
class Pages {
  const Pages({
    required this.home,
    required this.settings,
    required this.profile,
    required this.product,
  });

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      home: PagesHome.fromJson(json['home']),
      settings: PagesSettings.fromJson(json['settings']),
      profile: PagesProfile.fromJson(json['profile']),
      product: PagesProduct.fromJson(json['product']),
    );
  }

  final PagesHome home;

  final PagesSettings settings;

  final PagesProfile profile;

  final PagesProduct product;

  Map<String, Object> get _content => {
        'home': home,
        'settings': settings,
        'profile': profile,
        'product': product,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

/// ! OK
class PagesHome {
  const PagesHome({
    required this.title,
    required this.description,
    required this.counter,
    required this.incrementButton,
  });

  factory PagesHome.fromJson(Map<String, dynamic> json) {
    return PagesHome(
      title: json['title'],
      description: json['description'],
      counter: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''counter''',
        one: json['counter']['one'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''You have pushed the button ${howMany} many time'''
        other: json['counter']['other'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''You have pushed the button ${howMany} many times'''
        precision: precision,
      ),
      incrementButton: PagesHomeIncrementButton.fromJson(json['incrementButton']),
    );
  }

  final String title;

  final String description;

  final String Function(int howMany, {int? precision}) counter;

  final PagesHomeIncrementButton incrementButton;

  Map<String, Object> get _content => {
        'title': title,
        'description': description,
        'counter': counter,
        'incrementButton': incrementButton,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

/// ! OK
class PagesHomeIncrementButton {
  const PagesHomeIncrementButton({
    required this.title,
  });

  factory PagesHomeIncrementButton.fromJson(Map<String, dynamic> json) {
    return PagesHomeIncrementButton(
      title: json['title'],
    );
  }

  final String title;

  Map<String, Object> get _content => {
        'title': title,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

/// ! OK
class PagesSettings {
  const PagesSettings({
    required this.title,
    required this.description,
  });

  factory PagesSettings.fromJson(Map<String, dynamic> json) {
    return PagesSettings(
      title: json['title'],
      description: json['description'],
    );
  }

  final String title;

  final String description;

  Map<String, Object> get _content => {
        'title': title,
        'description': description,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

/// ! OK
class PagesProfile {
  const PagesProfile({
    required this.title,
    required this.description,
  });

  factory PagesProfile.fromJson(Map<String, dynamic> json) {
    return PagesProfile(
      title: json['title'],
      description: json['description'],
    );
  }

  /// Profile page content
  final String title;

  final String description;

  Map<String, Object> get _content => {
        'title': title,
        'description': description,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

/// ! OK
class PagesProduct {
  const PagesProduct({
    required this.title,
  });

  factory PagesProduct.fromJson(Map<String, dynamic> json) {
    return PagesProduct(
      title: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''title''',
        zero: json['title']['zero'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        one: json['title']['one'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} product'''
        two: json['title']['two'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        few: json['title']['few'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        many: json['title']['many'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        other: json['title']['other'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        precision: precision,
      ),
    );
  }

  /// How many products do we have?
  final String Function(int howMany, {int? precision}) title;

  Map<String, Object> get _content => {
        'title': title,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

/// ! OK
class Greetings3 {
  const Greetings3({
    required this.home,
    required this.settings,
    required this.custom,
  });

  factory Greetings3.fromJson(Map<String, dynamic> json) {
    return Greetings3(
      home: ({required String username}) => json['home'].toString().replaceAll(r'${username}', username), // '''Hello, ${username} at home page!'''
      settings: ({required String username}) => json['settings'].toString().replaceAll(r'${username}', username), // '''Hello, ${username} at settings page!'''
      // '''Hello, ${username} at ${page} page!'''
      custom: ({required String username, required String page}) => json['custom'].toString().replaceAll(r'${username}', username).replaceAll(r'${page}', page),
    );
  }

  final String Function({required String username}) home;

  final String Function({required String username}) settings;

  final String Function({required String username, required String page}) custom;

  Map<String, Object> get _content => {
        'home': home,
        'settings': settings,
        'custom': custom,
      };

  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

/// ! OK
class LocalizationMessages {
  LocalizationMessages({
    required this.title,
    required this.intro,
    required this.product,
    required this.pages,
    required this.greetings,
    required this.greetings2,
    required this.greetings3,
    required this.aboutCows,
  });

  factory LocalizationMessages.fromJson(Map<String, dynamic> json) {
    return LocalizationMessages(
      title: json['title'],
      intro: json['intro'],
      product: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''product''',
        zero: json['product']['zero'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        one: json['product']['one'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} product'''
        two: json['product']['two'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        few: json['product']['few'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        many: json['product']['many'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        other: json['product']['other'].toString().replaceAll(r'${howMany}', howMany.toString()), // '''There are ${howMany} products'''
        precision: precision,
      ),
      pages: Pages.fromJson(json['pages']),
      greetings: ({required String username}) => json['greetings'].toString().replaceAll(r'${username}', username), // '''Hello, ${username}!'''
      greetings2: ({required String username}) => json['greetings2'].toString().replaceAll(r'${username}', username), // '''Hello, dear ${username}!'''
      greetings3: Greetings3.fromJson(json['greetings3']),
      aboutCows: (int howMany, {required String username, int? precision}) => Intl.plural(
        howMany,
        name: '''aboutCows''',
        // '''Maybe there are ${howMany} cow? What do you think, ${username}?'''
        one: json['aboutCows']['one'].toString().replaceAll(r'${howMany}', howMany.toString()).replaceAll(r'${username}', username),
        // '''Maybe there are ${howMany} cows? What do you think, ${username}?''',
        other: json['aboutCows']['other'].toString().replaceAll(r'${howMany}', howMany.toString()).replaceAll(r'${username}', username),
        precision: precision,
      ),
    );
  }

  final String title;

  /// For some reason we decided to use exactly that title for that screen
  final String intro;

  /// How many products do we have?
  final String Function(int howMany, {int? precision}) product;

  final Pages pages;

  final String Function({required String username}) greetings;

  /// This is greetings with an argument [username]
  final String Function({required String username}) greetings2;

  final Greetings3 greetings3;

  final String Function(int howMany, {required String username, int? precision}) aboutCows;

  Map<String, Object> get _content => {
        'title': title,
        'intro': intro,
        'product': product,
        'pages': pages,
        'greetings': greetings,
        'greetings2': greetings2,
        'greetings3': greetings3,
        'aboutCows': aboutCows,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }

  dynamic operator [](Object? key) {
    return _content[key];
  }
}

final LocalizationMessages en = LocalizationMessages(
  title: '''Easiest Localization App''',
  intro: '''This is a intro screen title''',
  product: (int howMany, {int? precision}) => Intl.plural(
    howMany,
    name: '''product''',
    zero: '''There are ${howMany} products''',
    one: '''There are ${howMany} product''',
    two: '''There are ${howMany} products''',
    few: '''There are ${howMany} products''',
    many: '''There are ${howMany} products''',
    other: '''There are ${howMany} products''',
    precision: precision,
  ),
  pages: Pages(
    home: PagesHome(
      title: '''Home''',
      description: '''Here you can see the main content''',
      counter: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''counter''',
        one: '''You have pushed the button ${howMany} many time''',
        other: '''You have pushed the button ${howMany} many times''',
        precision: precision,
      ),
      incrementButton: PagesHomeIncrementButton(
        title: '''Increment''',
      ),
    ),
    settings: PagesSettings(
      title: '''Settings''',
      description: '''Here you can change your settings''',
    ),
    profile: PagesProfile(
      title: '''Profile''',
      description: '''Here you can see your personal info and change it''',
    ),
    product: PagesProduct(
      title: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''title''',
        zero: '''There are ${howMany} products''',
        one: '''There are ${howMany} product''',
        two: '''There are ${howMany} products''',
        few: '''There are ${howMany} products''',
        many: '''There are ${howMany} products''',
        other: '''There are ${howMany} products''',
        precision: precision,
      ),
    ),
  ),
  greetings: ({required String username}) => '''Hello, ${username}!''',
  greetings2: ({required String username}) => '''Hello, dear ${username}!''',
  greetings3: Greetings3(
    home: ({required String username}) => '''Hello, ${username} at home page!''',
    settings: ({required String username}) => '''Hello, ${username} at settings page!''',
    custom: ({required String username, required String page}) => '''Hello, ${username} at ${page} page!''',
  ),
  aboutCows: (int howMany, {required String username, int? precision}) => Intl.plural(
    howMany,
    name: '''aboutCows''',
    one: '''Maybe there are ${howMany} cow? What do you think, ${username}?''',
    other: '''Maybe there are ${howMany} cows? What do you think, ${username}?''',
    precision: precision,
  ),
);

final Map<String, LocalizationMessages> _languageMap = {
  'en': en,
};

class EasiestLocalizationDelegate extends LocalizationsDelegate<LocalizationMessages> {
  @override
  bool isSupported(Locale locale) => _languageMap.keys.contains(locale.languageCode);

  @override
  Future<LocalizationMessages> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();
    final LocalizationMessages localeContent = _languageMap[locale.languageCode] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) => false;
}

class Messages {
  static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages)!;

  static LocalizationMessages? getContent(String language) => _languageMap[language];

  static LocalizationMessages get el {
    final LocalizationMessages localeContent = _languageMap[Intl.defaultLocale] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }
}

LocalizationMessages get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

const List<Locale> supportedLocales = [
  Locale('en'),
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
            print('[ERROR] Incorrect retrieving of value by key "$key" from value "$targetContent"; Original key was "$this"');
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
