import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/utils/log/logger.dart";
import "package:tabemashou/domain/checklist_item/checklist_item.dart";
import "package:tabemashou/presentation/providers/checklist_item_provider.dart";
import "package:tabemashou/presentation/widgets/checklist/checklist_dialog.dart";
import "package:tabemashou/presentation/widgets/checklist/checklist_display_list_item.dart";
import "package:tabemashou/presentation/widgets/checklist/delete_checklist_item_dialog.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";

class HomeChecklistScreen extends StatefulWidget {
  const HomeChecklistScreen({super.key});

  @override
  State<HomeChecklistScreen> createState() => _HomeChecklistScreenState();
}

class _HomeChecklistScreenState extends State<HomeChecklistScreen> {
  // ----- Add Checklist Item -----
  Future<void> _addChecklistItem() async {
    final result = await showDialog(
      context: context,
      builder: (final context) => const ChecklistDialog(),
    );

    if (!mounted || result == null) return;

    final provider = Provider.of<ChecklistItemProvider>(context, listen: false);
    final newChecklistItem = ChecklistItem(name: result["name"]);

    await provider.create(newChecklistItem);
    LoggerService.logDebug("Added new checklist item: $newChecklistItem");
  }

  // ----- Edit Checklist Item -----
  Future<void> _editChecklistItem(final ChecklistItem checklistItem) async {
    final result = await showDialog(
      context: context,
      builder: (final context) =>
          ChecklistDialog(initialChecklistItem: checklistItem, isEdit: true),
    );

    if (!mounted || result == null) return;

    final provider = Provider.of<ChecklistItemProvider>(context, listen: false);
    final newChecklistItem = ChecklistItem(
      id: checklistItem.id,
      name: result["name"],
      isChecked: checklistItem.isChecked,
    );

    await provider.update(newChecklistItem);
    LoggerService.logDebug("Updated new checklist item: $newChecklistItem");
  }

  // ----- Check Checklist Item -----
  Future<void> _checkItem(final ChecklistItem checklistItem) async {
    if (!mounted) return;
    final provider = Provider.of<ChecklistItemProvider>(context, listen: false);

    final newChecklistItem = ChecklistItem(
      id: checklistItem.id,
      name: checklistItem.name,
      isChecked: !checklistItem.isChecked,
    );

    await provider.update(newChecklistItem);
    LoggerService.logDebug(
      "Toggled check for checklist item: $newChecklistItem",
    );
  }

  // ----- Delete Checklist Item -----
  Future<void> _deleteChecklistItem(final ChecklistItem checklistItem) async {
    final result = await showDialog(
      context: context,
      builder: (final context) => const DeleteChecklistItemDialog(),
    );

    if (!mounted || result != true) return;

    final provider = Provider.of<ChecklistItemProvider>(context, listen: false);
    await provider.delete(checklistItem.id!);
    LoggerService.logDebug("Deleted checklist item: $checklistItem");
  }

  @override
  Widget build(final BuildContext context) => Consumer<ChecklistItemProvider>(
    builder: (final context, final provider, final child) {
      final checklistItems = provider.checklistItems;

      return Scaffold(
        appBar: AppBar(title: const Text("Checklist"), centerTitle: true),
        floatingActionButton: FloatingActionButton(
          onPressed: _addChecklistItem,
          child: const Icon(Icons.add_outlined),
        ),
        body: checklistItems.isEmpty
            ? const EmptyPlaceholderView(
                message: "No checklist item found. Add one now!",
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: checklistItems.length,
                  itemBuilder: (final context, final index) =>
                      ChecklistDisplayListItem(
                        onCheck: _checkItem,
                        onLongPress: _editChecklistItem,
                        onDelete: _deleteChecklistItem,
                        checklistItem: checklistItems[index],
                      ),
                ),
              ),
      );
    },
  );
}
