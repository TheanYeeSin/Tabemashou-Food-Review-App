import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/app_colors.dart";

class TCardTheme {
  TCardTheme._();

  static CardThemeData lightCardTheme() => CardThemeData(
    color: TAppColors.lightSurface,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: TAppColors.lightBorder, width: 1),
    ),
  );

  static CardThemeData darkCardTheme() => CardThemeData(
    color: TAppColors.darkSurface,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: TAppColors.darkBorder, width: 1),
    ),
  );
}
