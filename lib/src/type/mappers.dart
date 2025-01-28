import 'package:yaml/yaml.dart';

import '../tools/extensions.dart';
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
    if (value == null) {
      continue;
    }

    final String stringKey = key.toString();

    if (isMultiEntity(key: stringKey, value: value)) {
      result[stringKey] = value;
    } else if (value is YamlMap) {
      result[stringKey] = yamlMapToJson(value);
    } else if (value is YamlList) {
      result[stringKey] = yamlListToJson(value);
    } else {
      result[stringKey] = switch (value) {
        num() || bool() => value.toString(),
        Map() => value.toJson(),
        List() => value.toJson(),
        _ => value,
      };
    }
  }
  return result;
}

List<Object> yamlListToJson(YamlList yamlList) {
  final List<Object> results = [];

  for (final Object? value in yamlList) {
    if (value == null) {
      continue;
    }

    if (value is YamlList) {
      results.add(yamlListToJson(value));
    } else if (value is YamlMap) {
      results.add(yamlMapToJson(value));
    } else {
      results.add(switch (value) {
        num() || bool() => value.toString(),
        Map() => value.toJson(),
        List() => value.toJson(),
        _ => value,
      });
    }
  }
  return results;
}
