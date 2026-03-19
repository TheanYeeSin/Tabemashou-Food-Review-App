import "package:flutter/material.dart";
import "package:tabemashou/features/checklist/presentation/widgets/checklist_config_bottom_sheet/checklist_config_filter_view.dart";

enum ConfigView { filter, sort, layout }

class ChecklistConfigBottomSheet extends StatefulWidget {
  const ChecklistConfigBottomSheet({super.key});

  @override
  State<ChecklistConfigBottomSheet> createState() =>
      _ChecklistConfigBottomSheetState();
}

class _ChecklistConfigBottomSheetState
    extends State<ChecklistConfigBottomSheet> {
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
        if (configView == ConfigView.filter) ...[
          const ChecklistConfigFilterView(),
        ] else if (configView == ConfigView.sort)
          ...[]
        else if (configView == ConfigView.layout)
          ...[],
      ],
    ),
  );
}
