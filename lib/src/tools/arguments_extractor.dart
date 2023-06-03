final RegExp _argumentsRegExp = RegExp(r'\$\{(?<variable>[a-zA-Z$]\w+)\}');

Set<String> extractArguments(String message) {
  final Iterable<RegExpMatch> matches = _argumentsRegExp.allMatches(message);
  return matches.map((RegExpMatch match) => match.namedGroup('variable')!).toSet();
}
