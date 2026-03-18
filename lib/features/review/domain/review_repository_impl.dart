import "package:tabemashou/features/review/data/review_local_source.dart";
import "package:tabemashou/features/review/domain/review.dart";
import "package:tabemashou/features/review/domain/review_repository.dart";

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewLocalSource local;

  ReviewRepositoryImpl({required this.local});

  // ----- Read -----
  @override
  Future<List<Review>> getAll() async => local.getAll();

  // ----- Create -----
  @override
  Future<void> create(final Review review) => local.create(review);
}
