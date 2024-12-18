import 'package:yaml/yaml.dart';

enum MultiEntity {
  list,
  map,
}

bool isMultiEntity({
  required String key,
  required Object? value,
}) {
  final bool isStar = key.endsWith('*');

  if (isStar == false) {
    return value is List<Object?> || value is YamlList;
  }

  return value is List<Object?> || value is Map<String, Object?> || value is YamlList || value is YamlMap;
}
