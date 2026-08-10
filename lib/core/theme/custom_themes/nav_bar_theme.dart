import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/app_colors.dart";

class TNavBarTheme extends ThemeExtension<TNavBarTheme> {
  final Color background;
  final Color activeColor;
  final Color inactiveColor;
  final Color border;

  const TNavBarTheme({
    required this.background,
    required this.activeColor,
    required this.inactiveColor,
    required this.border,
  });

  static const light = TNavBarTheme(
    background: TAppColors.lightBackground,
    activeColor: TAppColors.primaryDark,
    inactiveColor: TAppColors.lightOnSurfaceVariant,
    border: TAppColors.lightBorder,
  );

  static const dark = TNavBarTheme(
    background: TAppColors.darkSurface,
    activeColor: TAppColors.primary,
    inactiveColor: TAppColors.darkOnSurfaceVariant,
    border: TAppColors.darkBorder,
  );

  @override
  TNavBarTheme copyWith({
    final Color? background,
    final Color? activeColor,
    final Color? inactiveColor,
    final Color? border,
  }) => TNavBarTheme(
    background: background ?? this.background,
    activeColor: activeColor ?? this.activeColor,
    inactiveColor: inactiveColor ?? this.inactiveColor,
    border: border ?? this.border,
  );

  @override
  TNavBarTheme lerp(final ThemeExtension<TNavBarTheme>? other, final double t) {
    if (other is! TNavBarTheme) return this;
    return TNavBarTheme(
      background: Color.lerp(background, other.background, t)!,
      activeColor: Color.lerp(activeColor, other.activeColor, t)!,
      inactiveColor: Color.lerp(inactiveColor, other.inactiveColor, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}
