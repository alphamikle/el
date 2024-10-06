import '../../tools/arguments_extractor.dart';
import '../../tools/factory_value_generator.dart';
import '../../tools/localization_tools.dart';
import '../../tools/value_prettier.dart';
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
  functionArguments = '(num howMany, {$functionArguments, int? precision})';

  return CodeOutput(
    classArgumentCode: '''
${unit.fieldName}: $functionArguments => Intl.plural(
  howMany,
  name: ${qu(unit.rawName)},
  ${unit.value.zero != null ? 'zero: ${prettyValue(unit.value.zero, nullable: true)},' : ''}
  one: ${prettyValue(unit.value.one)},
  ${unit.value.two != null ? 'two: ${prettyValue(unit.value.two, nullable: true)},' : ''}
  ${unit.value.few != null ? 'few: ${prettyValue(unit.value.few, nullable: true)},' : ''}
  ${unit.value.many != null ? 'many: ${prettyValue(unit.value.many, nullable: true)},' : ''}
  other: ${prettyValue(unit.value.other)},
  precision: precision,
),
''',
    classBodyCode: '',
    factoryArgumentCode: _factoryCode(unit, {'howMany', ...arguments}),
    externalCode: '',
  );
}

CodeOutput _empty({
  required PluralizedUnit unit,
  required String parentClassName,
}) {
  return CodeOutput(
    classArgumentCode: '''
${unit.fieldName}: (num howMany, {int? precision}) => Intl.plural(
  howMany,
  name: ${qu(unit.rawName)},
  ${unit.value.zero != null ? 'zero: ${prettyValue(unit.value.zero, nullable: true)},' : ''}
  one: ${prettyValue(unit.value.one)},
  ${unit.value.two != null ? 'two: ${prettyValue(unit.value.two, nullable: true)},' : ''}
  ${unit.value.few != null ? 'few: ${prettyValue(unit.value.few, nullable: true)},' : ''}
  ${unit.value.many != null ? 'many: ${prettyValue(unit.value.many, nullable: true)},' : ''}
  other: ${prettyValue(unit.value.other)},
  precision: precision,
),
''',
    factoryArgumentCode: _factoryCode(unit, {'howMany'}),
    classBodyCode: '',
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
