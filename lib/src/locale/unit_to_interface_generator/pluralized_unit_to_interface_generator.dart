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
  String functionArguments = arguments.map((String arg) => 'required String $arg').join(', ');
  functionArguments = '(num howMany, {$functionArguments, int? precision})';

  return CodeOutput(
    classArgumentCode:
        '${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},',
    factoryArgumentCode: _factoryCode(unit, arguments),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function$functionArguments ${unit.fieldName};
''',
    externalCode: '',
  );
}

CodeOutput _empty({
  required PluralizedUnit unit,
  required String parentClassName,
  required bool useThisKeyword,
}) {
  return CodeOutput(
    classArgumentCode:
        '${useThisKeyword ? 'required this.' : ''}${unit.fieldName}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.fieldName}'},',
    factoryArgumentCode: _factoryCode(unit, {}),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(num howMany, {int? precision}) ${unit.fieldName};
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
