class CloneHelper {
  /// Clone a value.
  static dynamic _cloneValue(dynamic value) {
    if (value is Map) {
      return value.map<String, Object?>(
          (key, value) => MapEntry(key as String, _cloneValue(value)));
    }
    if (value is Iterable) {
      return value.map((value) => _cloneValue(value)).toList();
    }
    return value;
  }

  /// Clone a map to make it writable.
  ///
  /// This should be used to create a writable object that can be modified
  static Map<String, Object?> cloneMap(Map value) =>
      cloneValue(value) as Map<String, Object?>;

  /// Clone a list to make it writable.
  ///
  /// This should be used to create a writable object that can be modified
  static List<Object?> cloneList(List<Object?> value) =>
      cloneValue(value) as List<Object?>;

  /// Clone a value to make it writable, typically a list or a map.
  ///
  /// Other supported object remains as is.
  ///
  /// This should be used to create a writable object that can be modified.
  static dynamic cloneValue(dynamic value) => _cloneValue(value);
}
