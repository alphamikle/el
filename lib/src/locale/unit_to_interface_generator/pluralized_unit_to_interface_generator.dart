import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/localization_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

const Set<String> _reservedArguments = {'howMany', 'precision'};

CodeOutput pluralizedUnitToInterface(PluralizedUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(pluralizedValueToString(unit.schemaValue))
      .where(
        (String arg) => _reservedArguments.contains(arg) == false,
      )
      .toSet();

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

  final String functionArguments = '(num howMany, {${arguments.map((String arg) => 'required String $arg').join(', ')}, int? precision})';
  final String functionArgumentsCall = '(howMany, ${arguments.map((String arg) => '$arg: $arg').join(', ')}, precision: precision)';
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
  required PluralizedUnit unit,
  required String parentClassName,
  required bool useThisKeyword,
}) {
  final String functionArguments = '(num howMany, {int? precision})';
  final String functionArgumentsCall = '(howMany, precision: precision)';
  final String functionInterface = 'String Function$functionArguments';

  return CodeOutput(
    classArgumentCode:
        '${useThisKeyword ? 'required $functionInterface' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},',
    initializerList: '_${unit.fieldName} = ${unit.fieldName}',
    factoryArgumentCode: _factoryCode(unit, {}),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
String ${unit.fieldName}$functionArguments => _${unit.fieldName}$functionArgumentsCall;

final $functionInterface _${unit.fieldName};
''',
    externalCode: '',
  );
}

String _factoryCode(PluralizedUnit unit, Set<String> arguments) {
  final String fieldName = unit.fieldName;
  final String rawName = unit.rawName;

  return '''
$fieldName: (num howMany, {${_declarationArguments(arguments)}int? precision}) => Intl.plural(
  howMany,
  name: ${qu(rawName)},
  zero: ${factoryValueGenerator(rawName: rawName, jsonKey: 'zero', arguments: arguments, withHowMany: true, nullable: true)},
  one: ${factoryValueGenerator(rawName: rawName, jsonKey: 'one', arguments: arguments, withHowMany: true)},
  two: ${factoryValueGenerator(rawName: rawName, jsonKey: 'two', arguments: arguments, withHowMany: true, nullable: true)},
  few: ${factoryValueGenerator(rawName: rawName, jsonKey: 'few', arguments: arguments, withHowMany: true, nullable: true)},
  many: ${factoryValueGenerator(rawName: rawName, jsonKey: 'many', arguments: arguments, withHowMany: true, nullable: true)},
  other: ${factoryValueGenerator(rawName: rawName, jsonKey: 'other', arguments: arguments, withHowMany: true)},
  precision: precision,
),
''';
}

String _declarationArguments(Set<String> arguments) {
  if (arguments.isEmpty) {
    return '';
  }
  return '${arguments.map((String arg) => 'required String $arg').join(', ')}, ';
}
