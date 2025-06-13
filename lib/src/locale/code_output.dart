const String qt = "'''";
final RegExp openDollarRegExp = RegExp(r'(?<esc>\\+)?(?<dollar>\$(?<something>.)?)', multiLine: true);

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

String qu(String value, {bool raw = true}) {
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

  value = clearDollars(value);

  for (final String symbol in nowAllowedSymbols) {
    if (value.contains(symbol)) {
      return '${raw ? 'r' : ''}$qt$value$qt';
    }
  }

  return "'$value'";
}

String clearDollars(String value) {
  return value = value.replaceAllMapped(openDollarRegExp, (Match match) {
    if (match is RegExpMatch) {
      final String something = match.namedGroup('something') ?? '';
      if (something == '{') {
        return r'${';
      }
      return '\\\$$something';
    }
    return '';
  });
}
