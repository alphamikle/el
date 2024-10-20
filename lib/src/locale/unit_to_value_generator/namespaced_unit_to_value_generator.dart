import '../../tools/code_tools.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';

CodeOutput namespacedUnitToValue(NamespacedUnit unit) {
  final List<String> constructorParents = [];

  for (int i = 0; i < unit.parents.length; i++) {
    constructorParents.add(capitalize(unit.parents[i]));
  }

  final String variableName = unit.fieldName;
  final String constructorName =
      [...constructorParents, capitalize(unit.fieldName)].join();

  final List<CodeOutput> childrenCode = [];

  for (final MapEntry(:value) in unit.value.entries) {
    childrenCode.add(localizationUnitToValue(value));
  }

  final List<String> classArgumentCode = [
    '$variableName: $constructorName(',
    ...childrenCode.map((CodeOutput code) => code.classArgumentCode),
    '),',
  ];

  return CodeOutput(
    classArgumentCode: classArgumentCode.join('\n'),
    classBodyCode: '',
    externalCode: '',
  );
}
