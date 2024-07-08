import '../tools/names_converter.dart';

typedef StringWithDescriptionValue = ({String value, String description});
typedef PluralizedValue = ({String? zero, String one, String? two, String? few, String? many, String other, String? description});
typedef GenderValue = ({String? male, String? female, String? other, String? description});
typedef NamespacedValue = Map<String, LocalizationUnit>;

sealed class LocalizationUnit {
  const LocalizationUnit();

  String get fieldName;

  String get fieldKey;

  Object get value;

  List<String> get parents;
}

class StringUnit extends LocalizationUnit {
  const StringUnit({
    required this.fieldKey,
    required this.value,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase;

  @override
  final String fieldKey;

  @override
  final String value;

  @override
  final List<String> parents;
}

class StringWithDescriptionUnit extends LocalizationUnit {
  const StringWithDescriptionUnit({
    required this.fieldKey,
    required this.value,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase;

  @override
  final String fieldKey;

  @override
  final StringWithDescriptionValue value;

  @override
  final List<String> parents;
}

class GenderUnit extends LocalizationUnit {
  const GenderUnit({
    required this.fieldKey,
    required this.value,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase;

  @override
  final String fieldKey;

  @override
  final GenderValue value;

  @override
  final List<String> parents;
}

class PluralizedUnit extends LocalizationUnit {
  const PluralizedUnit({
    required this.fieldKey,
    required this.value,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase;

  @override
  final String fieldKey;

  @override
  final PluralizedValue value;

  @override
  final List<String> parents;
}

class NamespacedUnit extends LocalizationUnit {
  const NamespacedUnit({
    required this.fieldKey,
    required this.value,
    required this.parents,
  });

  @override
  String get fieldName => fieldKey.asClearCamelCase;

  @override
  final String fieldKey;

  @override
  final NamespacedValue value;

  @override
  final List<String> parents;
}
