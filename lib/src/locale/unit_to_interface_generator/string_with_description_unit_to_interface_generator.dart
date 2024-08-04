import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/value_prettier.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';
import 'string_unit_to_interface_generator.dart';

CodeOutput stringWithDescriptionUnitToInterface(StringWithDescriptionUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(unit.schemaValue.value);
  String parentClassName = unit.parents.map(capitalize).join();

  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (unit.value.description.trim().isEmpty) {
    return stringUnitToInterface(
      StringUnit(
        fieldKey: unit.fieldKey,
        value: unit.value.value,
        schemaValue: unit.schemaValue.value,
        parents: unit.parents,
      ),
    );
  }
  if (arguments.isEmpty) {
    return _empty(
      unit: unit,
      parentClassName: parentClassName,
      useThisKeyword: useThisKeyword,
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    classArgumentCode:
        "${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},",
    factoryArgumentCode: _factoryCode(unit.fieldName, arguments),
    classBodyCode: '''
/// ${unit.value.description}
final String Function$functionArguments ${unit.fieldName};
''',
    externalCode: '',
  );
}

CodeOutput _empty({
  required StringWithDescriptionUnit unit,
  required String parentClassName,
  required bool useThisKeyword,
}) {
  return CodeOutput(
    classArgumentCode:
        "${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' ${prettyValue(unit.value.value)}'},",
    factoryArgumentCode: _factoryCode(unit.fieldName, {}),
    classBodyCode: '''
/// ${unit.value.description}
final String ${unit.fieldName};
''',
    externalCode: '',
  );
}

String _factoryCode(String fieldName, Set<String> arguments) {
  final bool hasArguments = arguments.isNotEmpty;

  return '''
$fieldName: ${hasArguments ? '({${arguments.map((String arg) => 'required String $arg').join(', ')}}) => ' : ''}${factoryValueGenerator(fieldName: fieldName, arguments: arguments)},
''';
}
