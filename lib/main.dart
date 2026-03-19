import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/core/theme/theme.dart";
import "package:tabemashou/core/utils/log/logger.dart";
import "package:tabemashou/features/category/data/category_local_source.dart";
import "package:tabemashou/features/category/domain/category_repository_impl.dart";
import "package:tabemashou/features/category/presentation/providers/category_provider.dart";
import "package:tabemashou/features/category/presentation/screens/category_setting_screen.dart";
import "package:tabemashou/features/checklist/data/checklist_item_local_source.dart";
import "package:tabemashou/features/checklist/domain/checklist_item_repository_impl.dart";
import "package:tabemashou/features/checklist/presentation/providers/checklist_item_provider.dart";
import "package:tabemashou/features/checklist/presentation/screens/home_checklist_screen.dart";
import "package:tabemashou/features/review/data/review_local_source.dart";
import "package:tabemashou/features/review/domain/review_repository_impl.dart";
import "package:tabemashou/features/review/presentation/providers/review_provider.dart";
import "package:tabemashou/features/review/presentation/screens/review_form_screen.dart";
import "package:tabemashou/presentation/screens/about_screen.dart";
import "package:tabemashou/presentation/screens/main_navigator_screen.dart";
import "package:tabemashou/presentation/screens/settings/settings_screen.dart";
import "package:tabemashou/presentation/screens/tabs/categories_screen.dart";
import "package:tabemashou/presentation/screens/tabs/home_screen.dart";
import "package:tabemashou/presentation/screens/tabs/more_screen.dart";
import "package:tabemashou/presentation/screens/tabs/random_restaurant_screen.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ----- Logger -----
  await LoggerService.init();
  LoggerService.logInfo("App started");

  // ----- Category Source -----
  final categoryLocalSource = CategoryLocalSource();
  final categoryRepository = CategoryRepositoryImpl(local: categoryLocalSource);

  // ----- Checklist Item Source -----
  final checklistLocalSource = ChecklistItemLocalSource();
  final checklistRepository = ChecklistItemRepositoryImpl(
    local: checklistLocalSource,
  );

  // // ----- Review Source -----
  final reviewLocalSource = ReviewLocalSource();
  final reviewRepository = ReviewRepositoryImpl(local: reviewLocalSource);

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
              ChecklistItemProvider(repository: checklistRepository)
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
