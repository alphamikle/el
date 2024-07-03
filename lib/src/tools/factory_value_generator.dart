import '../locale/code_output.dart';

String factoryValueGenerator({
  required String fieldName,
  String? jsonKey,
  Set<String> arguments = const {},
  bool withHowMany = false,
  bool nullable = false,
}) {
  final bool hasArguments = arguments.isNotEmpty;
  final String extraction = "json[r$qt$fieldName$qt]";

  if (nullable) {
    return [
      extraction,
      if (jsonKey != null) "['$jsonKey']",
      ' == null ? null : ',
      extraction,
      if (jsonKey != null) "['$jsonKey']",
      '.toString()',
      if (withHowMany) ".replaceAll(r'\${howMany}', howMany.toString())",
      for (final argument in arguments) ".replaceAll(r'\${$argument}', $argument)",
      if (hasArguments) ".replaceAll(_variableRegExp, '')",
    ].join();
  }

  return [
    "($extraction",
    if (jsonKey != null) "['$jsonKey']",
    " ?? '').toString()",
    if (withHowMany) ".replaceAll(r'\${howMany}', howMany.toString())",
    for (final argument in arguments) ".replaceAll(r'\${$argument}', $argument)",
    if (hasArguments) ".replaceAll(_variableRegExp, '')",
  ].join();
}
