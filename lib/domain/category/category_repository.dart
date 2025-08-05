import "package:tabemashou/domain/category/category.dart";

/// CategoryRepository: Abstract class for Category repository
abstract class CategoryRepository {
  // ----- Read -----
  Future<List<Category>> getAll();

  // ----- Create -----
  Future<void> create(final Category category);

  // ----- Update -----
  Future<void> update(final Category category);
  Future<void> batchUpdate(final List<Category> categories);

  // ----- Delete -----
  Future<void> delete(final int id);
  Future<void> batchDelete(final List<int> ids);
}
