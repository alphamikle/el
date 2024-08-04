import '../type/types.dart';

typedef DMap = Map<dynamic, dynamic>;

extension EmptyableMap on DMap {
  Json empty() {
    final Json result = {};
    for (final MapEntry(:key, :value) in entries) {
      final String strKey = key is String ? key : key.toString();

      if (value is String || value is bool || value is num || value == null) {
        result[strKey] = '';
      } else if (value is Map) {
        result[strKey] = value.empty();
      } else if (value is List) {
        throw Exception('Unsupported type of data');
      }
    }
    return result;
  }
}
