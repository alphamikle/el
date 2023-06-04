import '../../tools/arguments_extractor.dart';
import '../../type/mappers.dart';
import '../localization_unit.dart';
import 'code_output.dart';

CodeOutput stringUnitToCode(StringUnit unit, {bool useThisKeyword = true}) {
  final Set<String> arguments = extractArguments(unit.value);
  String parentClassName = unit.parents.map(capitalize).join();
  if (parentClassName.isNotEmpty) {
    parentClassName = '$parentClassName.';
  }

  if (arguments.isEmpty) {
    return CodeOutput(
      /// this.greetings = 'Hello!',
      classArgumentCode: "${useThisKeyword ? 'this.' : ''}${unit.key}${useThisKeyword ? ' =' : ':'} $qt${unit.value}$qt,",

      /// final String greetings;
      classBodyCode: 'final String ${unit.key};',
      externalCode: '',
    );
  }
  final String functionArguments = '({${arguments.map((String arg) => 'required String $arg').join(', ')}})';

  return CodeOutput(
    /// this.greetings = $greetings,
    classArgumentCode: "${useThisKeyword ? 'this.' : ''}${unit.key}${useThisKeyword ? ' =' : ':'} $parentClassName\$${unit.key},",

    /// final String Function({required String username}) greetings;
    /// static String $greetings({required String username}) => 'Hello, ${username}';
    classBodyCode: '''
final String Function$functionArguments ${unit.key};

static String \$${unit.key}$functionArguments => $qt${unit.value}$qt;
''',
    externalCode: '',
  );
}
