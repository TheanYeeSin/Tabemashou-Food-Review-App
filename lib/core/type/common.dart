import "package:flutter/material.dart";

class NavBarItem {
  final IconData icon;
  final String label;
  final String path;
  final Widget screen;

  NavBarItem({
    required this.icon,
    required this.label,
    required this.path,
    required this.screen,
  });
}
