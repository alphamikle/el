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

class Pages {
  const Pages({
    required this.home,
    required this.settings,
    required this.profile,
    required this.product,
  });
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

class PagesHome {
  const PagesHome({
    required this.title,
    required this.description,
    required this.counter,
    required this.incrementButton,
  });
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

class PagesHomeIncrementButton {
  const PagesHomeIncrementButton({
    required this.title,
  });
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

class PagesSettings {
  const PagesSettings({
    required this.title,
    required this.description,
  });
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

class PagesProfile {
  const PagesProfile({
    required this.title,
    required this.description,
  });
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

class PagesProduct {
  const PagesProduct({
    required this.title,
  });

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

class Greetings3 {
  const Greetings3({
    required this.home,
    required this.settings,
    required this.custom,
  });
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

class LocalizationMessages {
  LocalizationMessages({
    required this.title,
    required this.intro,
    required this.product,
    required this.bookAfterwords,
    required this.pages,
    required this.greetings,
    required this.greetings2,
    required this.greetings3,
    required this.aboutCows,
  });
  final String title;

  /// For some reason we decided to use exactly that title for that screen
  final String intro;

  /// How many products do we have?
  final String Function(int howMany, {int? precision}) product;

  /// What the user will see, after he read the book
  final String Function(Gender gender, {required String username}) bookAfterwords;

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
        'bookAfterwords': bookAfterwords,
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

final LocalizationMessages fr = LocalizationMessages(
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
  bookAfterwords: (Gender gender, {required String username}) => Intl.gender(
    gender.name,
    name: '''bookAfterwords''',
    female: '''Thank you for reading, ms. ${username}!''',
    male: '''Thank you for reading, mr. ${username}!''',
    other: '''Thank you for reading, dear ${username}!''',
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
  bookAfterwords: (Gender gender, {required String username}) => Intl.gender(
    gender.name,
    name: '''bookAfterwords''',
    female: '''Thank you for reading, ms. ${username}!''',
    male: '''Thank you for reading, mr. ${username}!''',
    other: '''Thank you for reading, dear ${username}!''',
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
final LocalizationMessages ru = LocalizationMessages(
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
  bookAfterwords: (Gender gender, {required String username}) => Intl.gender(
    gender.name,
    name: '''bookAfterwords''',
    female: '''Thank you for reading, ms. ${username}!''',
    male: '''Thank you for reading, mr. ${username}!''',
    other: '''Thank you for reading, dear ${username}!''',
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
  '*': en,
  'fr': fr,
  'en': en,
  'ru': ru,
};

class EasiestLocalizationDelegate extends LocalizationsDelegate<LocalizationMessages> {
  @override
  bool isSupported(Locale locale) => _languageMap.keys.contains(locale.languageCode);

  @override
  Future<LocalizationMessages> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();
    final LocalizationMessages localeContent =
        _languageMap[locale.languageCode] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) => false;
}

class Messages {
  static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages)!;

  static LocalizationMessages? getContent(String language) => _languageMap[language];

  static LocalizationMessages get el {
    final LocalizationMessages localeContent =
        _languageMap[Intl.defaultLocale] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }
}

LocalizationMessages get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

const List<Locale> supportedLocales = [
  Locale('fr'),
  Locale('en'),
  Locale('ru'),
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
