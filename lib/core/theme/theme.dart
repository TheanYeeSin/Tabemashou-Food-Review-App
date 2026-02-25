import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/app_bar_theme.dart";
import "package:tabemashou/core/theme/custom_themes/bottom_navigation_bar_theme.dart";
import "package:tabemashou/core/theme/custom_themes/text_theme.dart";

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme() => ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.lightTextTheme(),
    appBarTheme: TAppBarTheme.lightAppBarTheme(),
    bottomNavigationBarTheme:
        TBottomNavigationBarTheme.lightBottomNavigationBarTheme(),
  );
  static ThemeData darkTheme() => ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: TTextTheme.darkTextTheme(),
    appBarTheme: TAppBarTheme.darkAppBarTheme(),
    bottomNavigationBarTheme:
        TBottomNavigationBarTheme.darkBottomNavigationBarTheme(),
  );
}
