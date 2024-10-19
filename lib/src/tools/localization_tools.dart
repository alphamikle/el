import '../locale/localization_unit.dart';
import '../type/types.dart';
import 'debouncer.dart';
import 'log.dart';
import 'null_value_exception.dart';

const int criticalDeepnessLevel = 15;

LocalizationUnit localizeValue(
  String key,
  Object value,
  Object scheme, [
  List<String>? parents,
  int deepness = 0,
]) {
  Object effectiveValue = value;
  Object effectiveScheme = scheme;

  if (value is List) {
    effectiveValue = Map.fromEntries(List.generate(value.length, (int index) => MapEntry(index.toString(), value[index])));
  }

  if (scheme is List) {
    effectiveScheme = Map.fromEntries(List.generate(scheme.length, (int index) => MapEntry(index.toString(), scheme[index])));
  }

  final LocalizationUnit localizationUnit = switch (effectiveValue) {
    num() => StringUnit(fieldKey: key, value: effectiveValue.toString(), schemaValue: effectiveScheme.toString(), parents: parents ?? []),
    bool() => StringUnit(fieldKey: key, value: effectiveValue.toString(), schemaValue: effectiveScheme.toString(), parents: parents ?? []),
    String() => StringUnit(fieldKey: key, value: effectiveValue, schemaValue: effectiveScheme.toString(), parents: parents ?? []),
    {'other': final String $other, 'one': final String $one} => PluralizedUnit(
        fieldKey: key,
        value: (
          zero: effectiveValue.get('zero'),
          one: $one,
          two: effectiveValue.get('two'),
          few: effectiveValue.get('few'),
          many: effectiveValue.get('many'),
          other: $other,
          description: effectiveValue.get('desc')
        ),
        schemaValue: (
          zero: effectiveScheme.get('zero'),
          one: effectiveScheme.get('one'),
          two: effectiveScheme.get('two'),
          few: effectiveScheme.get('few'),
          many: effectiveScheme.get('many'),
          other: effectiveScheme.get('other'),
          description: effectiveScheme.get('desc')
        ),
        parents: parents ?? [],
      ),
    {'other': final String $other} => GenderUnit(
        fieldKey: key,
        value: (
          male: effectiveValue.get('male'),
          female: effectiveValue.get('female'),
          other: $other,
          description: effectiveValue.get('desc'),
        ),
        schemaValue: (
          male: effectiveScheme.get('male'),
          female: effectiveScheme.get('female'),
          other: effectiveScheme.get('other'),
          description: effectiveScheme.get('desc'),
        ),
        parents: parents ?? [],
      ),
    Map() => NamespacedUnit(
        fieldKey: key,
        value: _localizeMap(key, effectiveValue, effectiveScheme as Map, parents ?? [], deepness),
        schemaValue: {},
        parents: parents ?? [],
      ),
    _ => throw UnsupportedError('Value "$effectiveValue" is not supported'),
  };

  return localizationUnit;
}

Map<String, LocalizationUnit> _localizeMap(
  String parent,
  Map<dynamic, dynamic> map,
  Map<dynamic, dynamic> schemaMap,
  List<String> parents,
  int deepness,
) {
  final Map<String, LocalizationUnit> namespacedValue = {};

  for (final MapEntry(:String key, :Object? value) in map.entries) {
    final Object? schemaValue = schemaMap.get(key);

    if (value == null || schemaValue == null) {
      nullValueException(key: [...parents, parent, key].join('.'));
    }

    if (deepness >= criticalDeepnessLevel) {
      final StringBuffer messageBuffer = StringBuffer('Field "${[...parents, parent, key].join('.')}" ');
      messageBuffer.write('has critical deepness level = $deepness. ');
      messageBuffer.write('Consider to place it on a higher level of the content tree t achieve higher generation performance.');

      final String message = messageBuffer.toString();

      Debouncer.throttle(
        message,
        () => log(message.toString().asYellow()),
      );
    }

    final UnitType type = UnitType.fromValue(value);

    if (type == UnitType.namespace) {
      namespacedValue[key] = localizeValue(key, value, schemaValue, [...parents, parent], deepness + 1);
    } else {
      namespacedValue[key] = localizeValue(key, value, schemaValue, [parent], deepness + 1);
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
