typedef Checker<T> = bool Function(T value);
typedef PresenceTest<T> = bool Function(T it);
typedef Spreader<T> = List<Object> Function(int index, T value);
typedef AsyncSpreader<T> = Future<List<Object>> Function(int index, T value);
typedef Mapper<T, V> = V Function(int index, T value);

extension ExtendedList<T> on List<T> {
  T? firstWhereOrNull(PresenceTest<T> test) {
    for (final T item in this) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }

  List<V> mapIndexed<V>(Mapper<T, V?> mapper) {
    final List<V> result = [];
    for (int i = 0; i < length; i++) {
      final V? mapped = mapper(i, this[i]);
      if (mapped != null) {
        result.add(mapped);
      }
    }
    return result;
  }
}

extension ExtendedString on String {
  String mapIndexed(Mapper<String, String?> mapper) {
    final StringBuffer buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      final String? mapped = mapper(i, this[i]);
      if (mapped != null) {
        buffer.write(mapped);
      }
    }
    return buffer.toString();
  }
}

extension ExtendedInt on int {
  List<Object> spread<T>(List<T> collection, Spreader<T> spreader) {
    return spreader(this, collection[this]);
  }

  Future<List<Object>> spreadAsync<T>(
      List<T> collection, AsyncSpreader<T> spreader) async {
    return spreader(this, collection[this]);
  }
}

extension ExtendedMap on Map<Object, Object?> {
  int get deepSize {
    int size = 0;

    for (final MapEntry(value: value) in entries) {
      if (value is Map<Object, Object?>) {
        size += value.deepSize;
      } else if (value is List<Object?>) {
        size += value.length;
      } else {
        size += 1;
      }
    }

    return size;
  }
}
