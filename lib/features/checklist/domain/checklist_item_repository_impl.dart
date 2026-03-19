import "package:tabemashou/features/checklist/data/checklist_item_local_source.dart";
import "package:tabemashou/features/checklist/domain/checklist_item.dart";
import "package:tabemashou/features/checklist/domain/checklist_item_repository.dart";

class ChecklistItemRepositoryImpl implements ChecklistItemRepository {
  final ChecklistItemLocalSource local;

  ChecklistItemRepositoryImpl({required this.local});

  // ----- Read -----
  @override
  Future<List<ChecklistItem>> getAll() async => local.getAll();

  // ----- Create -----
  @override
  Future<void> create(final ChecklistItem item) => local.create(item);

  // ----- Update -----
  @override
  Future<void> update(final ChecklistItem item) => local.update(item);

  // ----- Delete -----
  @override
  Future<void> delete(final int id) => local.delete(id);
}
