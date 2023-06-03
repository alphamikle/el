import '../gen/generator_config.dart';
import '../loader/language_localization.dart';
import '../template/class_constructor_end_template.dart';
import '../template/class_end_template.dart';
import '../template/imports_template.dart';
import '../template/localizations_messages_template.dart';
import '../tools/localization_tools.dart';
import '../type/types.dart';
import 'localization_unit.dart';
import 'unit_to_code_generator/code_output.dart';
import 'unit_to_code_generator/namespaced_unit_to_code_generator.dart';
import 'unit_to_code_generator/pluralized_unit_to_code_generator.dart';
import 'unit_to_code_generator/string_unit_to_code_generator.dart';
import 'unit_to_code_generator/string_with_description_unit_to_code_generator.dart';

class LocalizationFileTemplate {
  LocalizationFileTemplate({
    required this.config,
    required this.localizations,
  });

  final GeneratorConfig config;
  final List<LanguageLocalization> localizations;

  final List<String> namespacedLocalizationsCode = [];

  final List<String> constructorArgumentsCode = [];

  final List<String> classBodyCode = [];

  String generate() {
    final List<LocalizationUnit> units = [];
    if (localizations.isEmpty) {
      throw ArgumentError('localizations argument should not be empty');
    }
    final Json content = localizations.first.content;
    for (final MapEntry(:String key, :Object value) in content.entries) {
      final LocalizationUnit localizationUnit = localizeValue(key, value);
      units.add(localizationUnit);
    }
    _proceedUnits(units);
    final String code = [
      importsTemplate,
      ...namespacedLocalizationsCode,
      localizationsMessagesTemplate(className: config.localizationsClassName),
      ...constructorArgumentsCode,
      classConstructorEndTemplate,
      ...classBodyCode,
      classEndTemplate,
    ].join('\n');

    return code;
  }

  void _proceedUnits(List<LocalizationUnit> units) {
    for (final LocalizationUnit unit in units) {
      final CodeOutput code = switch (unit) {
        StringUnit() => stringUnitToCode(unit),
        StringWithDescriptionUnit() => stringWithDescriptionUnitToCode(unit),
        PluralizedUnit() => pluralizedUnitToCode(unit),
        NamespacedUnit() => namespacedUnitToCode(unit),
      };
      constructorArgumentsCode.add(code.classArgumentCode);
      if (unit is NamespacedUnit) {
        namespacedLocalizationsCode.add(code.classBodyCode);
      } else {
        classBodyCode.add(code.classBodyCode);
      }
    }
  }
}
