import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/app_bar_theme.dart";
import "package:tabemashou/core/theme/custom_themes/app_colors.dart";
import "package:tabemashou/core/theme/custom_themes/bottom_navigation_bar_theme.dart";
import "package:tabemashou/core/theme/custom_themes/button_theme.dart";
import "package:tabemashou/core/theme/custom_themes/card_theme.dart";
import "package:tabemashou/core/theme/custom_themes/input_theme.dart";
import "package:tabemashou/core/theme/custom_themes/nav_bar_theme.dart";
import "package:tabemashou/core/theme/custom_themes/text_theme.dart";

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme() => ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.light,
    scaffoldBackgroundColor: TAppColors.lightBackground,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.light(
      primary: TAppColors.primary,
      onPrimary: TAppColors.onPrimary,
      surface: TAppColors.lightSurface,
      onSurface: TAppColors.lightOnSurface,
      onSurfaceVariant: TAppColors.lightOnSurfaceVariant,
      error: TAppColors.lightError,
    ),
    textTheme: TTextTheme.lightTextTheme(),
    appBarTheme: TAppBarTheme.lightAppBarTheme(),
    bottomNavigationBarTheme:
        TBottomNavigationBarTheme.lightBottomNavigationBarTheme(),
    elevatedButtonTheme: TButtonTheme.lightElevatedButtonTheme(),
    outlinedButtonTheme: TButtonTheme.lightOutlinedButtonTheme(),
    textButtonTheme: TButtonTheme.lightTextButtonTheme(),
    inputDecorationTheme: TInputTheme.lightInputTheme(),
    cardTheme: TCardTheme.lightCardTheme(),
    dividerColor: TAppColors.lightBorder,
    extensions: const [TNavBarTheme.light],
  );

  static ThemeData darkTheme() => ThemeData(
    useMaterial3: true,
    fontFamily: "Poppins",
    brightness: Brightness.dark,
    scaffoldBackgroundColor: TAppColors.darkBackground,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: TAppColors.primary,
      onPrimary: TAppColors.onPrimary,
      surface: TAppColors.darkSurface,
      onSurface: TAppColors.darkOnSurface,
      onSurfaceVariant: TAppColors.darkOnSurfaceVariant,
      error: TAppColors.darkError,
    ),
    textTheme: TTextTheme.darkTextTheme(),
    appBarTheme: TAppBarTheme.darkAppBarTheme(),
    bottomNavigationBarTheme:
        TBottomNavigationBarTheme.darkBottomNavigationBarTheme(),
    elevatedButtonTheme: TButtonTheme.darkElevatedButtonTheme(),
    outlinedButtonTheme: TButtonTheme.darkOutlinedButtonTheme(),
    textButtonTheme: TButtonTheme.darkTextButtonTheme(),
    inputDecorationTheme: TInputTheme.darkInputTheme(),
    cardTheme: TCardTheme.darkCardTheme(),
    dividerColor: TAppColors.darkBorder,
    extensions: const [TNavBarTheme.dark],
  );
}
