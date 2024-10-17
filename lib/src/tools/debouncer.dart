import 'dart:async';

typedef Callback = void Function();

abstract final class Debouncer {
  static final Map<String, Timer> _timers = {};

  static void run(String id, Callback callback, {Duration delay = const Duration(milliseconds: 100)}) {
    _timers[id]?.cancel();
    _timers.remove(id);
    _timers[id] = Timer(delay, () {
      callback();
      _timers.remove(id);
    });
  }
}
