import "package:flutter/material.dart";
import "package:tabemashou/domain/review/review.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";
import "package:tabemashou/presentation/widgets/review/review_config_bottom_sheet/review_config_bottom_sheet.dart";

class ReviewsScreen extends StatefulWidget {
  final String title;
  const ReviewsScreen({super.key, required this.title});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final List<Review> reviews = sampleReviews;

  @override
  Widget build(final BuildContext context) => Scaffold(
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
        : ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: reviews.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final review = reviews[index];
              return ReviewListItem(
                review: review,
                onTap: () {
                  // TODO: Navigate to detail screen
                },
              );
            },
          ),
  );
}

class ReviewListItem extends StatelessWidget {
  final Review review;
  final VoidCallback? onTap;

  const ReviewListItem({super.key, required this.review, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.memory(
                review.image!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),

            // Info section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and favourite icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            review.restaurantName,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (review.isFavourite)
                          const Icon(Icons.favorite, color: Colors.redAccent),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      review.restaurantLocation,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          review.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
