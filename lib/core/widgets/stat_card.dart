import "package:flutter/material.dart";

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  final String route;
  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
    required this.route,
  });

  @override
  Widget build(final BuildContext context) => Expanded(
    child: GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(icon, size: 28, color: Colors.orange),
              const SizedBox(height: 8),
              Text(
                "$count",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    ),
  );
}
