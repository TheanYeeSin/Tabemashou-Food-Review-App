import "package:flutter/material.dart";

class ReviewFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Widget? action;
  const ReviewFormSection({
    super.key,
    required this.title,
    required this.children,
    this.action,
  });

  @override
  Widget build(final BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    clipBehavior: Clip.antiAlias,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    ),
  );
}
