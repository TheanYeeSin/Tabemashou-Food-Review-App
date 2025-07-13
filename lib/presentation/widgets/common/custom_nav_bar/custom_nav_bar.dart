import "package:flutter/material.dart";
import "package:tabemashou/presentation/widgets/common/custom_nav_bar/custom_nar_button.dart";

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final _items = [
    _NavBarItem(icon: Icons.checklist_rounded, label: "Checklist"),
    _NavBarItem(icon: Icons.reviews, label: "Reviews"),
    _NavBarItem(icon: Icons.more_horiz, label: "More"),
  ];

  int _currentIndex = 1;
  void _onItemTapped(final int index) => setState(() => _currentIndex = index);

  @override
  Widget build(final BuildContext context) => BottomAppBar(
    elevation: 10,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_items.length, (final index) {
          final isSelected = _currentIndex == index;

          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: CustomNavButton(
              icon: _items[index].icon,
              isSelected: isSelected,
              label: _items[index].label,
            ),
          );
        }),
      ),
    ),
  );
}

class _NavBarItem {
  final IconData icon;
  final String label;

  _NavBarItem({required this.icon, required this.label});
}
