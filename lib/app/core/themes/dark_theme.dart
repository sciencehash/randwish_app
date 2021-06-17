import 'package:flutter/material.dart';

class DarkTheme {
  static ThemeData data = ThemeData(
    visualDensity: VisualDensity.compact,
    scaffoldBackgroundColor: Color(0xFF2C2C2C),
    accentColor: Colors.blueAccent,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF2C2C2C),
      elevation: 0,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.white70,
      selectedItemColor: Colors.blueAccent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
    ),
    tooltipTheme: TooltipThemeData(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.9),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: TextStyle(fontSize: 14, height: 1, color: Colors.black),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.blueAccent),
      trackColor: MaterialStateProperty.all(Colors.white24),
    ),
  );
}
