import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/type/category.dart";
import "package:tabemashou/presentation/providers/category_provider.dart";

class CategoryConfigLayoutView extends StatefulWidget {
  const CategoryConfigLayoutView({super.key});

  @override
  State<CategoryConfigLayoutView> createState() =>
      _CategoryConfigLayoutViewState();
}

class _CategoryConfigLayoutViewState extends State<CategoryConfigLayoutView> {
  final _layoutImages = {
    CategoryLayoutMode.list: "assets/layouts/list.png",
    CategoryLayoutMode.card: "assets/layouts/card.png",
    CategoryLayoutMode.grid: "assets/layouts/grid.png",
  };

  // ----- Build -----
  @override
  Widget build(final BuildContext context) {
    final provider = context.watch<CategoryProvider>();
    final selectedMode = provider.layoutMode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----- Display Mode -----
        const Text("Display Mode"),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: _layoutImages.entries.map((final e) {
            final isSelected = selectedMode == e.key;

            return GestureDetector(
              onTap: () => provider.setLayoutMode(e.key),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(e.value, height: 180, fit: BoxFit.cover),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        // ----- Overlay Mode -----
        const Text("Overlay"),
      ],
    );
  }
}
