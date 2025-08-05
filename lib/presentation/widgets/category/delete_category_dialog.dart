// work on this next
import "package:flutter/material.dart";

/// DeleteCategoryDialog: Dialog for deleting a category
class DeleteCategoryDialog extends StatelessWidget {
  const DeleteCategoryDialog({super.key});

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: const Text("Delete Category", textAlign: TextAlign.center),
    content: const Text("Are you sure you want to delete this category?"),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
      TextButton(
        onPressed: () => {Navigator.pop(context, true)},
        child: const Text("Delete"),
      ),
    ],
  );
}
