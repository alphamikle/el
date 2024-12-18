import 'package:yaml/yaml.dart';

import '../tools/multi_entity.dart';
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
    if (isMultiEntity(key: key, value: value)) {
      result[key] = value;
    } else if (value is YamlMap) {
      result[key] = yamlMapToJson(value);
    } else if (value is YamlList) {
      result[key] = yamlListToJson(value);
    } else {
      result[key] = value;
    }
  }
  return result;
}

List<Object?> yamlListToJson(YamlList yamlList) {
  final List<Object?> results = [];
  for (final Object? value in yamlList) {
    if (value is YamlList) {
      results.add(yamlListToJson(value));
    } else if (value is YamlMap) {
      results.add(yamlMapToJson(value));
    } else {
      results.add(value);
    }
  }
  return results;
}
