import "package:tabemashou/features/review/domain/review.dart";

abstract class ReviewRepository {
  // ----- Read -----
  Future<List<Review>> getAll();

  // ----- Create -----
  Future<void> create(final Review review);
}
