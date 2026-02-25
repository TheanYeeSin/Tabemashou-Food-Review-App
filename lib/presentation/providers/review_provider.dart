import "package:flutter/material.dart";
import "package:tabemashou/core/type/review.dart";
import "package:tabemashou/domain/review/review.dart";
import "package:tabemashou/domain/review/review_repository.dart";

class ReviewProvider extends ChangeNotifier {
  final ReviewRepository repository;

  ReviewProvider({required this.repository});

  // ----- State and Getters -----
  List<Review> _review = [];

  bool _isLoading = false;

  // layout
  ReviewLayoutMode _layoutMode = ReviewLayoutMode.list;

  // ----- Getters -----
  List<Review> get review => List.unmodifiable(_review);
  bool get isLoading => _isLoading;
  ReviewLayoutMode get layoutMode => _layoutMode;

  // ----- Setters -----
  void setLayoutMode(final ReviewLayoutMode mode) {
    if (_layoutMode != mode) {
      _layoutMode = mode;
      notifyListeners();
    }
  }

  // ----- Load / Refresh -----
  Future<void> loadReviews() async {
    _isLoading = true;
    notifyListeners();

    _review = await repository.getAll();
    _isLoading = false;
    notifyListeners();
  }

  List<Review> loadSortedReviews() {
    final sorted = List.of(_review);

    return sorted;
  }

  // ----- Create -----
  Future<void> create(final Review item) async {
    await repository.create(item);
    await loadReviews();
  }
}
