import 'package:flutter/material.dart';

class DefaultTheme {
  static ThemeData data = ThemeData(
    visualDensity: VisualDensity.compact,
    scaffoldBackgroundColor: Colors.white,
    accentColor: Colors.blueAccent,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.black87,
          fontSize: 20,
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      actionsIconTheme: IconThemeData(
        color: Color(0xff555555),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black87,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.black87,
      selectedItemColor: Colors.blue.shade900,
      backgroundColor: Colors.transparent,
      elevation: 0,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    cardTheme: CardTheme(
      elevation: 7,
      shadowColor: Colors.black38,
    ),
    dividerColor: Colors.black12,
    tooltipTheme: TooltipThemeData(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(fontSize: 14, height: 1, color: Colors.white),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.blueAccent),
      trackColor: MaterialStateProperty.all(Colors.black12),
    ),
  );
}
