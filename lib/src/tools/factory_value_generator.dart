import '../locale/code_output.dart';

String factoryValueGenerator({
  required String rawName,
  String? jsonKey,
  Set<String> arguments = const {},
  bool withHowMany = false,
  bool nullable = false,
}) {
  final bool hasArguments = arguments.isNotEmpty;
  String extraction = "json[${qu(rawName)}]";
  extraction = [
    extraction,
    if (jsonKey != null) "['$jsonKey']",
  ].join();

  if (nullable) {
    return [
      extraction,
      ' == null || $extraction.toString().trim() == \'\' ? null : ',
      extraction,
      '.toString()',
      if (withHowMany) ".replaceAll(r'\${howMany}', howMany.toString())",
      for (final argument in arguments) ".replaceAll(r'\${$argument}', $argument)",
      if (hasArguments) ".replaceAll(_variableRegExp, '')",
    ].join();
  }

  return [
    "($extraction",
    " ?? '').toString()",
    if (withHowMany) ".replaceAll(r'\${howMany}', howMany.toString())",
    for (final argument in arguments) ".replaceAll(r'\${$argument}', $argument)",
    if (hasArguments) ".replaceAll(_variableRegExp, '')",
  ].join();
}
