import "package:flutter/material.dart";

class RecentReviewsList extends StatelessWidget {
  const RecentReviewsList({super.key});

  static const reviews = [
    {
      "restaurant": "Ramen King",
      "rating": "★★★★☆",
      "snippet": "Loved the broth!",
    },
    {
      "restaurant": "Sushi Zen",
      "rating": "★★★★★",
      "snippet": "Fresh and tasty.",
    },
  ];
  @override
  Widget build(final BuildContext context) => Column(
    children: reviews
        .map(
          (final r) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(r["restaurant"]!),
              subtitle: Text('${r["rating"]} - ${r["snippet"]}'),
              trailing: const Icon(Icons.chevron_right),
              // onTap: () => Navigator.pushNamed(context, '/reviews'),
            ),
          ),
        )
        .toList(),
  );
}
