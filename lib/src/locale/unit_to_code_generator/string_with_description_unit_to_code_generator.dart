import '../../tools/arguments_extractor.dart';
import '../localization_unit.dart';
import 'code_output.dart';
import 'string_unit_to_code_generator.dart';

CodeOutput stringWithDescriptionUnitToCode(StringWithDescriptionUnit unit) {
  final Set<String> arguments = extractArguments(unit.value.value);
  if (unit.value.description.trim().isEmpty) {
    return stringUnitToCode(StringUnit(key: unit.key, value: unit.value.value));
  }
  if (arguments.isEmpty) {
    return CodeOutput(
      /// this.greetings = 'Hello!',
      classArgumentCode: "this.${unit.key} = $qt${unit.value.value}$qt,",

      /// Greetings to user on the main screen
      /// final String greetings;
      classBodyCode: '''
/// ${unit.value.description}
final String ${unit.key};
''',
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    /// this.greetings = $greetings,
    classArgumentCode: "this.${unit.key} = \$${unit.key},",

    /// Greetings to user on the main screen
    /// final String Function({required String username}) greetings;
    /// static String $greetings({required String username}) => 'Hello, ${username}';
    classBodyCode: '''
/// ${unit.value.description}
final String Function$functionArguments ${unit.key};

static String \$${unit.key}$functionArguments => $qt${unit.value.value}$qt;
''',
  );
}
