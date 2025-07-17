import "package:flutter/material.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/core/theme/theme.dart";
import "package:tabemashou/core/utils/log/logger.dart";
import "package:tabemashou/presentation/screens/checklist_screen.dart";
import "package:tabemashou/presentation/screens/main_navigator_screen.dart";
import "package:tabemashou/presentation/screens/more_screen.dart";
import "package:tabemashou/presentation/screens/review_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logger
  await LoggerService.init();
  LoggerService.logInfo("App started");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
    title: "Flutter Demo",
    theme: TAppTheme.lightTheme(),
    darkTheme: TAppTheme.darkTheme(),
    home: const MainNavigatorScreen(),
    routes: {
      MORE_PATH: (final context) => const MoreScreen(),
      MAIN_REVIEW_PATH: (final context) => const ReviewScreen(),
      CHECKLIST_PATH: (final context) => const ChecklistScreen(),
    },
  );
}
