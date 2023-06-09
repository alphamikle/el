import '../../tools/arguments_extractor.dart';
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
    return CodeOutput(
      classArgumentCode:
          '${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.key}'},',
      classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function(int howMany, {int? precision}) ${unit.key};
''',
      externalCode: '',
    );
  }
  String functionArguments = arguments.map((String arg) => 'required String $arg').join(', ');
  functionArguments = '(int howMany, {$functionArguments, int? precision})';

  return CodeOutput(
    classArgumentCode:
        '${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.key}'},',
    classBodyCode: '''
${unit.value.description != null ? '/// ${unit.value.description}' : ''}
final String Function$functionArguments ${unit.key};
''',
    externalCode: '',
  );
}
