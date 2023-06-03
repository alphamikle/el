import '../../tools/arguments_extractor.dart';
import '../localization_unit.dart';
import 'code_output.dart';

CodeOutput stringUnitToCode(StringUnit unit) {
  final Set<String> arguments = extractArguments(unit.value);
  if (arguments.isEmpty) {
    return CodeOutput(
      /// this.greetings = 'Hello!',
      classArgumentCode: "this.${unit.key} = $qt${unit.value}$qt,",

      /// final String greetings;
      classBodyCode: 'final String ${unit.key};',
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    /// this.greetings = $greetings,
    classArgumentCode: "this.${unit.key} = \$${unit.key},",

    /// final String Function({required String username}) greetings;
    /// static String $greetings({required String username}) => 'Hello, ${username}';
    classBodyCode: '''
final String Function$functionArguments ${unit.key};

static String \$${unit.key}$functionArguments => $qt${unit.value}$qt;
''',
  );
}
