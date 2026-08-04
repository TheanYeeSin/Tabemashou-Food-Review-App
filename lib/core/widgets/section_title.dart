import "package:flutter/material.dart";

class SectionTitle extends StatelessWidget {
  final String title;
  final String path;
  const SectionTitle({super.key, required this.title, required this.path});

  @override
  Widget build(final BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      TextButton(
        onPressed: () => Navigator.pushNamed(context, path),
        child: const Text("View All"),
      ),
    ],
  );
}
