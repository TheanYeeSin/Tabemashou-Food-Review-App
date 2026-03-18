import "package:flutter/material.dart";
import "package:tabemashou/features/review/domain/review.dart";

class ReviewDisplayCardItem extends StatelessWidget {
  final Review review;
  const ReviewDisplayCardItem({super.key, required this.review});

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
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  Center(
                    child: review.image != null
                        ? Image.memory(review.image!, fit: BoxFit.cover)
                        : const Icon(Icons.restaurant, size: 30),
                  ),
                  Positioned(
                    right: 16,
                    top: 16,
                    child: review.isFavourite
                        ? IconButton(
                            icon: const Icon(Icons.star),
                            onPressed: () {},
                          )
                        : IconButton(
                            icon: const Icon(Icons.star_border),
                            onPressed: () {},
                          ),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          review.restaurantName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(review.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    review.restaurantDescription,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    maxLines: 3,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(onPressed: () {}, child: Text("View")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
