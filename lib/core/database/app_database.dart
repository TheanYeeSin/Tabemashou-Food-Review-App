import "package:sqflite/sqflite.dart";
import "package:tabemashou/core/constants/database.dart";

/// AppDatabase: Handle database initialization
class AppDatabase {
  // ----- Singleton setup -----
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  AppDatabase._internal();

  // ----- Database instance -----
  Database? _db;
  Future<Database> get database async => _db ??= await _initDatabase();

  // ----- Initialization -----
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = "$dbPath/$DATABASE_NAME";
    final db = await openDatabase(
      path,
      version: DATABASE_VERSION,
      onCreate: _createDb,
      onConfigure: _onConfigure,
    );

    return db;
  }

  // ----- Database Creation -----
  Future<void> _createDb(final Database db, final int version) async {
    await db.execute(TABLE_REVIEW_CREATE_SQL);
    await db.execute(TABLE_CATEGORY_CREATE_SQL);
    await db.execute(TABLE_CHECKLIST_ITEM_CREATE_SQL);
    await db.execute(TABLE_REVIEW_CATEGORY_CREATE_SQL);
    await db.execute(TABLE_REVIEW_VISIT_CREATE_SQL);
  }

  // ----- Database Config -----
  Future<void> _onConfigure(final Database db) async {
    await db.execute(CONFIG_SQL);
  }
}
