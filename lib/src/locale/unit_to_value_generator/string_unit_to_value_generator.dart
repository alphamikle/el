import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/value_prettier.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput stringUnitToValue(StringUnit unit) {
  final Set<String> arguments = extractArguments(unit.schemaValue);

  if (arguments.isEmpty) {
    return CodeOutput(
      classArgumentCode: "${unit.fieldName}: ${prettyValue(unit.value)},",
      classBodyCode: '',
      factoryArgumentCode: _factoryCode(unit.fieldName, {}),
      externalCode: '',
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    classArgumentCode: "${unit.fieldName}: $functionArguments => ${prettyValue(unit.value)},",
    classBodyCode: '',
    factoryArgumentCode: _factoryCode(unit.fieldName, arguments),
    externalCode: '',
  );
}

String _factoryCode(String fieldName, Set<String> arguments) {
  final bool hasArguments = arguments.isNotEmpty;

  return '''
$fieldName: ${hasArguments ? '({${arguments.map((String arg) => 'required String $arg').join(', ')}}) => ' : ''}${factoryValueGenerator(fieldName: fieldName, arguments: arguments)},
''';
}
