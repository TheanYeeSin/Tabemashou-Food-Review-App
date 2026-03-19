import "package:tabemashou/features/checklist/domain/checklist_item.dart";

abstract class ChecklistItemRepository {
  // ----- Read -----
  Future<List<ChecklistItem>> getAll();

  // ----- Create -----
  Future<void> create(final ChecklistItem item);

  // ----- Update -----
  Future<void> update(final ChecklistItem item);

  // ----- Delete -----
  Future<void> delete(final int id);
}
