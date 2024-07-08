import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput stringUnitToInterface(StringUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(unit.value);
  String parentClassName = unit.parents.map(capitalize).join();
  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (arguments.isEmpty) {
    return _empty(
      unit: unit,
      useThisKeyword: useThisKeyword,
      parentClassName: parentClassName,
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    classArgumentCode:
        "${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},",
    factoryArgumentCode: _factoryCode(unit.fieldName, arguments),
    classBodyCode: '''
final String Function$functionArguments ${unit.fieldName};
''',
    externalCode: '',
  );
}

// TODO(alphamikle): Continue with handling wrong key names and collisions
CodeOutput _empty({
  required StringUnit unit,
  required String parentClassName,
  required bool useThisKeyword,
}) {
  return CodeOutput(
    classArgumentCode: "${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $qt${unit.value}$qt'},",
    factoryArgumentCode: _factoryCode(unit.fieldName, {}),
    classBodyCode: 'final String ${unit.fieldName};',
    externalCode: '',
  );
}

String _factoryCode(String fieldName, Set<String> arguments) {
  final bool hasArguments = arguments.isNotEmpty;

  return '''
$fieldName: ${hasArguments ? '({${arguments.map((String arg) => 'required String $arg').join(', ')}}) => ' : ''}${factoryValueGenerator(fieldName: fieldName, arguments: arguments)},
''';
}
