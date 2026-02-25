import "package:tabemashou/domain/review/review.dart";

abstract class ReviewRepository {
  // ----- Read -----
  Future<List<Review>> getAll();

  // ----- Create -----
  Future<void> create(final Review review);
}
