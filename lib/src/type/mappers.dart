import 'dart:developer';

import 'package:yaml/yaml.dart';

import '../tools/names_converter.dart';
import 'types.dart';

final Map<String, String> _cache = {};

String capitalize(String? string) {
  if (string == null || string.isEmpty) {
    return '';
  }

  final String? cached = _cache[string];

  if (cached != null) {
    return cached;
  }

  String pascalCaseString = string.asPascalCase;

  if (pascalCaseString == 'Locale') {
    pascalCaseString = r'$Locale';
  }

  if (pascalCaseString.endsWith(r'$')) {
    pascalCaseString = pascalCaseString.replaceFirst(RegExp(r'\$$'), '');
  }

  _cache[string] = pascalCaseString;

  return pascalCaseString;
}

Json yamlMapToJson(YamlMap yamlMap) {
  final Map<String, dynamic> result = {};
  for (final MapEntry(:key, :value) in yamlMap.entries) {
    if (value is YamlMap) {
      result[key] = yamlMapToJson(value);
    } else if (value is YamlList) {
      final List<Map<String, dynamic>> tempList = [];
      for (final dynamic listValue in value) {
        if (listValue is YamlMap) {
          tempList.add(yamlMapToJson(listValue));
        } else {
          log('Skipping unsupported data type: $listValue', name: 'WARNING');
        }
      }
      result[key] = tempList;
    } else {
      result[key] = value;
    }
  }
  return result;
}
