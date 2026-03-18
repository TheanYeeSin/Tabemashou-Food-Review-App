import "package:flutter/material.dart";
import "package:tabemashou/features/category/domain/category.dart";
import "package:tabemashou/presentation/screens/reviews/reviews_screen.dart";

class CategoryDisplayCardItem extends StatelessWidget {
  final Category category;
  const CategoryDisplayCardItem({super.key, required this.category});

  // ----- Build -----
  @override
  Widget build(final BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
        child: IntrinsicHeight(
          child: Row(
            children: [
              // ----- Left Side -----
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  image: category.image != null
                      ? DecorationImage(
                          image: MemoryImage(category.image!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: category.image == null
                    ? const Icon(Icons.fastfood, size: 32)
                    : null,
              ),

              // ----- Right Side -----
              Expanded(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    category.name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    category.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
