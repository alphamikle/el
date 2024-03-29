import '../loader/language_localization.dart';
import '../locale/code_output.dart';
import '../locale/localization_unit.dart';
import '../template/class_beginning_template.dart';
import '../template/class_end_template.dart';
import '../template/imports_template.dart';
import '../tools/code_tools.dart';
import '../tools/localization_tools.dart';
import '../type/types.dart';
import 'generator_config.dart';

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

  final List<String> dynamicContent = [
    'Map<String, Object> get _content => {',
  ];

  String generate() {
    final List<LocalizationUnit> units = [];
    if (localizations.isEmpty) {
      throw ArgumentError('localizations argument should not be empty. It seems - you have no any localization files');
    }
    final Json content = localizations.first.content;
    for (final MapEntry(:String key, :Object value) in content.entries) {
      final LocalizationUnit localizationUnit = localizeValue(key, value);
      units.add(localizationUnit);
    }
    _proceedUnits(units);
    dynamicContent.addAll([
      '};',
      '''
T getContent<T>(String key) {
  final Object? value = _content[key];
  if (value is T) {
    return value;
  }
  throw ArgumentError('Not found content for the key \$key');
}

dynamic operator [](Object? key) {
  return _content[key];
}
''',
    ]);
    final String code = [
      importsTemplate,
      ...externalCode,
      classBeginningTemplate(className: config.localizationsClassName),
      ...constructorArgumentsCode,
      '});',
      ...classBodyCode,
      ...dynamicContent,
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
      dynamicContent.add("r'''${unit.key}''': ${unit.key},");
    }
  }
}
