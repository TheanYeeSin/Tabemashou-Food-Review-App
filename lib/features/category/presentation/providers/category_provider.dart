import "package:flutter/material.dart";
import "package:tabemashou/core/type/category.dart";
import "package:tabemashou/core/utils/sort/sort_utils.dart";
import "package:tabemashou/features/category/domain/category.dart";
import "package:tabemashou/features/category/domain/category_repository.dart";

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository repository;

  CategoryProvider({required this.repository});

  // ----- State and Getters -----
  List<Category> _categories = [];

  bool _isLoading = false;

  // sort
  CategorySortMode _sortMode = CategorySortMode.order;
  CategorySortOrder _sortOrder = CategorySortOrder.asc;

  // layout
  CategoryLayoutMode _layoutMode = CategoryLayoutMode.list;

  // ----- Getters -----
  List<Category> get categories => List.unmodifiable(_categories);
  bool get isLoading => _isLoading;
  CategorySortMode get sortMode => _sortMode;
  CategorySortOrder get sortOrder => _sortOrder;
  CategoryLayoutMode get layoutMode => _layoutMode;

  // ----- Setters -----
  void setSortMode(final CategorySortMode mode) {
    if (_sortMode != mode) {
      _sortMode = mode;
      notifyListeners();
    }
  }

  void setSortOrder(final CategorySortOrder order) {
    if (_sortOrder != order) {
      _sortOrder = order;
      notifyListeners();
    }
  }

  void setLayoutMode(final CategoryLayoutMode mode) {
    if (_layoutMode != mode) {
      _layoutMode = mode;
      notifyListeners();
    }
  }

  // ----- Load / Refresh -----
  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await repository.getAll();
    _isLoading = false;
    notifyListeners();
  }

  List<Category> loadSortedCategories() {
    final sorted = List.of(_categories);

    switch (_sortMode) {
      case CategorySortMode.name:
        SortUtils.sortByField(
          sorted,
          (final c) => c.name,
          ascending: _sortOrder == CategorySortOrder.asc,
        );

      case CategorySortMode.order:
        SortUtils.sortByField(
          sorted,
          (final c) => c.order,
          ascending: _sortOrder == CategorySortOrder.asc,
        );
    }

    return sorted;
  }

  // ----- Create -----
  Future<void> create(final Category category) async {
    await repository.create(category);
    await loadCategories();
  }

  // ----- Update -----
  Future<void> update(final Category category) async {
    await repository.update(category);
    await loadCategories();
  }

  Future<void> batchUpdate(final List<Category> categories) async {
    await repository.batchUpdate(categories);
    await loadCategories();
  }

  // ----- Delete -----
  Future<void> delete(final int id) async {
    await repository.delete(id);
    await loadCategories();
  }

  Future<void> batchDelete(final List<int> ids) async {
    await repository.batchDelete(ids);
    await loadCategories();
  }

  // ----- Other Methods -----
  Future<void> reorder(final List<Category> categories) async {
    _categories = categories;
    notifyListeners();

    await repository.batchUpdate(categories);
  }
}
