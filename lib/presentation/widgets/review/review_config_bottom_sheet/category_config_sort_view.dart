import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/type/category.dart";
import "package:tabemashou/features/category/presentation/providers/category_provider.dart";

class CategoryConfigSortView extends StatefulWidget {
  const CategoryConfigSortView({super.key});

  @override
  State<CategoryConfigSortView> createState() => _CategoryConfigSortViewState();
}

class _CategoryConfigSortViewState extends State<CategoryConfigSortView> {
  // ----- Build -----
  @override
  Widget build(final BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    final sortMode = provider.sortMode;
    final sortOrder = provider.sortOrder;

    void onTap(final CategorySortMode mode) {
      if (sortMode == mode) {
        provider.setSortOrder(
          sortOrder == CategorySortOrder.asc
              ? CategorySortOrder.desc
              : CategorySortOrder.asc,
        );
      } else {
        provider
          ..setSortMode(mode)
          ..setSortOrder(CategorySortOrder.asc);
      }
    }

    final modes = {
      CategorySortMode.name: "Name",
      CategorySortMode.order: "Order",
    };

    return ListView(
      shrinkWrap: true,
      children: modes.entries.map((final entry) {
        final mode = entry.key;
        final label = entry.value;
        final isSelected = mode == sortMode;

        final arrowIcon = isSelected
            ? (sortOrder == CategorySortOrder.asc
                  ? const Icon(Icons.arrow_upward, size: 20)
                  : const Icon(Icons.arrow_downward, size: 20))
            : const SizedBox.shrink();

        return ListTile(
          leading: SizedBox(width: 24, child: arrowIcon),
          title: Text(label),
          selected: isSelected,
          onTap: () => onTap(mode),
        );
      }).toList(),
    );
  }
}
