import '../../tools/arguments_extractor.dart';
import '../../type/mappers.dart';
import '../localization_unit.dart';
import 'code_output.dart';
import 'string_unit_to_code_generator.dart';

CodeOutput stringWithDescriptionUnitToCode(StringWithDescriptionUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(unit.value.value);
  String parentClassName = unit.parents.map(capitalize).join();
  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (unit.value.description.trim().isEmpty) {
    return stringUnitToCode(StringUnit(key: unit.key, value: unit.value.value, parents: unit.parents));
  }
  if (arguments.isEmpty) {
    return CodeOutput(
      /// this.greetings = 'Hello!',
      classArgumentCode: "${useThisKeyword ? 'this.' : ''}${unit.key}${useThisKeyword ? ' =' : ':'} $qt${unit.value.value}$qt,",

      /// Greetings to user on the main screen
      /// final String greetings;
      classBodyCode: '''
/// ${unit.value.description}
final String ${unit.key};
''',
      externalCode: '',
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    /// this.greetings = $greetings,
    classArgumentCode: "${useThisKeyword ? 'this.' : ''}${unit.key}${useThisKeyword ? ' =' : ':'} $parentClassName\$${unit.key},",

    /// Greetings to user on the main screen
    /// final String Function({required String username}) greetings;
    /// static String $greetings({required String username}) => 'Hello, ${username}';
    classBodyCode: '''
/// ${unit.value.description}
final String Function$functionArguments ${unit.key};

static String \$${unit.key}$functionArguments => $qt${unit.value.value}$qt;
''',
    externalCode: '',
  );
}
