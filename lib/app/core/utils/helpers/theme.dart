import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeHelper {
  static setSystemUIOverlayStyle(bool isDarkMode) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode
            ? ThemeData.dark().scaffoldBackgroundColor
            : Color(0xfff7f7f7), // status bar color
        statusBarBrightness: isDarkMode
            ? Brightness.dark
            : Brightness.light, //status bar brigtness
        statusBarIconBrightness: isDarkMode
            ? Brightness.dark
            : Brightness.light, //status barIcon Brightness
        systemNavigationBarColor: Colors.black, // navigation bar color
        systemNavigationBarDividerColor:
            Colors.black, //Navigation bar divider color
        systemNavigationBarIconBrightness:
            Brightness.light, //navigation bar icon
      ),
    );
  }
}
