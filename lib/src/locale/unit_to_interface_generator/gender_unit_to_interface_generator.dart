import '../../tools/arguments_extractor.dart';
import '../../tools/localization_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput genderUnitToInterface(GenderUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(genderValueToString(unit.value)).toSet();
  String parentClassName = unit.parents.map(capitalize).join();

  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (arguments.isEmpty) {
    return _empty(
      unit: unit,
      parentClassName: parentClassName,
      useThisKeyword: useThisKeyword,
    );
  }

  String functionArguments = arguments.map((String arg) => 'required String $arg').join(', ');
  functionArguments = '(Gender gender, {$functionArguments})';

  return CodeOutput(
    classArgumentCode:
        '${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.key}'},',
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function$functionArguments ${unit.key};
''',
    externalCode: '',
  );
}

CodeOutput _empty({
  required GenderUnit unit,
  required String parentClassName,
  required bool useThisKeyword,
}) {
  return CodeOutput(
    classArgumentCode: [
      if (useThisKeyword) 'required this.',
      unit.key,
      if (useThisKeyword == false) ': $parentClassName\$${unit.key}',
    ].join(),
    factoryArgumentCode: '''
${unit.key}: (Gender gender) => Intl.gender(
        gender.name,
        name: r$qt${unit.key}$qt,
        female: json[r$qt${unit.key}$qt]['female'].toString(), 
        male: json[r$qt${unit.key}$qt]['male'].toString(), 
        other: json[r$qt${unit.key}$qt]['other'].toString(),
      ),
''',
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(Gender gender) ${unit.key};
''',
    externalCode: '',
  );
}
