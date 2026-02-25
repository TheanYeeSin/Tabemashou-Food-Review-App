import "package:tabemashou/data/review/review_local_source.dart";
import "package:tabemashou/domain/review/review.dart";
import "package:tabemashou/domain/review/review_repository.dart";

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
