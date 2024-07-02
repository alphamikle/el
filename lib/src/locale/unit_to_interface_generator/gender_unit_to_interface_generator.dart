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
        '${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.key}'},',
    factoryArgumentCode: _factoryCode(unit.key, arguments),
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
      ',',
    ].join(),
    factoryArgumentCode: _factoryCode(unit.key, {}),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(Gender gender) ${unit.key};
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
  female: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'female', arguments: arguments)},
  male: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'male', arguments: arguments)},
  other: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'other', arguments: arguments)},
),
''';
}
