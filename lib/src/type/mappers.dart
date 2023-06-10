import 'dart:developer';

import 'package:yaml/yaml.dart';

import '../../easiest_localization.dart';
import 'types.dart';

String capitalize(String? string) {
  if (string == null || string.isEmpty) {
    return '';
  }
  return string.substring(0, 1).toUpperCase() + string.substring(1, string.length);
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

FallbackLocales yamlMapToFallbackLocales(YamlMap? yamlMap) {
  if (yamlMap == null) {
    return {};
  }
  final Map<String, String> result = {};
  for (final MapEntry(:key, :value) in yamlMap.entries) {
    result[key] = value.toString();
  }
  return result;
}
