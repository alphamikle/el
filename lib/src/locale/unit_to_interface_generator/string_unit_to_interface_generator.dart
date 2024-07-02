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
        "${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.key}'},",
    factoryArgumentCode: _factoryCode(unit.key, arguments),
    classBodyCode: '''
final String Function$functionArguments ${unit.key};
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
    classArgumentCode: "${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $qt${unit.value}$qt'},",
    factoryArgumentCode: _factoryCode(unit.key, {}),
    classBodyCode: 'final String ${unit.key};',
    externalCode: '',
  );
}

String _factoryCode(String fieldName, Set<String> arguments) {
  final bool hasArguments = arguments.isNotEmpty;

  return '''
$fieldName: ${hasArguments ? '({${arguments.map((String arg) => 'required String $arg').join(', ')}}) => ' : ''}${factoryValueGenerator(fieldName: fieldName, arguments: arguments)},
''';
}
