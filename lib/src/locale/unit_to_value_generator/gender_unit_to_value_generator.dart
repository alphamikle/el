import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
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
    return _empty(
      unit: unit,
      parentClassName: parentClassName,
    );
  }

  String functionArguments = arguments.map((String arg) => 'required String $arg').join(', ');
  functionArguments = '(Gender gender, {$functionArguments})';

  return CodeOutput(
    classArgumentCode: '''
${unit.fieldName}: $functionArguments => Intl.gender(
  gender.name,
  name: r$qt${unit.fieldName}$qt,
  ${unit.value.female != null ? 'female: $qt${unit.value.female}$qt,' : ''}
  ${unit.value.male != null ? 'male: $qt${unit.value.male}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
),
''',
    factoryArgumentCode: _factoryCode(unit.fieldName, arguments),
    classBodyCode: '',
    externalCode: '',
  );
}

CodeOutput _empty({
  required GenderUnit unit,
  required String parentClassName,
}) {
  return CodeOutput(
    classArgumentCode: '''
${unit.fieldName}: (Gender gender) => Intl.gender(
  gender.name,
  name: r$qt${unit.fieldName}$qt,
  ${unit.value.female != null ? 'female: $qt${unit.value.female}$qt,' : ''}
  ${unit.value.male != null ? 'male: $qt${unit.value.male}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
),
''',
    factoryArgumentCode: _factoryCode(unit.fieldName, {}),
    classBodyCode: '',
    externalCode: '',
  );
}

String _factoryCode(String fieldName, Set<String> arguments) {
  final bool hasArguments = arguments.isNotEmpty;

  return '''
$fieldName: (Gender gender${hasArguments ? ', {' : ''}${arguments.map((String arg) => 'required String $arg').join(', ')}${hasArguments ? '}' : ''}) => Intl.gender(
  gender.name,
  name: r$qt$fieldName$qt,
  female: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'female', arguments: arguments, nullable: true)},
  male: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'male', arguments: arguments, nullable: true)},
  other: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'other', arguments: arguments)},
),
''';
}
