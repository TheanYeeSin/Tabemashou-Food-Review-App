import "package:flutter/material.dart";
import "package:tabemashou/domain/checklist_item/checklist_item.dart";
import "package:tabemashou/domain/checklist_item/checklist_item_repository.dart";

class ChecklistItemProvider extends ChangeNotifier {
  final ChecklistItemRepository repository;

  ChecklistItemProvider({required this.repository});

  // ----- State -----
  List<ChecklistItem> _checklistItems = [];
  bool _loading = false;

  // ----- Getters -----
  List<ChecklistItem> get checklistItems => List.unmodifiable(_checklistItems);
  bool get loading => _loading;

  // ----- Read -----
  Future<void> loadChecklistItems() async {
    _loading = true;
    notifyListeners();

    _checklistItems = await repository.getAll();

    _loading = false;
    notifyListeners();
  }

  // ----- Create -----
  Future<void> create(final ChecklistItem item) async {
    await repository.create(item);
    await loadChecklistItems();
  }

  // ----- Update
  Future<void> update(final ChecklistItem item) async {
    await repository.update(item);
    await loadChecklistItems();
  }

  // ----- Delete -----
  Future<void> delete(final int id) async {
    await repository.delete(id);
    await loadChecklistItems();
  }
}
