import '../locale/code_output.dart';

String prettyValue(String? value) {
  if (value == null || value.isEmpty) {
    return "''";
  }
  return "$qt$value$qt";
}
