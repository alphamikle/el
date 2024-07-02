import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/localization_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

const Set<String> _reservedArguments = {'howMany', 'precision'};

CodeOutput pluralizedUnitToInterface(PluralizedUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(pluralizedValueToString(unit.value)).where((String arg) => _reservedArguments.contains(arg) == false).toSet();
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
  functionArguments = '(int howMany, {$functionArguments, int? precision})';

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
  required PluralizedUnit unit,
  required String parentClassName,
  required bool useThisKeyword,
}) {
  return CodeOutput(
    classArgumentCode:
        '${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.key}'},',
    factoryArgumentCode: _factoryCode(unit.key, {}),
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(int howMany, {int? precision}) ${unit.key};
''',
    externalCode: '',
  );
}

String _factoryCode(String fieldName, Set<String> arguments) {
  return '''
$fieldName: (int howMany, {${_declarationArguments(arguments)}int? precision}) => Intl.plural(
  howMany,
  name: r$qt$fieldName$qt,
  zero: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'zero', arguments: arguments)}, 
  one: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'one', arguments: arguments)},
  two: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'two', arguments: arguments)},
  few: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'few', arguments: arguments)},
  many: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'many', arguments: arguments)},
  other: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'other', arguments: arguments)},
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
