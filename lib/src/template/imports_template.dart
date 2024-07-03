String get importsTemplate => '''
/// This is generated content. There is no point in changing it by hand.

// ignore_for_file: type=lint

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

final RegExp _variableRegExp = RegExp(r'\\\$\\{[^}]+\\} ?');

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
''';
