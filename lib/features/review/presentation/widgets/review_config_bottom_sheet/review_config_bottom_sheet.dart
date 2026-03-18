import "package:flutter/material.dart";
import "package:tabemashou/features/review/presentation/widgets/review_config_bottom_sheet/review_config_layout_view.dart";

enum ConfigView { filter, sort, layout }

class ReviewConfigBottomSheet extends StatefulWidget {
  const ReviewConfigBottomSheet({super.key});

  @override
  State<ReviewConfigBottomSheet> createState() =>
      _ReviewConfigBottomSheetState();
}

class _ReviewConfigBottomSheetState extends State<ReviewConfigBottomSheet> {
  // ----- States -----
  ConfigView configView = ConfigView.filter;

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
              value: ConfigView.filter,
              label: Text("Filter"),
              icon: Icon(Icons.filter_list_outlined),
            ),
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
        if (configView == ConfigView.sort)
          ...[
          
        ] else if (configView == ConfigView.layout) ...[
          const ReviewConfigLayoutView(),
        ],
      ],
    ),
  );
}
