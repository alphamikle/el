import '../../tools/code_tools.dart';
import '../../type/mappers.dart';
import '../localization_unit.dart';
import 'code_output.dart';

CodeOutput namespacedUnitToCode(NamespacedUnit unit, {bool useThisKeyword = true}) {
  final List<String> variableParents = [];
  final List<String> constructorParents = [];
  for (int i = 0; i < unit.parents.length; i++) {
    if (i == 0) {
      variableParents.add(unit.parents[i]);
    } else {
      variableParents.add(capitalize(unit.parents[i]));
    }
    constructorParents.add(capitalize(unit.parents[i]));
  }
  final String variableName = unit.key;
  final String constructorName = [...constructorParents, capitalize(unit.key)].join();

  final List<CodeOutput> childrenCodeWithoutThisKeyword = [];
  final List<CodeOutput> childrenCodeWithThisKeyword = [];

  for (final MapEntry(:value) in unit.value.entries) {
    childrenCodeWithoutThisKeyword.add(localizationUnitToCode(value, useThisKeyword: false));
    childrenCodeWithThisKeyword.add(localizationUnitToCode(value));
  }

  final List<String> classArgumentCode = [
    '${useThisKeyword ? 'this.' : ''}$variableName${useThisKeyword ? ' =' : ':'} const $constructorName(',
    ...childrenCodeWithoutThisKeyword.map((CodeOutput code) => code.classArgumentCode),
    '),'
  ];

  final String classBodyCode = '''
final $constructorName $variableName;
''';

  final List<String> externalCode = [
    'class $constructorName {',
    'const $constructorName ({',
    ...childrenCodeWithThisKeyword.map((CodeOutput code) => code.classArgumentCode),
    '});',
    ...childrenCodeWithThisKeyword.map((CodeOutput code) => code.classBodyCode),
    '}',
    ...childrenCodeWithThisKeyword.map((CodeOutput code) => code.externalCode),
  ];

  return CodeOutput(
    classArgumentCode: classArgumentCode.join('\n'),
    classBodyCode: classBodyCode,
    externalCode: externalCode.join('\n'),
  );
}
