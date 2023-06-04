import '../../tools/arguments_extractor.dart';
import '../../type/mappers.dart';
import '../localization_unit.dart';
import 'code_output.dart';

const Set<String> _reservedArguments = {'howMany', 'precision'};

CodeOutput pluralizedUnitToCode(PluralizedUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(_pluralizedValueToString(unit.value)).where((String arg) => _reservedArguments.contains(arg) == false).toSet();
  String parentClassName = unit.parents.map(capitalize).join();
  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (arguments.isEmpty) {
    return CodeOutput(
      classArgumentCode: '${useThisKeyword ? 'this.' : ''}${unit.key}${useThisKeyword ? ' =' : ':'} $parentClassName\$${unit.key},',
      classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(int howMany, {int? precision}) ${unit.key};

static String \$${unit.key}(int howMany, {int? precision}) => Intl.plural(
  howMany,
  name: $qt${unit.key}$qt,
  ${unit.value.zero != null ? 'zero: $qt${unit.value.zero}$qt,' : ''}
  ${unit.value.one != null ? 'one: $qt${unit.value.one}$qt,' : ''}
  ${unit.value.two != null ? 'two: $qt${unit.value.two}$qt,' : ''}
  ${unit.value.few != null ? 'few: $qt${unit.value.few}$qt,' : ''}
  ${unit.value.many != null ? 'many: $qt${unit.value.many}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
  precision: precision,
);
''',
      externalCode: '',
    );
  }
  String functionArguments = arguments.map((String arg) => 'required String $arg').join(', ');
  functionArguments = '(int howMany, {$functionArguments, int? precision})';

  return CodeOutput(
    classArgumentCode: '${useThisKeyword ? 'this.' : ''}${unit.key}${useThisKeyword ? ' =' : ':'} $parentClassName\$${unit.key},',
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function$functionArguments ${unit.key};

static String \$${unit.key}$functionArguments => Intl.plural(
  howMany,
  name: $qt${unit.key}$qt,
  ${unit.value.zero != null ? 'zero: $qt${unit.value.zero}$qt,' : ''}
  ${unit.value.one != null ? 'one: $qt${unit.value.one}$qt,' : ''}
  ${unit.value.two != null ? 'two: $qt${unit.value.two}$qt,' : ''}
  ${unit.value.few != null ? 'few: $qt${unit.value.few}$qt,' : ''}
  ${unit.value.many != null ? 'many: $qt${unit.value.many}$qt,' : ''}
  other: $qt${unit.value.other}$qt,
  precision: precision,
);
''',
    externalCode: '',
  );
}

String _pluralizedValueToString(PluralizedValue value) {
  return [value.zero, value.one, value.two, value.few, value.many, value.other].join(' ');
}
