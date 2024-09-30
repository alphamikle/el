import '../locale/code_output.dart';

String prettyValue(String? value, {bool nullable = false}) {
  if (value == null || value.isEmpty) {
    if (nullable) {
      return 'null';
    }
    return "''";
  }
  return qu(value, raw: false);
}
