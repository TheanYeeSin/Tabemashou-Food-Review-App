// ignore_for_file: constant_identifier_names

// ----- Database Config -----
const DATABASE_NAME = "Tabemashou.db";
const DATABASE_VERSION = 1;

// ----- Reviews -----
const TABLE_REVIEW = "reviews";

// ----- Categories -----
const TABLE_CATEGORY = "categories";
const TABLE_CATEGORY_CREATE_SQL =
    """
    CREATE TABLE $TABLE_CATEGORY (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      image BLOB,
      orderIndex INTEGER NOT NULL,
      createdAt TEXT NOT NULL,
      updatedAt TEXT NOT NULL)
    """;

// ----- Checklist Items -----
const TABLE_CHECKLIST_ITEM = "checklistItems";
const TABLE_CHECKLIST_ITEM_CREATE_SQL =
    """
    CREATE TABLE $TABLE_CHECKLIST_ITEM (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      isChecked INTEGER NOT NULL)
    """;
