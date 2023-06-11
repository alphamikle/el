import '../locale/code_output.dart';
import '../locale/localization_unit.dart';
import '../locale/unit_to_interface_generator/gender_unit_to_interface_generator.dart';
import '../locale/unit_to_interface_generator/namespaced_unit_to_interface_generator.dart';
import '../locale/unit_to_interface_generator/pluralized_unit_to_interface_generator.dart';
import '../locale/unit_to_interface_generator/string_unit_to_interface_generator.dart';
import '../locale/unit_to_interface_generator/string_with_description_unit_to_interface_generator.dart';
import '../locale/unit_to_value_generator/gender_unit_to_value_generator.dart';
import '../locale/unit_to_value_generator/namespaced_unit_to_value_generator.dart';
import '../locale/unit_to_value_generator/pluralized_unit_to_value_generator.dart';
import '../locale/unit_to_value_generator/string_unit_to_value_generator.dart';
import '../locale/unit_to_value_generator/string_with_description_unit_to_value_generator.dart';

CodeOutput localizationUnitToInterface(LocalizationUnit unit, {bool useThisKeyword = true}) {
  return switch (unit) {
    StringUnit() => stringUnitToInterface(unit, useThisKeyword: useThisKeyword),
    StringWithDescriptionUnit() => stringWithDescriptionUnitToInterface(unit, useThisKeyword: useThisKeyword),
    PluralizedUnit() => pluralizedUnitToInterface(unit, useThisKeyword: useThisKeyword),
    GenderUnit() => genderUnitToInterface(unit, useThisKeyword: useThisKeyword),
    NamespacedUnit() => namespacedUnitToInterface(unit, useThisKeyword: useThisKeyword),
  };
}

CodeOutput localizationUnitToValue(LocalizationUnit unit) {
  return switch (unit) {
    StringUnit() => stringUnitToValue(unit),
    StringWithDescriptionUnit() => stringWithDescriptionUnitToValue(unit),
    PluralizedUnit() => pluralizedUnitToValue(unit),
    GenderUnit() => genderUnitToValue(unit),
    NamespacedUnit() => namespacedUnitToValue(unit),
  };
}
