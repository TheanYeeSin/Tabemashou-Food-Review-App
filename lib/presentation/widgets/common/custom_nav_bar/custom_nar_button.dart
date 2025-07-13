import "package:flutter/material.dart";

class CustomNavButton extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final String label;
  const CustomNavButton({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.label,
  });

  @override
  Widget build(final BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    padding: EdgeInsets.symmetric(
      horizontal: isSelected ? 24 : 0,
      vertical: 12,
    ),
    decoration: BoxDecoration(
      color: isSelected
          ? Colors.blue.withValues(alpha: 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Row(
      children: [
        Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 30),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: isSelected
              ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    ),
  );
}
