import "package:flutter/material.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/core/type/common.dart";
import "package:tabemashou/presentation/screens/checklist_screen.dart";
import "package:tabemashou/presentation/screens/home_screen.dart";
import "package:tabemashou/presentation/screens/more_screen.dart";
import "package:tabemashou/presentation/screens/review_screen.dart";
import "package:tabemashou/presentation/widgets/common/custom_nav_bar/custom_nav_bar.dart";

class MainNavigatorScreen extends StatefulWidget {
  const MainNavigatorScreen({super.key});

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  int _currentIndex = 2;

  void _onItemTapped(final int index) => setState(() => _currentIndex = index);

  final _items = [
    NavBarItem(
      icon: Icons.checklist_outlined,
      label: "Checklist",
      path: CHECKLIST_PATH,
      screen: const ChecklistScreen(),
    ),
    NavBarItem(
      icon: Icons.reviews_outlined,
      label: "Reviews",
      path: MAIN_REVIEW_PATH,
      screen: const ReviewScreen(),
    ),
    NavBarItem(
      icon: Icons.home_outlined,
      label: "Home",
      path: HOME_PATH,
      screen: const HomeScreen(),
    ),
    NavBarItem(
      icon: Icons.more_horiz_outlined,
      label: "More",
      path: MORE_PATH,
      screen: const MoreScreen(),
    ),
  ];

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
