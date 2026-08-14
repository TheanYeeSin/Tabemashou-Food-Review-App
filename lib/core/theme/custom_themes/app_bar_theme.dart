import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/app_colors.dart";

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme lightAppBarTheme() => const AppBarTheme(
    backgroundColor: TAppColors.lightBackground,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    foregroundColor: TAppColors.lightOnSurface,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: TAppColors.lightOnSurface,
    ),
  );

  static AppBarTheme darkAppBarTheme() => const AppBarTheme(
    backgroundColor: TAppColors.darkBackground,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    foregroundColor: TAppColors.darkOnSurface,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: TAppColors.darkOnSurface,
    ),
  );
}
