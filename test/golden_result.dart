/// This is generated content. There is no point in changing it by hand.

import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class Primary {
  const Primary({
    required this.first,
    required this.second,
    required this.third,
    required this.fourth,
    required this.fifth,
    required this.sixth,
    required this.seventh,
    required this.pluralizedContentWithArguments,
  });
  final PrimaryFirst first;

  final PrimarySecond second;

  final PrimaryThird third;

  final PrimaryFourth fourth;

  final String fifth;

  /// Description string inside of namespace
  final String sixth;

  final String Function(int howMany, {int? precision}) seventh;

  /// Pluralized books content with arguments
  final String Function(int howMany, {required String author, int? precision}) pluralizedContentWithArguments;

  Map<String, Object> get _content => {
        'first': first,
        'second': second,
        'third': third,
        'fourth': fourth,
        'fifth': fifth,
        'sixth': sixth,
        'seventh': seventh,
        'pluralizedContentWithArguments': pluralizedContentWithArguments,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimaryFirst {
  const PrimaryFirst({
    required this.second,
  });
  final PrimaryFirstSecond second;

  Map<String, Object> get _content => {
        'second': second,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimaryFirstSecond {
  const PrimaryFirstSecond({
    required this.third,
  });
  final PrimaryFirstSecondThird third;

  Map<String, Object> get _content => {
        'third': third,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimaryFirstSecondThird {
  const PrimaryFirstSecondThird({
    required this.fourth,
  });
  final PrimaryFirstSecondThirdFourth fourth;

  Map<String, Object> get _content => {
        'fourth': fourth,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimaryFirstSecondThirdFourth {
  const PrimaryFirstSecondThirdFourth({
    required this.fifth,
  });
  final String fifth;
  Map<String, Object> get _content => {
        'fifth': fifth,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimarySecond {
  const PrimarySecond({
    required this.third,
  });
  final PrimarySecondThird third;

  Map<String, Object> get _content => {
        'third': third,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimarySecondThird {
  const PrimarySecondThird({
    required this.fourth,
  });
  final PrimarySecondThirdFourth fourth;

  Map<String, Object> get _content => {
        'fourth': fourth,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimarySecondThirdFourth {
  const PrimarySecondThirdFourth({
    required this.fifth,
  });
  final String fifth;
  Map<String, Object> get _content => {
        'fifth': fifth,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimaryThird {
  const PrimaryThird({
    required this.fourth,
  });
  final PrimaryThirdFourth fourth;

  Map<String, Object> get _content => {
        'fourth': fourth,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimaryThirdFourth {
  const PrimaryThirdFourth({
    required this.fifth,
  });
  final String fifth;
  Map<String, Object> get _content => {
        'fifth': fifth,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class PrimaryFourth {
  const PrimaryFourth({
    required this.fifth,
  });
  final String fifth;
  Map<String, Object> get _content => {
        'fifth': fifth,
      };
  T getContent<T>(String key) {
    final Object? value = _content[key];
    if (value is T) {
      return value;
    }
    throw ArgumentError('Not found content for the key $key');
  }
}

class LocalizationMessages {
  LocalizationMessages({
    required this.primary,
  });
  final Primary primary;
}

final LocalizationMessages en = LocalizationMessages(
  primary: Primary(
    first: const PrimaryFirst(
      second: PrimaryFirstSecond(
        third: PrimaryFirstSecondThird(
          fourth: PrimaryFirstSecondThirdFourth(
            fifth: '''I'm fifth of primary!''',
          ),
        ),
      ),
    ),
    second: const PrimarySecond(
      third: PrimarySecondThird(
        fourth: PrimarySecondThirdFourth(
          fifth: '''I'm fifth of second!''',
        ),
      ),
    ),
    third: const PrimaryThird(
      fourth: PrimaryThirdFourth(
        fifth: '''I'm fifth of third!''',
      ),
    ),
    fourth: const PrimaryFourth(
      fifth: '''I'm fifth of fourth!''',
    ),
    fifth: '''I'm fifth!!!''',
    sixth: '''Hello! Miss me?''',
    seventh: (int howMany, {int? precision}) => Intl.plural(
      howMany,
      name: '''seventh''',
      zero: '''cows''',
      one: '''cow''',
      two: '''cows''',
      few: '''cows''',
      many: '''cows''',
      other: '''cows''',
      precision: precision,
    ),
    pluralizedContentWithArguments: (int howMany, {required String author, int? precision}) => Intl.plural(
      howMany,
      name: '''pluralizedContentWithArguments''',
      zero: '''There are no any books of $author...''',
      one: '''There are $howMany book of $author.''',
      two: '''There are $howMany books of $author.''',
      few: '''There are $howMany books of $author.''',
      many: '''There are $howMany books of $author.''',
      other: '''There are $howMany books of $author.''',
      precision: precision,
    ),
  ),
);
final Map<String, LocalizationMessages> _languageMap = {
  'en': en,
};

class LocalizationDelegate extends LocalizationsDelegate<LocalizationMessages> {
  @override
  bool isSupported(Locale locale) => _languageMap.keys.contains(locale.languageCode);

  @override
  Future<LocalizationMessages> load(Locale locale) async {
    Intl.defaultLocale = locale.countryCode == null ? locale.languageCode : locale.toString();
    return _languageMap[locale.languageCode]!;
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationMessages> old) => false;
}

class Messages {
  static LocalizationMessages of(BuildContext context) => Localizations.of(context, LocalizationMessages)!;

  static LocalizationMessages getContent(String language) => _languageMap[language] as LocalizationMessages;
}

final List<LocalizationsDelegate> localizationsDelegates = [LocalizationDelegate(), ...GlobalMaterialLocalizations.delegates];

const List<Locale> supportedLocales = [
  Locale('en'),
];
