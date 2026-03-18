import "package:flutter/material.dart";
import "package:tabemashou/features/review/domain/review.dart";
import "package:tabemashou/features/review/presentation/widgets/review_form/review_form_chip_input.dart";

class ReviewFormVisitDialog extends StatefulWidget {
  const ReviewFormVisitDialog({super.key});

  @override
  State<ReviewFormVisitDialog> createState() => _ReviewFormVisitDialogState();
}

class _ReviewFormVisitDialogState extends State<ReviewFormVisitDialog> {
  final _notesCtrl = TextEditingController();
  List<String> _foodOrdered = [];

  @override
  Widget build(final BuildContext context) => AlertDialog(
    title: const Text("Add Visit", textAlign: TextAlign.center),
    content: SizedBox(
      width: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _notesCtrl,
              decoration: const InputDecoration(labelText: "Notes"),
            ),
            const SizedBox(height: 8),
            ReviewFormChipInput(
              label: "Food Ordered",
              values: _foodOrdered,
              onChanged: (final list) => setState(() => _foodOrdered = list),
            ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
      ElevatedButton(
        onPressed: () => Navigator.pop(
          context,
          Visit(
            date: DateTime.now(),
            notes: _notesCtrl.text,
            foodOrdered: _foodOrdered,
          ),
        ),
        child: const Text("Submit"),
      ),
    ],
  );
}
