import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/core/theme/theme.dart";
import "package:tabemashou/core/utils/log/logger.dart";
import "package:tabemashou/features/about/screens/about_screen.dart";
import "package:tabemashou/features/category/category_repository.dart";
import "package:tabemashou/features/category/providers/category_provider.dart";
import "package:tabemashou/features/category/screens/categories_screen.dart";
import "package:tabemashou/features/category/screens/category_setting_screen.dart";
import "package:tabemashou/features/checklist/checklist_item_repository.dart";
import "package:tabemashou/features/checklist/providers/checklist_item_provider.dart";
import "package:tabemashou/features/checklist/screens/home_checklist_screen.dart";
import "package:tabemashou/features/home/screens/home_screen.dart";
import "package:tabemashou/features/more/screens/more_screen.dart";
import "package:tabemashou/features/random_restaurant/screens/random_restaurant_screen.dart";
import "package:tabemashou/features/review/providers/review_provider.dart";
import "package:tabemashou/features/review/review_repository.dart";
import "package:tabemashou/features/review/screens/review_form_screen.dart";
import "package:tabemashou/features/settings/screens/settings_screen.dart";
import "package:tabemashou/shell/main_navigator_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ----- Logger -----
  await LoggerService.init();
  LoggerService.logInfo("App started");

  // ----- Category Source -----
  final categoryRepository = CategoryRepository();

  // ----- Checklist Item Source -----
  final checklistItemRepository = ChecklistItemRepository();

  // // ----- Review Source -----
  final reviewRepository = ReviewRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              CategoryProvider(repository: categoryRepository)
                ..loadCategories(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ChecklistItemProvider(repository: checklistItemRepository)
                ..loadChecklistItems(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              ReviewProvider(repository: reviewRepository)..loadReviews(),
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
      MAIN_REVIEW_PATH: (final context) => const CategoriesScreen(),
      RANDOM_RESTAURANT_PATH: (final context) => const RandomRestaurantScreen(),
      CHECKLIST_PATH: (final context) => const HomeChecklistScreen(),
      SETTINGS_PATH: (final context) => const SettingsScreen(),
      CATEGORY_SETTINGS_PATH: (final context) => const CategorySettingScreen(),
      REVIEW_FORM_PATH: (final context) => const ReviewFormScreen(),
    },
  );
}
