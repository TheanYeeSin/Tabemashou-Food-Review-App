import "package:flutter/material.dart";

/// DeleteChecklistItemDialog: Dialog for deleting a checklist item
class DeleteChecklistItemDialog extends StatelessWidget {
  const DeleteChecklistItemDialog({super.key});

  // ----- Build -----
  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: const Text("Delete Checklist Item", textAlign: TextAlign.center),
    content: const Text("Are you sure you want to delete this checklist item?"),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text("Delete"),
      ),
    ],
  );
}
