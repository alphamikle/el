import '../gen/generator_config.dart';
import '../loader/language_localization.dart';
import '../template/class_end_template.dart';
import '../template/imports_template.dart';
import '../template/localizations_messages_template.dart';
import '../tools/code_tools.dart';
import '../tools/localization_tools.dart';
import '../type/types.dart';
import 'localization_unit.dart';
import 'unit_to_code_generator/code_output.dart';

class LocalizationFileInterfaceGenerator {
  LocalizationFileInterfaceGenerator({
    required this.config,
    required this.localizations,
  });

  final GeneratorConfig config;
  final List<LanguageLocalization> localizations;

  final List<String> externalCode = [];

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
      ...externalCode,
      localizationsMessagesTemplate(className: config.localizationsClassName),
      ...constructorArgumentsCode,
      '});',
      ...classBodyCode,
      classEndTemplate,
    ].join('\n');

    return code;
  }

  void _proceedUnits(List<LocalizationUnit> units) {
    for (final LocalizationUnit unit in units) {
      final CodeOutput code = localizationUnitToInterface(unit);
      constructorArgumentsCode.add(code.classArgumentCode);
      externalCode.add(code.externalCode);
      classBodyCode.add(code.classBodyCode);
    }
  }
}
