import "package:flutter/material.dart";
import "package:tabemashou/presentation/widgets/category/category_config_bottom_sheet/category_config_layout_view.dart";
import "package:tabemashou/presentation/widgets/category/category_config_bottom_sheet/category_config_sort_view.dart";

enum ConfigView { sort, layout }

class CategoryConfigBottomSheet extends StatefulWidget {
  const CategoryConfigBottomSheet({super.key});

  @override
  State<CategoryConfigBottomSheet> createState() =>
      _CategoryConfigBottomSheetState();
}

class _CategoryConfigBottomSheetState extends State<CategoryConfigBottomSheet> {
  // ----- States -----
  ConfigView configView = ConfigView.sort;

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    width: double.maxFinite,
    child: Column(
      children: [
        SegmentedButton<ConfigView>(
          segments: const <ButtonSegment<ConfigView>>[
            ButtonSegment<ConfigView>(
              value: ConfigView.sort,
              label: Text("Sort"),
              icon: Icon(Icons.sort_outlined),
            ),
            ButtonSegment<ConfigView>(
              value: ConfigView.layout,
              label: Text("Layout"),
              icon: Icon(Icons.grid_view_outlined),
            ),
          ],
          selected: <ConfigView>{configView},
          onSelectionChanged: (final Set<ConfigView> newSelection) =>
              setState(() => configView = newSelection.first),
        ),
        const SizedBox(height: 16),

        // ----- Conditionally Render -----
        if (configView == ConfigView.sort) ...[
          const CategoryConfigSortView(),
        ] else if (configView == ConfigView.layout) ...[
          const CategoryConfigLayoutView(),
        ],
      ],
    ),
  );
}
