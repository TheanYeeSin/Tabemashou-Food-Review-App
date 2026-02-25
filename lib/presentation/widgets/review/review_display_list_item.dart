import "package:flutter/material.dart";
import "package:tabemashou/domain/review/review.dart";

class ReviewDisplayListItem extends StatelessWidget {
  final Review review;
  const ReviewDisplayListItem({super.key, required this.review});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // ----- Left Side -----
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: review.image != null
                    ? Image.memory(
                        review.image!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(
                        width: 60,
                        height: 60,
                        child: Icon(Icons.restaurant, size: 30),
                      ),
              ),
              const SizedBox(width: 16),

              // ----- Right Side -----
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.restaurantName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      review.restaurantDescription,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
