import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/localization_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

const Set<String> _reservedArguments = {'howMany', 'precision'};

CodeOutput pluralizedUnitToValue(PluralizedUnit unit) {
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
    );
  }

  String functionArguments = arguments.map((String arg) => 'required String $arg').join(', ');
  functionArguments = '(int howMany, {$functionArguments, int? precision})';

  return CodeOutput(
    classArgumentCode: '''
${unit.fieldName}: $functionArguments => Intl.plural(
  howMany,
  name: r$qt${unit.fieldName}$qt,
  ${unit.value.zero != null ? 'zero: $qt${unit.value.zero}$qt,' : ''}
  one: $qt${unit.value.one}$qt,
  ${unit.value.two != null ? 'two: $qt${unit.value.two}$qt,' : ''}
  ${unit.value.few != null ? 'few: $qt${unit.value.few}$qt,' : ''}
  ${unit.value.many != null ? 'many: $qt${unit.value.many}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
  precision: precision,
),
''',
    classBodyCode: '',
    factoryArgumentCode: _factoryCode(unit.fieldName, {'howMany', ...arguments}),
    externalCode: '',
  );
}

CodeOutput _empty({
  required PluralizedUnit unit,
  required String parentClassName,
}) {
  return CodeOutput(
    classArgumentCode: '''
${unit.fieldName}: (int howMany, {int? precision}) => Intl.plural(
  howMany,
  name: r$qt${unit.fieldName}$qt,
  ${unit.value.zero != null ? 'zero: $qt${unit.value.zero}$qt,' : ''}
  one: $qt${unit.value.one}$qt,
  ${unit.value.two != null ? 'two: $qt${unit.value.two}$qt,' : ''}
  ${unit.value.few != null ? 'few: $qt${unit.value.few}$qt,' : ''}
  ${unit.value.many != null ? 'many: $qt${unit.value.many}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
  precision: precision,
),
''',
    factoryArgumentCode: _factoryCode(unit.fieldName, {'howMany'}),
    classBodyCode: '',
    externalCode: '',
  );
}

String _factoryCode(String fieldName, Set<String> arguments) {
  return '''
$fieldName: (int howMany, {${_declarationArguments(arguments)}int? precision}) => Intl.plural(
  howMany,
  name: r$qt$fieldName$qt,
  zero: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'zero', arguments: arguments, withHowMany: true, nullable: true)}, 
  one: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'one', arguments: arguments, withHowMany: true)},
  two: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'two', arguments: arguments, withHowMany: true, nullable: true)},
  few: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'few', arguments: arguments, withHowMany: true, nullable: true)},
  many: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'many', arguments: arguments, withHowMany: true, nullable: true)},
  other: ${factoryValueGenerator(fieldName: fieldName, jsonKey: 'other', arguments: arguments, withHowMany: true)},
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
