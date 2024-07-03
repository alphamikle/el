typedef Checker<T> = bool Function(T value);

extension ExtendedList<T> on List<T> {
  T? firstWhereOrNull(Checker<T> checker) {
    for (final T value in this) {
      if (checker(value)) {
        return value;
      }
    }
    return null;
  }
}
