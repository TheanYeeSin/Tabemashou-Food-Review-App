import "package:flutter/material.dart";
import "package:tabemashou/core/type/checklist.dart";
import "package:tabemashou/domain/checklist_item/checklist_item.dart";
import "package:tabemashou/domain/checklist_item/checklist_item_repository.dart";

class ChecklistItemProvider extends ChangeNotifier {
  final ChecklistItemRepository repository;

  ChecklistItemProvider({required this.repository});

  // ----- State -----
  List<ChecklistItem> _checklistItems = [];
  bool _loading = false;
  ChecklistItemFilterMode _filterMode = ChecklistItemFilterMode.unchecked;

  // ----- Getters -----
  List<ChecklistItem> get checklistItems => List.unmodifiable(_checklistItems);
  bool get loading => _loading;
  ChecklistItemFilterMode get filterMode => _filterMode;

  // ----- Setters -----
  void setFilterMode(final ChecklistItemFilterMode mode) {
    if (_filterMode != mode) {
      _filterMode = mode;
      notifyListeners();
    }
  }

  // ----- Read -----
  Future<void> loadChecklistItems() async {
    _loading = true;
    notifyListeners();

    _checklistItems = await repository.getAll();

    _loading = false;
    notifyListeners();
  }

  List<ChecklistItem> loadFilteredChecklistItems({
    final ChecklistItemFilterMode? filterMode,
  }) {
    final mode = filterMode ?? _filterMode;
    final filtered = List.of(_checklistItems);

    switch (mode) {
      case ChecklistItemFilterMode.all:
        break;
      case ChecklistItemFilterMode.checked:
        filtered.removeWhere((final item) => !item.isChecked);
      case ChecklistItemFilterMode.unchecked:
        filtered.removeWhere((final item) => item.isChecked);
    }

    return filtered;
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
