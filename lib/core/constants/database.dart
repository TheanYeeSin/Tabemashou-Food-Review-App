// ignore_for_file: constant_identifier_names

// ----- Database Config -----
const DATABASE_NAME = "Tabemashou.db";
const DATABASE_VERSION = 1;
const CONFIG_SQL = """
    PRAGMA foreign_keys = ON
    """;

// ----- Reviews -----
const TABLE_REVIEW = "reviews";
const TABLE_REVIEW_CREATE_SQL =
    """
    CREATE TABLE $TABLE_REVIEW (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      restaurantName TEXT NOT NULL,
      restaurantLocation TEXT NOT NULL,
      restaurantDescription TEXT,
      foodAvailable TEXT,
      rating DOUBLE NOT NULL,
      additionalReview TEXT,
      isFavourite INTEGER NOT NULL,
      isBlacklisted INTEGER NOT NULL,
      image BLOB,
      openingHours TEXT,
      createdAt TEXT NOT NULL,
      updatedAt TEXT NOT NULL)
    """;

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
      isChecked INTEGER NOT NULL,
      createdAt TEXT NOT NULL,
      updatedAt TEXT NOT NULL)
    """;

// ----- Review + Visit -----
const TABLE_REVIEW_VISIT = "reviewVisits";
const TABLE_REVIEW_VISIT_CREATE_SQL =
    """
    CREATE TABLE $TABLE_REVIEW_VISIT (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      reviewId INTEGER NOT NULL,
      date TEXT NOT NULL,
      foodOrdered TEXT,
      notes TEXT,
      FOREIGN KEY (reviewId) REFERENCES $TABLE_REVIEW(id) ON DELETE CASCADE)
    """;

// ----- Review + Category -----
const TABLE_REVIEW_CATEGORY = "reviewCategories";
const TABLE_REVIEW_CATEGORY_CREATE_SQL =
    """
    CREATE TABLE $TABLE_REVIEW_CATEGORY (
      reviewId INTEGER NOT NULL,
      categoryId INTEGER NOT NULL,
      PRIMARY KEY (reviewId, categoryId),
      FOREIGN KEY (reviewId) REFERENCES $TABLE_REVIEW(id) ON DELETE CASCADE,
      FOREIGN KEY (categoryId) REFERENCES $TABLE_CATEGORY(id) ON DELETE CASCADE)
    """;
