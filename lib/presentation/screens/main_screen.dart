import "package:flutter/material.dart";
import "package:tabemashou/presentation/widgets/common/custom_nav_bar/custom_nav_bar.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    bottomNavigationBar: CustomNavBar(),
  );
}
