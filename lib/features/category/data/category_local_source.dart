import "package:sqflite/sqflite.dart";
import "package:tabemashou/core/constants/database.dart";
import "package:tabemashou/core/database/app_database.dart";
import "package:tabemashou/features/category/domain/category.dart";

/// CategoryLocalSource: Handles local database operations
class CategoryLocalSource {
  // ----- Read -----
  Future<List<Category>> getAll() async {
    final db = await AppDatabase().database;
    final result = await db.query(TABLE_CATEGORY, orderBy: "orderIndex ASC");

    return result.map(Category.fromMap).toList();
  }

  // ----- Create -----
  Future<void> create(final Category category) async {
    final db = await AppDatabase().database;
    final categoryWithTimestamp = category.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await db.insert(
      TABLE_CATEGORY,
      categoryWithTimestamp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ----- Update -----
  Future<void> update(final Category category) async {
    final db = await AppDatabase().database;
    final categoryWithTimestamp = category.copyWith(updatedAt: DateTime.now());
    await db.update(
      TABLE_CATEGORY,
      categoryWithTimestamp.toMap(),
      where: "id = ?",
      whereArgs: [category.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> batchUpdate(final List<Category> categories) async {
    final db = await AppDatabase().database;
    await db.transaction((final txn) async {
      for (final category in categories) {
        await txn.update(
          TABLE_CATEGORY,
          category.copyWith(updatedAt: DateTime.now()).toMap(),
          where: "id = ?",
          whereArgs: [category.id],
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  // ----- Delete -----
  Future<void> delete(final int id) async {
    final db = await AppDatabase().database;
    await db.delete(TABLE_CATEGORY, where: "id = ?", whereArgs: [id]);
  }

  Future<void> batchDelete(final List<int> ids) async {
    final db = await AppDatabase().database;
    await db.transaction((final txn) async {
      for (final id in ids) {
        await txn.delete(TABLE_CATEGORY, where: "id = ?", whereArgs: [id]);
      }
    });
  }
}
