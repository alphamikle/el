String get importsTemplate => '''
/// This is generated content. There is no point to change it by hands.

// ignore_for_file: type=lint

import 'dart:developer';

import 'package:easiest_localization/easiest_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

final RegExp _variableRegExp = RegExp(r'\\\$\\{[^}]+\\} ?');

typedef Checker<T> = bool Function(T value);

enum Gender {
  male,
  female,
  other, 
}
''';
