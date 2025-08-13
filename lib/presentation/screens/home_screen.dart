import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/presentation/providers/category_provider.dart";
import "package:tabemashou/presentation/widgets/category/category_carousel.dart";
import "package:tabemashou/presentation/widgets/checklist/checklist_preview.dart";
import "package:tabemashou/presentation/widgets/common/section_title.dart";
import "package:tabemashou/presentation/widgets/common/stat_card.dart";
import "package:tabemashou/presentation/widgets/review/recent_reviews_list.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final greeting = _getGreeting();

    return Consumer<CategoryProvider>(
      builder: (final context, final provider, final child) {
        final categories = provider.loadSortedCategories();
        return Scaffold(
          appBar: AppBar(title: Text("$greeting👋"), elevation: 0),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatsRow(),
                const SizedBox(height: 20),

                // ----- Categories -----
                const SectionTitle(
                  title: "Categories",
                  path: CATEGORY_SETTINGS_PATH,
                ),
                CategoryCarousel(categories: categories),
                const SizedBox(height: 20),

                // ----- Recent Reviews -----
                const SectionTitle(
                  title: "Recent Reviews",
                  path: MAIN_REVIEW_PATH,
                ),
                const RecentReviewsList(),
                const SizedBox(height: 20),

                // ----- Checklist -----
                const SectionTitle(title: "Checklist", path: CHECKLIST_PATH),
                const ChecklistPreview(),
                const SizedBox(height: 20),

                // ----- TODO: Recommendation based on last ate + favourite + categories -----
                // ----- TODO: Food Quote Offline -----
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsRow() => const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      StatCard(
        icon: Icons.restaurant_menu_outlined,
        title: "Categories",
        count: 12,
        route: CATEGORY_SETTINGS_PATH,
      ),
      StatCard(
        icon: Icons.star,
        title: "Reviews",
        count: 12,
        route: MAIN_REVIEW_PATH,
      ),
      StatCard(
        icon: Icons.checklist,
        title: "Checklist",
        count: 3,
        route: CHECKLIST_PATH,
      ),
    ],
  );

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }
}
