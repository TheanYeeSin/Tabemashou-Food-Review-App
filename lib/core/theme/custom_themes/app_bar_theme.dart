import "package:flutter/material.dart";

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme lightAppBarTheme() => AppBarTheme(
    backgroundColor: Colors.grey[300],
    elevation: 2,
    foregroundColor: Colors.black,
  ).copyWith();
  static AppBarTheme darkAppBarTheme() => const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 2,
    foregroundColor: Colors.white,
  ).copyWith();
}
