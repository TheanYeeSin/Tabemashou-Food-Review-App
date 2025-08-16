import "package:flutter/material.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/core/type/common.dart";
import "package:tabemashou/presentation/screens/checklist_screen.dart";
import "package:tabemashou/presentation/screens/home_screen.dart";
import "package:tabemashou/presentation/screens/more_screen.dart";
import "package:tabemashou/presentation/screens/random_restaurant_screen.dart";
import "package:tabemashou/presentation/screens/home_categories_screen.dart";
import "package:tabemashou/presentation/widgets/common/custom_nav_bar.dart";

class MainNavigatorScreen extends StatefulWidget {
  const MainNavigatorScreen({super.key});

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  // ----- Index handling -----
  int _currentIndex = 2;
  void _onItemTapped(final int index) => setState(() => _currentIndex = index);

  // ----- Navigation Bar Items -----
  final _items = [
    NavBarItem(
      icon: Icons.checklist_outlined,
      selectedIcon: Icons.checklist_rounded,
      label: "Checklist",
      path: CHECKLIST_PATH,
      screen: const ChecklistScreen(),
    ),
    NavBarItem(
      icon: Icons.reviews_outlined,
      selectedIcon: Icons.reviews_rounded,
      label: "Reviews",
      path: MAIN_REVIEW_PATH,
      screen: const HomeCategoriesScreen(),
    ),
    NavBarItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home_rounded,
      label: "Home",
      path: HOME_PATH,
      screen: const HomeScreen(),
    ),
    NavBarItem(
      icon: Icons.ramen_dining_outlined,
      selectedIcon: Icons.ramen_dining_rounded,
      label: "Random",
      path: RANDOM_RESTAURANT_PATH,
      screen: const RandomRestaurantScreen(),
    ),
    NavBarItem(
      icon: Icons.more_horiz_outlined,
      selectedIcon: Icons.more_horiz_rounded,
      label: "More",
      path: MORE_PATH,
      screen: const MoreScreen(),
    ),
  ];

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => Scaffold(
    body: _items[_currentIndex].screen,
    bottomNavigationBar: CustomNavBar(
      currentIndex: _currentIndex,
      onItemTapped: _onItemTapped,
      items: _items,
    ),
  );
}
