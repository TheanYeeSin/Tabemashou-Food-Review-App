import "package:flutter/material.dart";
import "package:tabemashou/core/constants/path.dart";
import "package:tabemashou/domain/category/category.dart";
import "package:tabemashou/presentation/widgets/common/empty_placeholder_view.dart";

class CategoryCarousel extends StatelessWidget {
  final List<Category> categories;
  const CategoryCarousel({super.key, required this.categories});

  @override
  Widget build(final BuildContext context) => SizedBox(
    height: 120,
    child: categories.isEmpty
        ? const EmptyPlaceholderView(message: "No categories")
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (final context, final index) {
              final cat = categories[index];
              return Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, MAIN_REVIEW_PATH),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: cat.image != null
                          ? [
                              SizedBox(
                                child: Image.memory(
                                  cat.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Colors.black45,
                                alignment: Alignment.center,
                                child: Text(
                                  cat.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ]
                          : [
                              const Icon(Icons.fastfood, size: 32),
                              Container(
                                color: Colors.black45,
                                alignment: Alignment.center,
                                child: Text(
                                  cat.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                    ),
                  ),
                ),
              );
            },
          ),
  );
}
