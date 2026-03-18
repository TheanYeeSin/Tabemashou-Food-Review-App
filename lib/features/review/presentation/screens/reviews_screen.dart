import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:tabemashou/core/type/review.dart";
import "package:tabemashou/features/review/presentation/providers/review_provider.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";
import "package:tabemashou/features/review/presentation/widgets/review_config_bottom_sheet/review_config_bottom_sheet.dart";
import "package:tabemashou/features/review/presentation/widgets/review_display_card_item.dart";
import "package:tabemashou/features/review/presentation/widgets/review_display_grid_item.dart";
import "package:tabemashou/features/review/presentation/widgets/review_display_list_item.dart";

class ReviewsScreen extends StatefulWidget {
  final String title;
  const ReviewsScreen({super.key, required this.title});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(final BuildContext context) => Consumer<ReviewProvider>(
    builder: (final context, final provider, final child) {
      final reviews = provider.loadSortedReviews();
      final layout = provider.layoutMode;
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (final BuildContext context) =>
                    const ReviewConfigBottomSheet(),
              ),
              icon: const Icon(Icons.tune_outlined),
            ),
          ],
        ),
        body: reviews.isEmpty
            ? const EmptyPlaceholderView(
                message: "No review found, add one in the settings",
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: switch (layout) {
                  ReviewLayoutMode.list => ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (final context, final index) =>
                        ReviewDisplayListItem(review: reviews[index]),
                  ),
                  ReviewLayoutMode.card => ListView.builder(
                    itemCount: reviews.length,
                    itemBuilder: (final context, final index) =>
                        ReviewDisplayCardItem(review: reviews[index]),
                  ),
                  ReviewLayoutMode.grid => GridView.builder(
                    itemCount: reviews.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                    itemBuilder: (final context, final index) =>
                        ReviewDisplayGridItem(review: reviews[index]),
                  ),
                },
              ),
      );
    },
  );
}
