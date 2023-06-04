import '../locale/localization_unit.dart';
import '../locale/unit_to_code_generator/code_output.dart';
import '../locale/unit_to_code_generator/namespaced_unit_to_code_generator.dart';
import '../locale/unit_to_code_generator/pluralized_unit_to_code_generator.dart';
import '../locale/unit_to_code_generator/string_unit_to_code_generator.dart';
import '../locale/unit_to_code_generator/string_with_description_unit_to_code_generator.dart';
import '../locale/unit_to_interface_generator/namespaced_unit_to_interface_generator.dart';
import '../locale/unit_to_interface_generator/pluralized_unit_to_interface_generator.dart';
import '../locale/unit_to_interface_generator/string_unit_to_interface_generator.dart';
import '../locale/unit_to_interface_generator/string_with_description_unit_to_interface_generator.dart';

CodeOutput localizationUnitToCode(LocalizationUnit unit, {bool useThisKeyword = true}) {
  return switch (unit) {
    StringUnit() => stringUnitToCode(unit, useThisKeyword: useThisKeyword),
    StringWithDescriptionUnit() => stringWithDescriptionUnitToCode(unit, useThisKeyword: useThisKeyword),
    PluralizedUnit() => pluralizedUnitToCode(unit, useThisKeyword: useThisKeyword),
    NamespacedUnit() => namespacedUnitToCode(unit, useThisKeyword: useThisKeyword),
  };
}

CodeOutput localizationUnitToInterface(LocalizationUnit unit, {bool useThisKeyword = true}) {
  return switch (unit) {
    StringUnit() => stringUnitToInterface(unit, useThisKeyword: useThisKeyword),
    StringWithDescriptionUnit() => stringWithDescriptionUnitToInterface(unit, useThisKeyword: useThisKeyword),
    PluralizedUnit() => pluralizedUnitToInterface(unit, useThisKeyword: useThisKeyword),
    NamespacedUnit() => namespacedUnitToInterface(unit, useThisKeyword: useThisKeyword),
  };
}
