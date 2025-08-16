import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/type/category.dart";
import "package:tabemashou/presentation/providers/category_provider.dart";
import "package:tabemashou/presentation/widgets/category/category_config_bottom_sheet/category_config_bottom_sheet.dart";
import "package:tabemashou/presentation/widgets/category/category_display_card_item.dart";
import "package:tabemashou/presentation/widgets/category/category_display_grid_item.dart";
import "package:tabemashou/presentation/widgets/category/category_display_list_item.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";

class HomeCategoriesScreen extends StatefulWidget {
  const HomeCategoriesScreen({super.key});

  @override
  State<HomeCategoriesScreen> createState() => _HomeCategoriesScreenState();
}

class _HomeCategoriesScreenState extends State<HomeCategoriesScreen> {
  @override
  Widget build(final BuildContext context) => Consumer<CategoryProvider>(
    builder: (final context, final provider, final child) {
      final categories = provider.loadSortedCategories();
      final layout = provider.layoutMode;

      return Scaffold(
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
