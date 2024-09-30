import '../locale/localization_unit.dart';
import '../type/types.dart';

LocalizationUnit localizeValue(
  String key,
  Object value,
  Object scheme, [
  List<String>? parents,
]) {
  final LocalizationUnit localizationUnit = switch (value) {
    String() => StringUnit(fieldKey: key, value: value, schemaValue: scheme.toString(), parents: parents ?? []),
    {'value': final String $value, 'desc': final String $desc} => StringWithDescriptionUnit(
        fieldKey: key,
        value: (value: $value, description: $desc),
        schemaValue: (value: scheme.get('value'), description: scheme.get('desc')),
        parents: parents ?? [],
      ),
    {'value': final String $value} => StringUnit(fieldKey: key, value: $value, schemaValue: scheme.get('value'), parents: parents ?? []),
    {'other': final String $other, 'one': final String $one} => PluralizedUnit(
        fieldKey: key,
        value: (
          zero: value.get('zero'),
          one: $one,
          two: value.get('two'),
          few: value.get('few'),
          many: value.get('many'),
          other: $other,
          description: value.get('desc')
        ),
        schemaValue: (
          zero: scheme.get('zero'),
          one: scheme.get('one'),
          two: scheme.get('two'),
          few: scheme.get('few'),
          many: scheme.get('many'),
          other: scheme.get('other'),
          description: scheme.get('desc')
        ),
        parents: parents ?? [],
      ),
    {'other': final String $other} => GenderUnit(
        fieldKey: key,
        value: (
          male: value.get('male'),
          female: value.get('female'),
          other: $other,
          description: value.get('desc'),
        ),
        schemaValue: (
          male: scheme.get('male'),
          female: scheme.get('female'),
          other: scheme.get('other'),
          description: scheme.get('desc'),
        ),
        parents: parents ?? [],
      ),
    Map() => NamespacedUnit(
        fieldKey: key,
        value: _localizeMap(key, value, scheme as Map, parents ?? []),
        schemaValue: {},
        parents: parents ?? [],
      ),
    _ => throw UnsupportedError('Value "$value" is not supported'),
  };

  return localizationUnit;
}

Map<String, LocalizationUnit> _localizeMap(String parent, Map<dynamic, dynamic> map, Map<dynamic, dynamic> schemaMap, List<String> parents) {
  final Map<String, LocalizationUnit> namespacedValue = {};

  for (final MapEntry(:key, :value) in map.entries) {
    final LocalizationUnit unit = localizeValue(key, value, schemaMap.get(key), [parent]);

    if (unit is NamespacedUnit) {
      namespacedValue[key] = localizeValue(key, value, schemaMap.get(key), [...parents, parent]);
    } else {
      namespacedValue[key] = unit;
    }
  }

  return namespacedValue;
}

String pluralizedValueToString(PluralizedValue value) {
  return [value.zero, value.one, value.two, value.few, value.many, value.other].join(' ');
}

String genderValueToString(GenderValue value) {
  return [value.male, value.female, value.other].join(' ');
}
