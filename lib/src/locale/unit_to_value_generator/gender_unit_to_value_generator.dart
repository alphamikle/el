import '../../tools/arguments_extractor.dart';
import '../../tools/localization_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput genderUnitToValue(GenderUnit unit) {
  final Set<String> arguments = extractArguments(genderValueToString(unit.value)).toSet();
  String parentClassName = unit.parents.map(capitalize).join();
  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (arguments.isEmpty) {
    return CodeOutput(
      classArgumentCode: '''
${unit.key}: (Gender gender) => Intl.gender(
  gender.name,
  name: r$qt${unit.key}$qt,
  ${unit.value.female != null ? 'female: $qt${unit.value.female}$qt,' : ''}
  ${unit.value.male != null ? 'male: $qt${unit.value.male}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
),
''',
      classBodyCode: '',
      externalCode: '',
    );
  }
  String functionArguments = arguments.map((String arg) => 'required String $arg').join(', ');
  functionArguments = '(Gender gender, {$functionArguments})';

  return CodeOutput(
    classArgumentCode: '''
${unit.key}: $functionArguments => Intl.gender(
  gender.name,
  name: r$qt${unit.key}$qt,
  ${unit.value.female != null ? 'female: $qt${unit.value.female}$qt,' : ''}
  ${unit.value.male != null ? 'male: $qt${unit.value.male}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
),
''',
    classBodyCode: '',
    externalCode: '',
  );
}
