final Set<String> _notified = {};

void logOnce(String message) {
  if (_notified.contains(message) == false) {
    _notified.add(message);
    log(message);
  }
}

void log(String message) {
  // ignore: avoid_print
  print(message);
}

extension LoggableString on String {
  String asBlue() {
    const String blue = '\u001b[34m';
    return '$blue$this'._reset();
  }

  String asGreen() {
    const String green = '\u001b[32m';
    return '$green$this'._reset();
  }

  String asRed() {
    const String red = '\u001b[31m';
    return '$red$this'._reset();
  }

  String asYellow() {
    const String yellow = '\u001b[33m';
    return '$yellow$this'._reset();
  }

  String _reset() {
    const String reset = '\u001b[0m';
    return '$this$reset';
  }
}
