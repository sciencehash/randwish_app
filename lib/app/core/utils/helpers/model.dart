import 'dart:ui';

class ModelHelpers {
  static Color? colorFromJson(int? colorAsInt) {
    return colorAsInt == null ? null : Color(colorAsInt);
  }

  static int? colorToJson(Color? color) {
    return color == null ? null : color.value;
  }
}
