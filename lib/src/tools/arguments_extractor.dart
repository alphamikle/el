final RegExp _argumentsRegExp = RegExp(r'\$\{(?<variable>[a-zA-Z$]\w+)\}');

Set<String> extractArguments(String message) {
  final Iterable<RegExpMatch> matches = _argumentsRegExp.allMatches(message);
  return matches.map((RegExpMatch match) => match.namedGroup('variable')!).toSet();
}

bool hasArguments(Object? value) {
  if (value is String) {
    final Set<String> arguments = extractArguments(value);
    return arguments.isNotEmpty;
  } else if (value is List<Object?>) {
    return value.any(hasArguments);
  } else if (value is Map<String, Object?>) {
    return value.values.any(hasArguments);
  }
  return false;
}
