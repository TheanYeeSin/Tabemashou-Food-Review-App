import "package:flutter/material.dart";
import "package:tabemashou/features/category/domain/category.dart";
import "package:tabemashou/features/review/presentation/screens/reviews_screen.dart";

class CategoryDisplayListItem extends StatelessWidget {
  final Category category;
  const CategoryDisplayListItem({super.key, required this.category});

  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (final context) => ReviewsScreen(title: category.name),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              // ----- Left Side -----
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: category.image != null
                    ? Image.memory(
                        category.image!,
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
                      category.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.description,
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
