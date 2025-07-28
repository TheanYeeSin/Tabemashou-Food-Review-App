import "package:flutter/material.dart";
import "package:tabemashou/core/type/common.dart";
import "package:tabemashou/presentation/widgets/common/custom_nav_bar/custom_nar_button.dart";

class CustomNavBar extends StatefulWidget {
  final int currentIndex;
  final void Function(int index) onItemTapped;
  final List<NavBarItem> items;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late final List<NavBarItem> _items = widget.items;

  @override
  Widget build(final BuildContext context) => BottomAppBar(
    elevation: 10,
    color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_items.length, (final index) {
          final isSelected = widget.currentIndex == index;
          return GestureDetector(
            onTap: () => widget.onItemTapped(index),
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
