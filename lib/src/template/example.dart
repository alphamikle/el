import 'package:intl/intl.dart';

final Map<String, dynamic> _messages = {
  'hello': 'World!',
  'namespacedMessage': {
    'first': 'How are',
    'second': 'you?',
  },
};

class LocalizationMessages {
  const LocalizationMessages({
    this.hello = 'World!',
    this.namespacedMessage = const NamespacedMessage(),
  });

  final String hello;
  final NamespacedMessage namespacedMessage;
}

class NamespacedMessage {
  const NamespacedMessage({
    this.first = 'How are',
    this.second = 'you?',
    this.third = $third,
  });

  final String first;
  final String second;
  final String Function(int howMany, {int? precision}) third;

  static String $third(int howMany, {int? precision}) => Intl.plural(
        howMany,
        name: '''book''',
        zero: '''books''',
        one: '''book''',
        two: '''books''',
        few: '''books''',
        many: '''books''',
        other: '''books''',
        precision: precision,
      );
}

final ex1 = LocalizationMessages().hello;
final ex2 = LocalizationMessages().namespacedMessage.first;
