import "package:flutter/material.dart";
import "package:tabemashou/features/checklist/domain/checklist_item.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";

class ChecklistPreview extends StatelessWidget {
  final List<ChecklistItem> checklistItems;
  const ChecklistPreview({super.key, required this.checklistItems});

  @override
  Widget build(final BuildContext context) => SizedBox(
    child: checklistItems.isEmpty
        ? const EmptyPlaceholderView(message: "No checklist items")
        : Column(
            children: checklistItems
                .map(
                  (final item) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      key: ValueKey(item.id),
                      title: Text(item.name),
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      // onTap: () => Navigator.pushNamed(context, '/checklist'),
                    ),
                  ),
                )
                .toList(),
          ),
  );
}
