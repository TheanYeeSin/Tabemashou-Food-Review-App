import "package:sqflite/sqflite.dart";
import "package:tabemashou/core/constants/database.dart";
import "package:tabemashou/core/database/app_database.dart";
import "package:tabemashou/features/checklist/domain/checklist_item.dart";

class ChecklistItemLocalSource {
  // ----- Read -----
  Future<List<ChecklistItem>> getAll() async {
    final db = await AppDatabase().database;
    final result = await db.query(TABLE_CHECKLIST_ITEM, orderBy: "id ASC");

    return result.map(ChecklistItem.fromMap).toList();
  }

  // ----- Create -----
  Future<void> create(final ChecklistItem item) async {
    final db = await AppDatabase().database;
    final itemWithTimestamp = item.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await db.insert(
      TABLE_CHECKLIST_ITEM,
      itemWithTimestamp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ----- Update -----
  Future<void> update(final ChecklistItem item) async {
    final db = await AppDatabase().database;
    final itemWithTimestamp = item.copyWith(updatedAt: DateTime.now());
    await db.update(
      TABLE_CHECKLIST_ITEM,
      itemWithTimestamp.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ----- Delete -----
  Future<void> delete(final int id) async {
    final db = await AppDatabase().database;
    await db.delete(TABLE_CHECKLIST_ITEM, where: "id = ?", whereArgs: [id]);
  }
}
