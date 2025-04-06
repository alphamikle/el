import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/value_prettier.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput stringUnitToInterface(StringUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(unit.schemaValue);

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
  final String functionArgumentsCall = '(${arguments.map((String arg) => '$arg: $arg').join(', ')})';
  final String functionInterface = 'String Function$functionArguments';

  return CodeOutput(
    classArgumentCode:
        "${useThisKeyword ? 'required $functionInterface ' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},",
    initializerList: '_${unit.fieldName} = ${unit.fieldName}',
    factoryArgumentCode: _factoryCode(unit, arguments),
    classBodyCode: '''
String ${unit.fieldName}$functionArguments => _${unit.fieldName}$functionArgumentsCall;

final $functionInterface _${unit.fieldName};
''',
    externalCode: '',
  );
}

CodeOutput _empty({
  required StringUnit unit,
  required String parentClassName,
  required bool useThisKeyword,
}) {
  return CodeOutput(
    classArgumentCode:
        "${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' ${prettyValue(unit.value)}'},",
    initializerList: null,
    factoryArgumentCode: _factoryCode(unit, {}),
    classBodyCode: 'final String ${unit.fieldName};',
    externalCode: '',
  );
}

String _factoryCode(StringUnit unit, Set<String> arguments) {
  final String fieldName = unit.fieldName;
  final String rawName = unit.rawName;
  final bool hasArguments = arguments.isNotEmpty;

  return '''
$fieldName: ${hasArguments ? '({${arguments.map((String arg) => 'required String $arg').join(', ')}}) => ' : ''}${factoryValueGenerator(rawName: rawName, arguments: arguments)},
''';
}
