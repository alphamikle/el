/// This is generated content. There is no point in changing it by hand.

// ignore_for_file: type=lint

import 'dart:developer';

import 'package:easiest_localization/easiest_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

final RegExp _variableRegExp = RegExp(r'\$\{[^}]+\} ?');

typedef Checker<T> = bool Function(T value);

extension _ExtendedList<T> on List<T> {
  T? firstWhereOrNull(Checker<T> checker) {
    for (final T value in this) {
      if (checker(value)) {
        return value;
      }
    }
    return null;
  }
}

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

  factory Pages.fromJson(Map<String, dynamic> json) {
    return Pages(
      home: PagesHome.fromJson((json[r'''home'''] as Map).cast<String, dynamic>()),
      settings: PagesSettings.fromJson((json[r'''settings'''] as Map).cast<String, dynamic>()),
      profile: PagesProfile.fromJson((json[r'''profile'''] as Map).cast<String, dynamic>()),
      product: PagesProduct.fromJson((json[r'''product'''] as Map).cast<String, dynamic>()),
    );
  }

  final PagesHome home;

  final PagesSettings settings;

  final PagesProfile profile;

  final PagesProduct product;

  Map<String, Object> get _content => {
        r'''home''': home,
        r'''settings''': settings,
        r'''profile''': profile,
        r'''product''': product,
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

  factory PagesHome.fromJson(Map<String, dynamic> json) {
    return PagesHome(
      title: (json[r'''title'''] ?? '').toString(),
      description: (json[r'''description'''] ?? '').toString(),
      counter: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: r'''counter''',
        zero: json[r'''counter''']['zero'] == null ? null : json[r'''counter''']['zero'].toString().replaceAll(r'${howMany}', howMany.toString()),
        one: (json[r'''counter''']['one'] ?? '').toString().replaceAll(r'${howMany}', howMany.toString()),
        two: json[r'''counter''']['two'] == null ? null : json[r'''counter''']['two'].toString().replaceAll(r'${howMany}', howMany.toString()),
        few: json[r'''counter''']['few'] == null ? null : json[r'''counter''']['few'].toString().replaceAll(r'${howMany}', howMany.toString()),
        many: json[r'''counter''']['many'] == null ? null : json[r'''counter''']['many'].toString().replaceAll(r'${howMany}', howMany.toString()),
        other: (json[r'''counter''']['other'] ?? '').toString().replaceAll(r'${howMany}', howMany.toString()),
        precision: precision,
      ),
      incrementButton: PagesHomeIncrementButton.fromJson((json[r'''incrementButton'''] as Map).cast<String, dynamic>()),
    );
  }

  final String title;
  final String description;

  final String Function(int howMany, {int? precision}) counter;

  final PagesHomeIncrementButton incrementButton;

  Map<String, Object> get _content => {
        r'''title''': title,
        r'''description''': description,
        r'''counter''': counter,
        r'''incrementButton''': incrementButton,
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

  factory PagesHomeIncrementButton.fromJson(Map<String, dynamic> json) {
    return PagesHomeIncrementButton(
      title: (json[r'''title'''] ?? '').toString(),
    );
  }

  final String title;

  Map<String, Object> get _content => {
        r'''title''': title,
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

  factory PagesSettings.fromJson(Map<String, dynamic> json) {
    return PagesSettings(
      title: (json[r'''title'''] ?? '').toString(),
      description: (json[r'''description'''] ?? '').toString(),
    );
  }

  final String title;
  final String description;

  Map<String, Object> get _content => {
        r'''title''': title,
        r'''description''': description,
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

  factory PagesProfile.fromJson(Map<String, dynamic> json) {
    return PagesProfile(
      title: (json[r'''title'''] ?? '').toString(),
      description: (json[r'''description'''] ?? '').toString(),
    );
  }

  /// Profile page content
  final String title;

  final String description;

  Map<String, Object> get _content => {
        r'''title''': title,
        r'''description''': description,
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

  factory PagesProduct.fromJson(Map<String, dynamic> json) {
    return PagesProduct(
      title: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: r'''title''',
        zero: json[r'''title''']['zero'] == null ? null : json[r'''title''']['zero'].toString().replaceAll(r'${howMany}', howMany.toString()),
        one: (json[r'''title''']['one'] ?? '').toString().replaceAll(r'${howMany}', howMany.toString()),
        two: json[r'''title''']['two'] == null ? null : json[r'''title''']['two'].toString().replaceAll(r'${howMany}', howMany.toString()),
        few: json[r'''title''']['few'] == null ? null : json[r'''title''']['few'].toString().replaceAll(r'${howMany}', howMany.toString()),
        many: json[r'''title''']['many'] == null ? null : json[r'''title''']['many'].toString().replaceAll(r'${howMany}', howMany.toString()),
        other: (json[r'''title''']['other'] ?? '').toString().replaceAll(r'${howMany}', howMany.toString()),
        precision: precision,
      ),
    );
  }

  /// How many products do we have?
  final String Function(int howMany, {int? precision}) title;

  Map<String, Object> get _content => {
        r'''title''': title,
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

  factory Greetings3.fromJson(Map<String, dynamic> json) {
    return Greetings3(
      home: ({required String username}) => (json[r'''home'''] ?? '').toString().replaceAll(r'${username}', username).replaceAll(_variableRegExp, ''),
      settings: ({required String username}) => (json[r'''settings'''] ?? '').toString().replaceAll(r'${username}', username).replaceAll(_variableRegExp, ''),
      custom: ({required String username, required String page}) =>
          (json[r'''custom'''] ?? '').toString().replaceAll(r'${username}', username).replaceAll(r'${page}', page).replaceAll(_variableRegExp, ''),
    );
  }

  final String Function({required String username}) home;

  final String Function({required String username}) settings;

  final String Function({required String username, required String page}) custom;

  Map<String, Object> get _content => {
        r'''home''': home,
        r'''settings''': settings,
        r'''custom''': custom,
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
    required this.genderGreeting,
    required this.bookAfterwords,
    required this.pages,
    required this.greetings,
    required this.greetings2,
    required this.greetings3,
    required this.aboutCows,
    required this.date_format,
  });

  factory LocalizationMessages.fromJson(Map<String, dynamic> json) {
    return LocalizationMessages(
      title: (json[r'''title'''] ?? '').toString(),
      intro: (json[r'''intro'''] ?? '').toString(),
      product: (int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: r'''product''',
        zero: json[r'''product''']['zero'] == null ? null : json[r'''product''']['zero'].toString().replaceAll(r'${howMany}', howMany.toString()),
        one: (json[r'''product''']['one'] ?? '').toString().replaceAll(r'${howMany}', howMany.toString()),
        two: json[r'''product''']['two'] == null ? null : json[r'''product''']['two'].toString().replaceAll(r'${howMany}', howMany.toString()),
        few: json[r'''product''']['few'] == null ? null : json[r'''product''']['few'].toString().replaceAll(r'${howMany}', howMany.toString()),
        many: json[r'''product''']['many'] == null ? null : json[r'''product''']['many'].toString().replaceAll(r'${howMany}', howMany.toString()),
        other: (json[r'''product''']['other'] ?? '').toString().replaceAll(r'${howMany}', howMany.toString()),
        precision: precision,
      ),
      genderGreeting: (Gender gender) => Intl.gender(
        gender.name,
        name: r'''genderGreeting''',
        female: json[r'''genderGreeting''']['female'] == null ? null : json[r'''genderGreeting''']['female'].toString(),
        male: json[r'''genderGreeting''']['male'] == null ? null : json[r'''genderGreeting''']['male'].toString(),
        other: (json[r'''genderGreeting''']['other'] ?? '').toString(),
      ),
      bookAfterwords: (Gender gender, {required String username}) => Intl.gender(
        gender.name,
        name: r'''bookAfterwords''',
        female: json[r'''bookAfterwords''']['female'] == null
            ? null
            : json[r'''bookAfterwords''']['female'].toString().replaceAll(r'${username}', username).replaceAll(_variableRegExp, ''),
        male: json[r'''bookAfterwords''']['male'] == null
            ? null
            : json[r'''bookAfterwords''']['male'].toString().replaceAll(r'${username}', username).replaceAll(_variableRegExp, ''),
        other: (json[r'''bookAfterwords''']['other'] ?? '').toString().replaceAll(r'${username}', username).replaceAll(_variableRegExp, ''),
      ),
      pages: Pages.fromJson((json[r'''pages'''] as Map).cast<String, dynamic>()),
      greetings: ({required String username}) => (json[r'''greetings'''] ?? '').toString().replaceAll(r'${username}', username).replaceAll(_variableRegExp, ''),
      greetings2: ({required String username}) =>
          (json[r'''greetings2'''] ?? '').toString().replaceAll(r'${username}', username).replaceAll(_variableRegExp, ''),
      greetings3: Greetings3.fromJson((json[r'''greetings3'''] as Map).cast<String, dynamic>()),
      aboutCows: (int howMany, {required String username, int? precision}) => Intl.plural(
        howMany,
        name: r'''aboutCows''',
        zero: json[r'''aboutCows''']['zero'] == null
            ? null
            : json[r'''aboutCows''']['zero']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString())
                .replaceAll(r'${username}', username)
                .replaceAll(_variableRegExp, ''),
        one: (json[r'''aboutCows''']['one'] ?? '')
            .toString()
            .replaceAll(r'${howMany}', howMany.toString())
            .replaceAll(r'${username}', username)
            .replaceAll(_variableRegExp, ''),
        two: json[r'''aboutCows''']['two'] == null
            ? null
            : json[r'''aboutCows''']['two']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString())
                .replaceAll(r'${username}', username)
                .replaceAll(_variableRegExp, ''),
        few: json[r'''aboutCows''']['few'] == null
            ? null
            : json[r'''aboutCows''']['few']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString())
                .replaceAll(r'${username}', username)
                .replaceAll(_variableRegExp, ''),
        many: json[r'''aboutCows''']['many'] == null
            ? null
            : json[r'''aboutCows''']['many']
                .toString()
                .replaceAll(r'${howMany}', howMany.toString())
                .replaceAll(r'${username}', username)
                .replaceAll(_variableRegExp, ''),
        other: (json[r'''aboutCows''']['other'] ?? '')
            .toString()
            .replaceAll(r'${howMany}', howMany.toString())
            .replaceAll(r'${username}', username)
            .replaceAll(_variableRegExp, ''),
        precision: precision,
      ),
      date_format: (json[r'''date_format'''] ?? '').toString(),
    );
  }

  final String title;

  /// For some reason we decided to use exactly that title for that screen
  final String intro;

  /// How many products do we have?
  final String Function(int howMany, {int? precision}) product;

  /// What the user will see, after he read the book
  final String Function(Gender gender) genderGreeting;

  /// What the user will see, after he read the book
  final String Function(Gender gender, {required String username}) bookAfterwords;

  final Pages pages;

  final String Function({required String username}) greetings;

  /// This is greetings with an argument [username]
  final String Function({required String username}) greetings2;

  final Greetings3 greetings3;

  final String Function(int howMany, {required String username, int? precision}) aboutCows;

  /// Date in the US date format
  final String date_format;

  Map<String, Object> get _content => {
        r'''title''': title,
        r'''intro''': intro,
        r'''product''': product,
        r'''genderGreeting''': genderGreeting,
        r'''bookAfterwords''': bookAfterwords,
        r'''pages''': pages,
        r'''greetings''': greetings,
        r'''greetings2''': greetings2,
        r'''greetings3''': greetings3,
        r'''aboutCows''': aboutCows,
        r'''date_format''': date_format,
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
    name: r'''product''',
    zero: '''There are ${howMany} products''',
    one: '''There are ${howMany} product''',
    two: '''There are ${howMany} products''',
    few: '''There are ${howMany} products''',
    many: '''There are ${howMany} products''',
    other: '''There are ${howMany} products''',
    precision: precision,
  ),
  genderGreeting: (Gender gender) => Intl.gender(
    gender.name,
    name: r'''genderGreeting''',
    female: '''Thank you for reading, miss!''',
    male: '''Thank you for reading, mister!''',
    other: '''Thank you for reading, dear user!''',
  ),
  bookAfterwords: (Gender gender, {required String username}) => Intl.gender(
    gender.name,
    name: r'''bookAfterwords''',
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
        name: r'''counter''',
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
        name: r'''title''',
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
    name: r'''aboutCows''',
    one: '''Maybe there are ${howMany} cow? What do you think, ${username}?''',
    other: '''Maybe there are ${howMany} cows? What do you think, ${username}?''',
    precision: precision,
  ),
  date_format: '''MM/dd/yyyy''',
);
final LocalizationMessages en_CA = LocalizationMessages(
  title: '''Easiest Localization App''',
  intro: '''This is a intro screen title''',
  product: (int howMany, {int? precision}) => Intl.plural(
    howMany,
    name: r'''product''',
    zero: '''There are ${howMany} products''',
    one: '''There are ${howMany} product''',
    two: '''There are ${howMany} products''',
    few: '''There are ${howMany} products''',
    many: '''There are ${howMany} products''',
    other: '''There are ${howMany} products''',
    precision: precision,
  ),
  genderGreeting: (Gender gender) => Intl.gender(
    gender.name,
    name: r'''genderGreeting''',
    female: '''Thank you for reading, miss!''',
    male: '''Thank you for reading, mister!''',
    other: '''Thank you for reading, dear user!''',
  ),
  bookAfterwords: (Gender gender, {required String username}) => Intl.gender(
    gender.name,
    name: r'''bookAfterwords''',
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
        name: r'''counter''',
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
        name: r'''title''',
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
    name: r'''aboutCows''',
    one: '''Maybe there are ${howMany} cow? What do you think, ${username}?''',
    other: '''Maybe there are ${howMany} cows? What do you think, ${username}?''',
    precision: precision,
  ),
  date_format: '''dd/MM/yyyy''',
);
final LocalizationMessages en_US = LocalizationMessages(
  title: '''Easiest Localization App''',
  intro: '''This is a intro screen title''',
  product: (int howMany, {int? precision}) => Intl.plural(
    howMany,
    name: r'''product''',
    zero: '''There are ${howMany} products''',
    one: '''There are ${howMany} product''',
    two: '''There are ${howMany} products''',
    few: '''There are ${howMany} products''',
    many: '''There are ${howMany} products''',
    other: '''There are ${howMany} products''',
    precision: precision,
  ),
  genderGreeting: (Gender gender) => Intl.gender(
    gender.name,
    name: r'''genderGreeting''',
    female: '''Thank you for reading, miss!''',
    male: '''Thank you for reading, mister!''',
    other: '''Thank you for reading, dear user!''',
  ),
  bookAfterwords: (Gender gender, {required String username}) => Intl.gender(
    gender.name,
    name: r'''bookAfterwords''',
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
        name: r'''counter''',
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
        name: r'''title''',
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
  greetings: ({required String username}) => '''Hey, ${username}!''',
  greetings2: ({required String username}) => '''Hello, dear ${username}!''',
  greetings3: Greetings3(
    home: ({required String username}) => '''Hello, ${username} at home page!''',
    settings: ({required String username}) => '''Hello, ${username} at settings page!''',
    custom: ({required String username, required String page}) => '''Hello, ${username} at ${page} page!''',
  ),
  aboutCows: (int howMany, {required String username, int? precision}) => Intl.plural(
    howMany,
    name: r'''aboutCows''',
    one: '''Maybe there are ${howMany} cow? What do you think, ${username}?''',
    other: '''Maybe there are ${howMany} cows? What do you think, ${username}?''',
    precision: precision,
  ),
  date_format: '''MM/dd/yyyy''',
);
final Map<String, LocalizationMessages> _languageMap = {
  '*': en,
  'en': en,
  'en_CA': en_CA,
  'en_US': en_US,
};

final Map<String, LocalizationMessages> _providersLanguagesMap = {};

class EasiestLocalizationDelegate extends LocalizationsDelegate<LocalizationMessages> {
  EasiestLocalizationDelegate({
    List<LocalizationProvider<Locale, LocalizationMessages>> providers = const [],
  }) {
    providers.map(registerProvider);
  }

  final List<LocalizationProvider<Locale, LocalizationMessages>> _providers = [];

  void registerProvider(LocalizationProvider<Locale, LocalizationMessages> provider) {
    _providers.add(provider);
  }

  @override
  bool isSupported(Locale locale) {
    return _languageMap.keys.contains(locale.languageCode) || _providers.firstWhereOrNull((LocalizationProvider value) => value.canLoad(locale)) != null;
  }

  Future<LocalizationMessages> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();

    LocalizationProvider<Locale, LocalizationMessages>? localizationProvider;

    for (final LocalizationProvider<Locale, LocalizationMessages> provider in _providers) {
      if (provider.canLoad(locale)) {
        localizationProvider = provider;
        break;
      }
    }

    LocalizationMessages? localeContent;

    if (localizationProvider != null) {
      try {
        localeContent = await localizationProvider.fetchLocalization(locale);
        _providersLanguagesMap[locale.toString()] = localeContent;
      } catch (error, stackTrace) {
        log('Error on loading localization with provider "${localizationProvider.name}"', error: error, stackTrace: stackTrace);
      }
    }

    localeContent ??= _languageMap[locale.languageCode] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) => false;
}

class Messages {
  static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages)!;

  static LocalizationMessages? getContent(String language) => _languageMap[language];

  static LocalizationMessages get el {
    LocalizationMessages? localeContent = _providersLanguagesMap[Intl.defaultLocale] ?? _providersLanguagesMap['*'];
    localeContent ??= _languageMap[Intl.defaultLocale] ?? _languageMap['*'] ?? _languageMap.values.first;
    return localeContent;
  }
}

LocalizationMessages get el => Messages.el;

final List<LocalizationsDelegate> localizationsDelegates = [
  EasiestLocalizationDelegate(),
  ...GlobalMaterialLocalizations.delegates,
];

List<LocalizationsDelegate> localizationsDelegatesWithProviders(List<LocalizationProvider<Locale, LocalizationMessages>> providers) {
  return [
    EasiestLocalizationDelegate(providers: providers),
    ...GlobalMaterialLocalizations.delegates,
  ];
}

const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('en_CA'),
  Locale('en_US'),
];

List<Locale> supportedLocalesWithProviders(List<LocalizationProvider> providers) => [
      for (final LocalizationProvider provider in providers) ...provider.supportedLocales,
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

// Reference example
// abstract interface class LocalizationProvider<L, M> {
//   String get name;
//
//   List<L> get supportedLocales;
//
//   Future<M> fetchLocalization(L locale);
//
//   bool canLoad(L locale);
// }
