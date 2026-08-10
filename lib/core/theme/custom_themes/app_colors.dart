import "package:flutter/material.dart";

class TAppColors {
  TAppColors._();

  // ----- Brand (muted moss) -----
  static const primary = Color(0xFF6B7A5E); // moss green — main accent
  static const primaryLight = Color(
    0xFF8B9A7E,
  ); // lighter tint, dark-mode accent
  static const primaryDark = Color(
    0xFF4F5D45,
  ); // deeper shade, pressed/emphasis states
  static const onPrimary = Color(0xFFFFFFFF); // text/icons on top of primary

  // ----- Light theme (warm neutral base) -----
  static const lightBackground = Color(
    0xFFFDFBF7,
  ); // warm off-white, not stark white
  static const lightSurface = Color(0xFFF5F1E8); // warm cream for cards/inputs
  static const lightSurfaceVariant = Color(0xFFEFE9DD);
  static const lightOnSurface = Color(
    0xFF2E2A22,
  ); // warm near-black, not pure black
  static const lightOnSurfaceVariant = Color(0xFF8F8A7D); // muted warm gray
  static const lightBorder = Color(0x142E2A22); // 8% warm black
  static const lightError = Color(0xFFB9563F); // warm muted red, fits palette

  // ----- Dark theme -----
  static const darkBackground = Color(0xFF17160F); // warm near-black
  static const darkSurface = Color(0xFF201F17);
  static const darkSurfaceVariant = Color(0xFF2B2A20);
  static const darkOnSurface = Color(0xFFF2EFE6); // warm off-white
  static const darkOnSurfaceVariant = Color(0xFF9A968A);
  static const darkBorder = Color(0x14F2EFE6); // 8% warm white
  static const darkError = Color(0xFFD9836C);
}
