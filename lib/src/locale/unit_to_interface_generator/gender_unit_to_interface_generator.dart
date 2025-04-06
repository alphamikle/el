import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/localization_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput genderUnitToInterface(GenderUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(genderValueToString(unit.schemaValue)).toSet();
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

  final String functionArguments = '(Gender gender, {${arguments.map((String arg) => 'required String $arg').join(', ')}})';
  final String functionArgumentsCall = '(gender, ${arguments.map((String arg) => '$arg: $arg').join(', ')})';
  final String functionInterface = 'String Function$functionArguments';

  return CodeOutput(
    classArgumentCode:
        '${useThisKeyword ? 'required $functionInterface ' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},',
    initializerList: '_${unit.fieldName} = ${unit.fieldName}',
    factoryArgumentCode: _factoryCode(unit, arguments),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
String ${unit.fieldName}$functionArguments => _${unit.fieldName}$functionArgumentsCall;

final $functionInterface _${unit.fieldName};
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
    initializerList: null,
    factoryArgumentCode: _factoryCode(unit, {}),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(Gender gender) ${unit.fieldName};
''',
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
  name: ${qu(rawName)},
  female: ${factoryValueGenerator(rawName: rawName, jsonKey: 'female', arguments: arguments, nullable: true)},
  male: ${factoryValueGenerator(rawName: rawName, jsonKey: 'male', arguments: arguments, nullable: true)},
  other: ${factoryValueGenerator(rawName: rawName, jsonKey: 'other', arguments: arguments)},
),
''';
}
