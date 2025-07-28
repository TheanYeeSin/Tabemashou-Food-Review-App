import "package:flutter/material.dart";

class TBottomNavigationBarTheme {
  TBottomNavigationBarTheme._();

  static BottomNavigationBarThemeData lightBottomNavigationBarTheme() =>
      BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[300],
        elevation: 2,
      ).copyWith();
  static BottomNavigationBarThemeData darkBottomNavigationBarTheme() =>
      const BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        elevation: 2,
      ).copyWith();
}
