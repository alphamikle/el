import '../gen/generator_config.dart';
import '../tools/names_converter.dart';

String importsTemplate(GeneratorConfig config) => '''
/// This is generated content. There is no point to change it by hands.

// ignore_for_file: type=lint

import 'dart:developer' show log;

import 'package:easiest_localization/easiest_localization.dart' show LocalizationProvider;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/widgets.dart' show BuildContext, Locale, Localizations, LocalizationsDelegate;
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalMaterialLocalizations;
import 'package:intl/intl.dart' show Intl;

final RegExp _variableRegExp = RegExp(r'\\\$\\{[^}]+\\} ?');

typedef Checker<T> = bool Function(T value);

const String ${config.packageName.asCamelCase}PackageVersion = r'${config.packageVersion}';

const String? ${config.packageName.asCamelCase}Version = ${config.version == null ? 'null' : "r'${config.version}'"};

enum Gender {
  male,
  female,
  other, 
}

extension type $contentList(List<Object?> _contentList) implements Iterable<Object?> {
  Object? at(int index) {
    if (index >= _contentList.length || index < 0) {
      return null;
    }
    return _contentList[index];
  }

  Object? operator [](int index) => at(index);

  Iterator<Object?> get iterator => _contentList.iterator;
}
''';

const String contentList = 'ContentList';
