import "package:tabemashou/features/category/data/category_local_source.dart";
import "package:tabemashou/features/category/domain/category.dart";
import "package:tabemashou/features/category/domain/category_repository.dart";

/// CategoryRepositoryImpl: Implementation of CategoryRepository interface
class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalSource local;

  CategoryRepositoryImpl({required this.local});

  // ----- Read -----
  @override
  Future<List<Category>> getAll() => local.getAll();

  // ----- Create -----
  @override
  Future<void> create(final Category category) => local.create(category);

  // ----- Update -----
  @override
  Future<void> update(final Category category) => local.update(category);

  @override
  Future<void> batchUpdate(final List<Category> categories) =>
      local.batchUpdate(categories);

  // ----- Delete -----
  @override
  Future<void> delete(final int id) => local.delete(id);

  @override
  Future<void> batchDelete(final List<int> ids) => local.batchDelete(ids);
}
