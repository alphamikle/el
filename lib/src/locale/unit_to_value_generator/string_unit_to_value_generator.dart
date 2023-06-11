import '../../tools/arguments_extractor.dart';
import '../code_output.dart';
import '../localization_unit.dart';

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
