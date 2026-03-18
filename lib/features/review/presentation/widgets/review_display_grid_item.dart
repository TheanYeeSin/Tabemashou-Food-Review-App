import "package:flutter/material.dart";
import "package:tabemashou/features/review/domain/review.dart";

class ReviewDisplayGridItem extends StatelessWidget {
  final Review review;
  const ReviewDisplayGridItem({super.key, required this.review});

  // ----- Build -----
  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,

      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Top Side -----
            AspectRatio(
              aspectRatio: 16 / 9,
              child: review.image != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.memory(review.image!, fit: BoxFit.cover),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: const Center(child: Icon(Icons.image, size: 40)),
                    ),
            ),

            // ----- Bottom Side -----
            ListTile(
              title: Text(
                review.restaurantName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
