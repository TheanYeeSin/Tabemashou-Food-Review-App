import "package:sqflite/sqflite.dart";
import "package:tabemashou/core/constants/database.dart";
import "package:tabemashou/core/database/app_database.dart";
import "package:tabemashou/domain/review/review.dart";

class ReviewLocalSource {
  // ----- Read -----
  Future<List<Review>> getAll() async {
    final db = await AppDatabase().database;
    final result = await db.query(TABLE_REVIEW, orderBy: "id DESC");

    final List<Review> reviews = [];

    for (final reviewMap in result) {
      final reviewId = reviewMap["id"] as int;

      final categoryRows = await db.query(
        TABLE_REVIEW_CATEGORY,
        where: "reviewId = ?",
        whereArgs: [reviewId],
      );

      final categoryIds = categoryRows
          .map((final e) => e["categoryId"] as int)
          .toList();

      final visitRows = await db.query(
        TABLE_REVIEW_VISIT,
        where: "reviewId = ?",
        whereArgs: [reviewId],
      );

      final visitHistory = visitRows
          .map((final e) => Visit.fromMap(e))
          .toList();

      reviews.add(
        Review.fromMap(
          reviewMap,
        ).copyWith(categoryIds: categoryIds, visitHistory: visitHistory),
      );
    }

    return reviews;
  }

  // ----- Create -----
  Future<int> create(final Review review) async {
    final db = await AppDatabase().database;

    final itemWithTimestamp = review.copyWith(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return db.transaction((final txn) async {
      final id = await txn.insert(
        TABLE_REVIEW,
        itemWithTimestamp.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      if (review.categoryIds != null) {
        for (final categoryId in review.categoryIds!) {
          await txn.insert(TABLE_REVIEW_CATEGORY, {
            "reviewId": id,
            "categoryId": categoryId,
          });
        }
      }

      if (review.visitHistory != null) {
        for (final visit in review.visitHistory!) {
          await txn.insert(
            TABLE_REVIEW_VISIT,
            visit.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }

      return id;
    });
  }
}
