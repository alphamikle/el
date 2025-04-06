const String qt = "'''";

class CodeOutput {
  const CodeOutput({
    required this.classArgumentCode,
    required this.initializerList,
    required this.classBodyCode,
    required this.externalCode,
    /*required*/ this.factoryArgumentCode,
  });

  final String classArgumentCode;
  final String? initializerList;
  final String classBodyCode;
  final String externalCode;
  final String? factoryArgumentCode;
}

String qu(String key, {bool raw = true}) {
  const Set<String> nowAllowedSymbols = {
    r'$',
    "'",
    '"',
    '\\',
    '\n',
    '\r',
    '\f',
    '\r\n',
  };

  for (final String symbol in nowAllowedSymbols) {
    if (key.contains(symbol)) {
      return '${raw ? 'r' : ''}$qt$key$qt';
    }
  }
  return "'$key'";
}
