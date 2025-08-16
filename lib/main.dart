import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/core/theme/theme.dart";
import "package:tabemashou/core/utils/log/logger.dart";
import "package:tabemashou/data/category/category_local_source.dart";
import "package:tabemashou/domain/category/category_repository_impl.dart";
import "package:tabemashou/presentation/providers/category_provider.dart";
import "package:tabemashou/presentation/screens/about_screen.dart";
import "package:tabemashou/presentation/screens/checklist_screen.dart";
import "package:tabemashou/presentation/screens/home_screen.dart";
import "package:tabemashou/presentation/screens/main_navigator_screen.dart";
import "package:tabemashou/presentation/screens/more_screen.dart";
import "package:tabemashou/presentation/screens/random_restaurant_screen.dart";
import "package:tabemashou/presentation/screens/home_categories_screen.dart";
import "package:tabemashou/presentation/screens/settings/category_setting_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ----- Logger -----
  await LoggerService.init();
  LoggerService.logInfo("App started");

  // ----- Category Source -----
  final localSource = CategoryLocalSource();
  final repository = CategoryRepositoryImpl(local: localSource);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              CategoryProvider(repository: repository)..loadCategories(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) => MaterialApp(
    title: "Tabemashou",
    theme: TAppTheme.lightTheme(),
    darkTheme: TAppTheme.darkTheme(),
    home: const MainNavigatorScreen(),
    routes: {
      HOME_PATH: (final context) => const HomeScreen(),
      ABOUT_PATH: (final context) => const AboutScreen(),
      MORE_PATH: (final context) => const MoreScreen(),
      MAIN_REVIEW_PATH: (final context) => const HomeCategoriesScreen(),
      RANDOM_RESTAURANT_PATH: (final context) => const RandomRestaurantScreen(),
      CHECKLIST_PATH: (final context) => const ChecklistScreen(),
      CATEGORY_SETTINGS_PATH: (final context) => const CategorySettingScreen(),
    },
  );
}
