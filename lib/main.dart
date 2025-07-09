import "package:flutter/material.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/presentation/screens/main_screen.dart";
import "package:tabemashou/presentation/screens/more_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
    title: "Flutter Demo",
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    ),
    home: const MainScreen(title: "Flutter Demo Home Page"),
    routes: {MORE_PATH: (final context) => const MoreScreen()},
  );
}
