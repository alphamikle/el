import '../code_output.dart';
import '../localization_unit.dart';
import 'string_unit_to_value_generator.dart';

CodeOutput stringWithDescriptionUnitToValue(StringWithDescriptionUnit unit) {
  return stringUnitToValue(
    StringUnit(
      fieldKey: unit.fieldKey,
      value: unit.value.value,
      schemaValue: unit.schemaValue.value,
      parents: unit.parents,
    ),
  );
}
