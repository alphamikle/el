import '../tools/names_converter.dart';

typedef StringWithDescriptionValue = ({String value, String description});
typedef PluralizedValue = ({String? zero, String one, String? two, String? few, String? many, String other, String? description});
typedef GenderValue = ({String? male, String? female, String? other, String? description});
typedef NamespacedValue = Map<String, LocalizationUnit>;

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

class StringWithDescriptionUnit extends LocalizationUnit {
  const StringWithDescriptionUnit({
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
  final StringWithDescriptionValue value;

  @override
  final StringWithDescriptionValue schemaValue;

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
