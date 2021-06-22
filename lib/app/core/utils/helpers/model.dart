import 'dart:ui';
import 'package:uuid/uuid.dart';

class ModelHelpers {
  static Color? colorFromJson(int? colorAsInt) {
    return colorAsInt == null ? null : Color(colorAsInt);
  }

  static int? colorToJson(Color? color) {
    return color == null ? null : color.value;
  }

  /// Get a unique ID
  static String generateID() {
    var uuid = Uuid();
    return uuid.v4();
  }
}
