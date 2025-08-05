import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/utils/log/logger.dart";
import "package:tabemashou/domain/category/category.dart";
import "package:tabemashou/presentation/providers/category_provider.dart";
import "package:tabemashou/presentation/widgets/category/category_dialog.dart";
import "package:tabemashou/presentation/widgets/category/category_setting_list_tile.dart";
import "package:tabemashou/presentation/widgets/category/delete_category_dialog.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";

/// CategorySettingScreen: Screen for managing categories
class CategorySettingScreen extends StatefulWidget {
  const CategorySettingScreen({super.key});

  @override
  State<CategorySettingScreen> createState() => _CategorySettingScreenState();
}

class _CategorySettingScreenState extends State<CategorySettingScreen> {
  // ----- Lifecycle -----
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<CategoryProvider>(
        context,
        listen: false,
      ).loadCategories(),
    );
  }

  // ----- Add Category -----
  Future<void> _addCategory() async {
    final result = await showDialog(
      context: context,
      builder: (final context) => const CategoryDialog(),
    );

    if (!mounted || result == null) return;

    final provider = Provider.of<CategoryProvider>(context, listen: false);
    final newCategory = Category(
      name: result["name"],
      description: result["description"],
      image: result["image"],
      order: provider.categories.length,
    );

    await provider.create(newCategory);
    LoggerService.logDebug("Added new category: $newCategory");
  }

  // ----- Edit Category -----
  Future<void> _editCategory(final Category category) async {
    final result = await showDialog(
      context: context,
      builder: (final context) =>
          CategoryDialog(isEdit: true, initialCategory: category),
    );

    if (!mounted || result == null) return;

    final provider = Provider.of<CategoryProvider>(context, listen: false);
    final newCategory = Category(
      id: category.id,
      name: result["name"],
      description: result["description"],
      image: result["image"],
      order: category.order,
    );

    await provider.update(newCategory);
    LoggerService.logDebug("Updated category: $newCategory");
  }

  // ----- Delete Category -----
  Future<void> _deleteCategory(final Category category) async {
    final result = await showDialog(
      context: context,
      builder: (final context) => const DeleteCategoryDialog(),
    );

    if (!mounted || result != true) return;

    final provider = Provider.of<CategoryProvider>(context, listen: false);
    await provider.delete(category.id!);
    LoggerService.logDebug("Deleted category: $category");
  }

  // ----- Reorder -----
  Future<void> _reorder(final int oldIndex, final int newIndex) async {
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    final categories = provider.categories;
    final int adjustedNewIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;

    final updatedList = [...categories];
    final movedItem = updatedList.removeAt(oldIndex);
    updatedList.insert(adjustedNewIndex, movedItem);

    for (int i = 0; i < updatedList.length; i++) {
      updatedList[i] = updatedList[i].copyWith(order: i);
    }

    await provider.reorder(updatedList);

    LoggerService.logDebug(
      '[Category] Moved "${movedItem.name}" from $oldIndex to $adjustedNewIndex. '
      "New order: ${updatedList.map((final c) => c.name).toList()}",
    );
  }

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => Consumer<CategoryProvider>(
    builder: (final context, final provider, final child) {
      final categories = provider.categories;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Category Settings"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: categories.isEmpty
              ? const EmptyPlaceholderView(
                  message: "No categories found. Add one to get started.",
                )
              : ReorderableListView.builder(
            itemCount: categories.length,
            itemBuilder: (final context, final index) =>
                CategorySettingListTile(
                  category: categories[index],
                  index: index,
                  key: ValueKey(categories[index].id),
                  onEdit: _editCategory,
                  onDelete: _deleteCategory,
                ),
            onReorder: _reorder,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addCategory,
          tooltip: "Add Category",
          child: const Icon(Icons.add),
        ),
      );
    },
  );
}
