import "package:flutter/material.dart";

class ChecklistPreview extends StatelessWidget {
  static const checklist = ["Burger Town", "Sushi Zen", "Taco Fiesta"];
  const ChecklistPreview({super.key});

  @override
  Widget build(final BuildContext context) => Column(
    children: checklist
        .map(
          (final item) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              title: Text(item),
              leading: const Icon(Icons.location_on, color: Colors.redAccent),
              trailing: const Icon(Icons.chevron_right),
              // onTap: () => Navigator.pushNamed(context, '/checklist'),
            ),
          ),
        )
        .toList(),
  );
}
