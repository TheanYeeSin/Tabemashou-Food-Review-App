import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/core/type/category.dart";
import "package:tabemashou/features/category/presentation/providers/category_provider.dart";
import "package:tabemashou/features/category/presentation/widgets/category_config_bottom_sheet/category_config_bottom_sheet.dart";
import "package:tabemashou/features/category/presentation/widgets/category_display_card_item.dart";
import "package:tabemashou/features/category/presentation/widgets/category_display_grid_item.dart";
import "package:tabemashou/features/category/presentation/widgets/category_display_list_item.dart";
import "package:tabemashou/features/review/domain/review.dart";
import "package:tabemashou/features/review/presentation/providers/review_provider.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(final BuildContext context) => Consumer<CategoryProvider>(
    builder: (final context, final provider, final child) {
      final categories = provider.loadSortedCategories();
      final layout = provider.layoutMode;

      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(
              context,
            ).pushNamed(REVIEW_FORM_PATH);

            // If user cancelled the form
            if (result == null) return;

            // Safely cast
            final review = result as Review;

            debugPrint(review.toString());

            // Avoid context after async gap: check mounted
            if (!mounted) return;

            // Add review using provider
            context.read<ReviewProvider>().create(review);
          },

          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Reviews"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (final BuildContext context) =>
                    const CategoryConfigBottomSheet(),
              ),
              icon: const Icon(Icons.tune_outlined),
            ),
          ],
        ),
        body: categories.isEmpty
            ? const EmptyPlaceholderView(
                message: "No category found, add one in the settings",
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: switch (layout) {
                  CategoryLayoutMode.list => ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (final context, final index) =>
                        CategoryDisplayListItem(category: categories[index]),
                  ),
                  CategoryLayoutMode.card => ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (final context, final index) =>
                        CategoryDisplayCardItem(category: categories[index]),
                  ),
                  CategoryLayoutMode.grid => GridView.builder(
                    itemCount: categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemBuilder: (final context, final index) =>
                        CategoryDisplayGridItem(category: categories[index]),
                  ),
                },
              ),
      );
    },
  );
}
