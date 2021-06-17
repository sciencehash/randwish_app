extension IntExtension on int {
  String _removeEmptyDecimal(String value) {
    if (value.endsWith('.0')) return value.substring(0, value.length - 2);
    return value;
  }

  /// Convert int to friendly format. Ex: 10000 to 10K
  String toFriendlyString() {
    try {
      int value = this;

      if (value < 1000) {
        // Less than a thousand
        return value.toString();
      } else if (value >= 1000 && value < 1000000) {
        // Less than a million
        double result = value / 1000;
        return _removeEmptyDecimal(result.toStringAsFixed(1)) + "K";
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // Less than 100 million
        double result = value / 1000000;
        return _removeEmptyDecimal(result.toStringAsFixed(1)) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // Less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return _removeEmptyDecimal(result.toStringAsFixed(1)) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // Less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return _removeEmptyDecimal(result.toStringAsFixed(1)) + "T";
      }
    } catch (e) {
      print(e);
    }
    return '';
  }
}
