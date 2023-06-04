import '../../tools/arguments_extractor.dart';
import '../localization_unit.dart';
import '../unit_to_code_generator/code_output.dart';

CodeOutput stringUnitToValue(StringUnit unit) {
  final Set<String> arguments = extractArguments(unit.value);

  if (arguments.isEmpty) {
    return CodeOutput(
      classArgumentCode: "${unit.key}: $qt${unit.value}$qt,",
      classBodyCode: '',
      externalCode: '',
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    classArgumentCode: "${unit.key}: $functionArguments => $qt${unit.value}$qt,",
    classBodyCode: '',
    externalCode: '',
  );
}
