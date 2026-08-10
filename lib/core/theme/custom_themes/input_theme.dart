import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/app_colors.dart";

class TInputTheme {
  TInputTheme._();

  static InputDecorationTheme lightInputTheme() => InputDecorationTheme(
    filled: true,
    fillColor: TAppColors.lightSurface,
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    hintStyle: const TextStyle(
      color: TAppColors.lightOnSurfaceVariant,
      fontSize: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: TAppColors.primaryDark, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: TAppColors.lightError, width: 1.2),
    ),
  );

  static InputDecorationTheme darkInputTheme() => InputDecorationTheme(
    filled: true,
    fillColor: TAppColors.darkSurfaceVariant,
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    hintStyle: const TextStyle(
      color: TAppColors.darkOnSurfaceVariant,
      fontSize: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: TAppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: TAppColors.darkError, width: 1.2),
    ),
  );
}
