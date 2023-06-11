import '../../tools/arguments_extractor.dart';
import '../../type/mappers.dart';
import '../code_output.dart';
import '../localization_unit.dart';
import 'string_unit_to_interface_generator.dart';

CodeOutput stringWithDescriptionUnitToInterface(StringWithDescriptionUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(unit.value.value);
  String parentClassName = unit.parents.map(capitalize).join();
  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (unit.value.description.trim().isEmpty) {
    return stringUnitToInterface(StringUnit(key: unit.key, value: unit.value.value, parents: unit.parents));
  }
  if (arguments.isEmpty) {
    return CodeOutput(
      classArgumentCode:
          "${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $qt${unit.value.value}$qt'},",
      classBodyCode: '''
/// ${unit.value.description}
final String ${unit.key};
''',
      externalCode: '',
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    classArgumentCode:
        "${useThisKeyword ? 'required this.' : ''}${unit.key}${useThisKeyword ? '' : ':'}${useThisKeyword ? '' : ' $parentClassName\$${unit.key}'},",
    classBodyCode: '''
/// ${unit.value.description}
final String Function$functionArguments ${unit.key};
''',
    externalCode: '',
  );
}
