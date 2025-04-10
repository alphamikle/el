import 'package:yaml/yaml.dart';

import '../tools/names_converter.dart';

typedef StringWithDescriptionValue = ({String value, String description});
typedef PluralizedValue = ({String? zero, String one, String? two, String? few, String? many, String other, String? description});
typedef GenderValue = ({String? male, String? female, String? other, String? description});
typedef NamespacedValue = Map<String, LocalizationUnit>;

enum UnitType {
  string,
  gender,
  plural,
  namespace,
  multiList,
  unknown;

  factory UnitType.fromValue(Object? value) {
    return switch (value) {
      double() => UnitType.string,
      int() => UnitType.string,
      bool() => UnitType.string,
      String() => UnitType.string,
      {'other': final String _, 'one': final String _} => UnitType.plural,
      {'many': final String _, 'one': final String _} => UnitType.plural,
      {'other': final String _, 'male': final String _, 'female': final String _} => UnitType.gender,
      YamlMap() => UnitType.namespace,
      Map() => UnitType.namespace,
      YamlList() => UnitType.multiList,
      List() => UnitType.multiList,
      _ => UnitType.unknown,
    };
  }
}

sealed class LocalizationUnit {
  const LocalizationUnit();

  String get fieldName;

  String get rawName;

  String get fieldKey;

  Object get value;

  Object get schemaValue;

  List<String> get parents;
}

class StringUnit extends LocalizationUnit {
  const StringUnit({
    required this.fieldKey,
    required this.value,
    required this.schemaValue,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase(parents.join());

  @override
  String get rawName => fieldKey;

  @override
  final String fieldKey;

  @override
  final String value;

  @override
  final String schemaValue;

  @override
  final List<String> parents;
}

class GenderUnit extends LocalizationUnit {
  const GenderUnit({
    required this.fieldKey,
    required this.value,
    required this.schemaValue,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase(parents.join());

  @override
  String get rawName => fieldKey;

  @override
  final String fieldKey;

  @override
  final GenderValue value;

  @override
  final GenderValue schemaValue;

  @override
  final List<String> parents;
}

class PluralizedUnit extends LocalizationUnit {
  const PluralizedUnit({
    required this.fieldKey,
    required this.value,
    required this.schemaValue,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase(parents.join());

  @override
  String get rawName => fieldKey;

  @override
  final String fieldKey;

  @override
  final PluralizedValue value;

  @override
  final PluralizedValue schemaValue;

  @override
  final List<String> parents;
}

class NamespacedUnit extends LocalizationUnit {
  const NamespacedUnit({
    required this.fieldKey,
    required this.value,
    required this.schemaValue,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase(parents.join());

  @override
  String get rawName => fieldKey;

  @override
  final String fieldKey;

  @override
  final NamespacedValue value;

  @override
  final NamespacedValue schemaValue;

  @override
  final List<String> parents;
}

class ListUnit extends LocalizationUnit {
  const ListUnit({
    required this.fieldKey,
    required this.value,
    required this.schemaValue,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase(parents.join());

  @override
  String get rawName => fieldKey;

  @override
  final String fieldKey;

  @override
  final List<Object?> value;

  @override
  final List<Object?> schemaValue;

  @override
  final List<String> parents;
}

class MapUnit extends LocalizationUnit {
  const MapUnit({
    required this.fieldKey,
    required this.value,
    required this.schemaValue,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase(parents.join());

  @override
  String get rawName => fieldKey;

  @override
  final String fieldKey;

  @override
  final Map<String, Object?> value;

  @override
  final Map<String, Object?> schemaValue;

  @override
  final List<String> parents;
}
