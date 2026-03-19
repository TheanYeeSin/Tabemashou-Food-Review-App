import "package:flutter/material.dart";
import "package:tabemashou/core/validators/text_validators.dart";
import "package:tabemashou/features/checklist/domain/checklist_item.dart";

/// ChecklistDialog: Dialog for adding/editing a checklist item
class ChecklistDialog extends StatefulWidget {
  final ChecklistItem? initialChecklistItem;
  final bool? isEdit;
  const ChecklistDialog({
    super.key,
    this.initialChecklistItem,
    this.isEdit = false,
  });

  @override
  State<ChecklistDialog> createState() => _ChecklistDialogState();
}

class _ChecklistDialogState extends State<ChecklistDialog> {
  // ----- Properties -----
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  // ----- Lifecycle -----
  @override
  void initState() {
    super.initState();

    final checklistItem = widget.initialChecklistItem;
    if (checklistItem != null) {
      _nameController.text = checklistItem.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // ----- Submit -----
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, {"name": _nameController.text});
    }
  }

  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: Text(
      widget.isEdit! ? "Edit Checklist Item" : "Add Checklist Item",
      textAlign: TextAlign.center,
    ),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () => Navigator.pop(context),
      ),
      TextButton(onPressed: _submit, child: const Text("Submit")),
    ],
    content: SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  hintText: "Enter checklist item name",
                ),
                validator: (final value) =>
                    TextValidators.required(value, fieldName: "Name"),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
