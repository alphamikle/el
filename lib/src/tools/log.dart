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
