typedef Json = Map<String, dynamic>;
typedef DJson = Map<dynamic, dynamic>;

const String kScheme = 'scheme';

extension FlexibleObject on Object {
  T? get<T>(String key) {
    if (this is Map) {
      final Object? value = (this as Map)[key];
      if (value is T) {
        return value;
      }
      return null;
    }
    return null;
  }
}
