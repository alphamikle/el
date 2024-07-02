import '../locale/code_output.dart';

String factoryValueGenerator({required String fieldName, String? jsonKey, Set<String> arguments = const {}}) {
  final bool hasArguments = arguments.isNotEmpty;

  return [
    "(json[r$qt$fieldName$qt]",
    if (jsonKey != null) "['$jsonKey']",
    " ?? '').toString()",
    for (final argument in arguments) ".replaceAll(r'\${$argument}', $argument)",
    if (hasArguments) ".replaceAll(_variableRegExp, '')",
  ].join();
}
