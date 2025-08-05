import "package:flutter/material.dart";
import "package:tabemashou/domain/category/category.dart";
import "package:tabemashou/domain/category/category_repository.dart";

class CategoryProvider extends ChangeNotifier {
  final CategoryRepository repository;

  CategoryProvider({required this.repository});

  // ----- State and Getters -----
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // ----- Load / Refresh -----
  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await repository.getAll();
    _isLoading = false;
    notifyListeners();
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
