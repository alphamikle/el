Never nullValueException({String? key}) {
  throw NullValueException(
      'Null value is not acceptable${key == null ? '' : ' at the field $key'}');
}

class NullValueException implements Exception {
  const NullValueException(this.message);

  final String message;

  @override
  String toString() {
    return 'NullValueException(message: "$message")';
  }
}
