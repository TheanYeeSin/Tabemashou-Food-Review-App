import "package:flutter/material.dart";
import "package:tabemashou/features/category/domain/category.dart";
import "package:tabemashou/features/review/presentation/screens/reviews_screen.dart";

class CategoryDisplayGridItem extends StatelessWidget {
  final Category category;
  const CategoryDisplayGridItem({super.key, required this.category});

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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (final context) => ReviewsScreen(title: category.name),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Top Side -----
            AspectRatio(
              aspectRatio: 16 / 9,
              child: category.image != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.memory(category.image!, fit: BoxFit.cover),
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
                category.name,
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
