import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/type/checklist.dart";
import "package:tabemashou/presentation/providers/checklist_item_provider.dart";

class ChecklistConfigFilterView extends StatelessWidget {
  const ChecklistConfigFilterView({super.key});

  // ----- Build -----
  @override
  Widget build(final BuildContext context) {
    final provider = Provider.of<ChecklistItemProvider>(context);
    final filterMode = provider.filterMode;
    return RadioGroup<ChecklistItemFilterMode>(
      groupValue: filterMode,
      onChanged: (final ChecklistItemFilterMode? value) {
        if (value == null) return;
        provider.setFilterMode(value);
      },
      child: const Column(
        children: [
          ListTile(
            title: Text("All"),
            leading: Radio<ChecklistItemFilterMode>(
              value: ChecklistItemFilterMode.all,
            ),
          ),
          ListTile(
            title: Text("Checked"),
            leading: Radio<ChecklistItemFilterMode>(
              value: ChecklistItemFilterMode.checked,
            ),
          ),
          ListTile(
            title: Text("Unchecked"),
            leading: Radio<ChecklistItemFilterMode>(
              value: ChecklistItemFilterMode.unchecked,
            ),
          ),
        ],
      ),
    );
  }
}
