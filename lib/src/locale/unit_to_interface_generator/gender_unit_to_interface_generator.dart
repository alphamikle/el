import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
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
        '${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},',
    factoryArgumentCode: _factoryCode(unit.fieldName, arguments),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function$functionArguments ${unit.fieldName};
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
      unit.fieldName,
      if (useThisKeyword == false) ': $parentClassName\$${unit.fieldName}',
      ',',
    ].join(),
    factoryArgumentCode: _factoryCode(unit.fieldName, {}),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(Gender gender) ${unit.fieldName};
''',
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
