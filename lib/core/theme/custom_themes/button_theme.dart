import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/app_colors.dart";

class TButtonTheme {
  TButtonTheme._();

  static ElevatedButtonThemeData lightElevatedButtonTheme() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TAppColors.primary,
          foregroundColor: TAppColors.onPrimary,
          disabledBackgroundColor: TAppColors.lightSurfaceVariant,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );

  static ElevatedButtonThemeData darkElevatedButtonTheme() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TAppColors.primary,
          foregroundColor: TAppColors.onPrimary,
          disabledBackgroundColor: TAppColors.darkSurfaceVariant,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );

  static OutlinedButtonThemeData lightOutlinedButtonTheme() =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TAppColors.lightOnSurface,
          side: const BorderSide(color: TAppColors.lightBorder, width: 1.2),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );

  static OutlinedButtonThemeData darkOutlinedButtonTheme() =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: TAppColors.darkOnSurface,
          side: const BorderSide(color: TAppColors.darkBorder, width: 1.2),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      );

  static TextButtonThemeData lightTextButtonTheme() => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TAppColors.lightOnSurface,
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );

  static TextButtonThemeData darkTextButtonTheme() => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: TAppColors.darkOnSurface,
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  );
}
