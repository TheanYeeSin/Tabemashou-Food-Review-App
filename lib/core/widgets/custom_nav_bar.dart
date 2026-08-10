import "package:flutter/material.dart";
import "package:tabemashou/core/theme/custom_themes/nav_bar_theme.dart";
import "package:tabemashou/core/type/common.dart";

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemTapped;
  final List<NavBarItem> items;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    required this.items,
  });

  @override
  Widget build(final BuildContext context) {
    final navTheme = Theme.of(context).extension<TNavBarTheme>()!;

    return Container(
      decoration: BoxDecoration(
        color: navTheme.background,
        border: Border(top: BorderSide(color: navTheme.border)),
      ),
      child: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / items.length;

            return SizedBox(
              height: 62,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    left: itemWidth * currentIndex + itemWidth * 0.32,
                    top: 0,
                    width: itemWidth * 0.36,
                    child: Container(
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: navTheme.activeColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Row(
                    children: List.generate(items.length, (index) {
                      final item = items[index];
                      final isSelected = index == currentIndex;

                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => onItemTapped(index),
                          child: _NavBarItemWidget(
                            item: item,
                            isSelected: isSelected,
                            activeColor: navTheme.activeColor,
                            inactiveColor: navTheme.inactiveColor,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NavBarItemWidget extends StatelessWidget {
  final NavBarItem item;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;

  const _NavBarItemWidget({
    required this.item,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(final BuildContext context) {
    final color = isSelected ? activeColor : inactiveColor;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedScale(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            scale: isSelected ? 1.08 : 1.0,
            child: Icon(item.icon, size: 22, color: color),
          ),
          const SizedBox(height: 5),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              letterSpacing: 0.1,
              color: color,
            ),
            child: Text(item.label),
          ),
        ],
      ),
    );
  }
}
