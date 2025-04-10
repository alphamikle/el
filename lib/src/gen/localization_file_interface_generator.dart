import '../loader/language_localization.dart';
import '../locale/code_output.dart';
import '../locale/localization_unit.dart';
import '../template/class_beginning_template.dart';
import '../template/class_end_template.dart';
import '../template/class_factory_template.dart';
import '../template/imports_template.dart';
import '../tools/code_tools.dart';
import '../tools/extensions.dart';
import '../tools/localization_tools.dart';
import '../tools/null_value_exception.dart';
import '../type/types.dart';
import 'generator_config.dart';

class LocalizationFileInterfaceGenerator {
  LocalizationFileInterfaceGenerator({
    required this.config,
    required this.localizations,
    required this.scheme,
  });

  final GeneratorConfig config;

  final List<LanguageLocalization> localizations;

  final LanguageLocalization scheme;

  final List<String> externalCode = [];

  final List<String> constructorArgumentsCode = [];

  final List<String> constructorInitializerCode = [];

  final List<String> factoryArgumentsCode = [];

  final List<String> classBodyCode = [];

  final List<String> dynamicContent = [
    'Map<String, Object> get _content => {',
  ];

  String generate() {
    final List<LocalizationUnit> units = [];
    if (localizations.isEmpty) {
      throw ArgumentError('localizations argument should not be empty. It seems - you have no any localization files');
    }
    final Json content = scheme.content;
    for (final MapEntry(:String key, :Object? value) in content.entries) {
      if (value == null) {
        nullValueException(key: key);
      }

      final LocalizationUnit localizationUnit = localizeValue(key, value, value);
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
  throw ArgumentError('Not found content for the key \$key with type \$T');
}

Map<String, Object> get content => _content;

List<Object> get contentList => _content.values.toList();

int get length => _content.length;

Object? operator [](Object? key) {
  final Object? value = _content[key];
  if (value == null && key is String) {
    final int? index = int.tryParse(key);
    if (index == null || index >= contentList.length || index < 0) {
      return null;
    }

    return contentList[index];
  }
  return value;
}
''',
    ]);

    final bool noConstructorInitializerArguments = constructorInitializerCode.every((String arg) => arg.trim().isEmpty);
    final bool hasConstructorInitializerArguments = noConstructorInitializerArguments == false;

    final String code = [
      importsTemplate(config),
      ...externalCode,
      classBeginningTemplate(className: config.localizationsClassName),
      ...constructorArgumentsCode,
      if (constructorArgumentsCode.isEmpty) 'String? stub,',
      if (noConstructorInitializerArguments) '});' else '}): ',
      if (hasConstructorInitializerArguments) ...[
        constructorInitializerCode.join(', '),
        ';',
      ],
      classFactoryBeginningTemplate(className: config.localizationsClassName),
      ...factoryArgumentsCode,
      classFactoryEndTemplate(),
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
      if (code.initializerList != null) {
        constructorInitializerCode.add(code.initializerList!);
      }
      factoryArgumentsCode.add(code.factoryArgumentCode ?? '');
      externalCode.add(code.externalCode);
      classBodyCode.add(code.classBodyCode);
      dynamicContent.add("r'''${unit.rawName}''': ${unit.fieldName},");

      final String asteriskClearName = unit.rawName.clearMultiKey();
      if (unit.rawName != asteriskClearName && (unit is ListUnit || unit is MapUnit)) {
        dynamicContent.add("r'''$asteriskClearName''': ${unit.fieldName},");
      }
    }
  }
}
