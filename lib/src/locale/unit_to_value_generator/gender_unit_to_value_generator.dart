import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/localization_tools.dart';
import '../../tools/value_prettier.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput genderUnitToValue(GenderUnit unit) {
  final Set<String> arguments = extractArguments(genderValueToString(unit.schemaValue)).toSet();
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
  name: r$qt${unit.rawName}$qt,
  ${unit.value.female != null ? 'female: ${prettyValue(unit.value.female)},' : ''}
  ${unit.value.male != null ? 'male: ${prettyValue(unit.value.male)},' : ''}
  other: ${prettyValue(unit.value.other)},
),
''',
    factoryArgumentCode: _factoryCode(unit, arguments),
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
  name: r$qt${unit.rawName}$qt,
  ${unit.value.female != null ? 'female: ${prettyValue(unit.value.female)},' : ''}
  ${unit.value.male != null ? 'male: ${prettyValue(unit.value.male)},' : ''}
  other: ${prettyValue(unit.value.other)},
),
''',
    factoryArgumentCode: _factoryCode(unit, {}),
    classBodyCode: '',
    externalCode: '',
  );
}

String _factoryCode(GenderUnit unit, Set<String> arguments) {
  final String fieldName = unit.fieldName;
  final String rawName = unit.rawName;
  final bool hasArguments = arguments.isNotEmpty;

  return '''
$fieldName: (Gender gender${hasArguments ? ', {' : ''}${arguments.map((String arg) => 'required String $arg').join(', ')}${hasArguments ? '}' : ''}) => Intl.gender(
  gender.name,
  name: r$qt$rawName$qt,
  female: ${factoryValueGenerator(rawName: rawName, jsonKey: 'female', arguments: arguments, nullable: true)},
  male: ${factoryValueGenerator(rawName: rawName, jsonKey: 'male', arguments: arguments, nullable: true)},
  other: ${factoryValueGenerator(rawName: rawName, jsonKey: 'other', arguments: arguments)},
),
''';
}
