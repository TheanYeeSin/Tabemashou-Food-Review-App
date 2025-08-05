import "package:flutter/material.dart";
import "package:tabemashou/core/utils/log/logger.dart";
import "package:tabemashou/domain/category/category.dart";

/// CategorySettingListTile: Widget for displaying a category in a list
class CategorySettingListTile extends StatelessWidget {
  final Category category;
  final int index;
  final Future<void> Function(Category) onEdit;
  final Future<void> Function(Category) onDelete;
  const CategorySettingListTile({
    super.key,
    required this.category,
    required this.index,
    required this.onEdit,
    required this.onDelete,
  });

  // ---- Build ----
  @override
  Widget build(final BuildContext context) => Card(
    elevation: 5,
    child: InkWell(
      onDoubleTap: () => onEdit(category),
      onLongPress: () => onDelete(category),
      child: Ink(
        child: ListTile(
          title: Text(
            category.name,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
          ),
          subtitle: Text(
            category.description,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
          ),
          leading: ReorderableDragStartListener(
            index: index,
            child: const Icon(Icons.drag_handle_outlined),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                tooltip: "Edit",
                onPressed: () => onEdit(category),
              ),
              IconButton(
                color: Colors.red,
                icon: const Icon(Icons.delete_outline),
                tooltip: "Delete",
                onPressed: () => onDelete(category),
              ),
            ],
          ),
          onTap: () => {LoggerService.logDebug("TAP")},
        ),
      ),
    ),
  );
}
