import '../code_output.dart';
import '../localization_unit.dart';
import 'string_unit_to_value_generator.dart';

CodeOutput stringWithDescriptionUnitToValue(StringWithDescriptionUnit unit) {
  return stringUnitToValue(StringUnit(key: unit.key, value: unit.value.value, parents: unit.parents));
}
