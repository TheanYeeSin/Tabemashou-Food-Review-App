import "package:flutter/material.dart";

class ReviewFormChipInput extends StatefulWidget {
  final String label;
  final List<String> values;
  final void Function(List<String>) onChanged;

  const ReviewFormChipInput({
    super.key,
    required this.label,
    required this.values,
    required this.onChanged,
  });

  @override
  State<ReviewFormChipInput> createState() => _ReviewFormChipInputState();
}

class _ReviewFormChipInputState extends State<ReviewFormChipInput> {
  final _ctrl = TextEditingController();

  void _addChip() {
    final text = _ctrl.text.trim();
    if (text.isNotEmpty && !widget.values.contains(text)) {
      widget.onChanged([...widget.values, text]);
      _ctrl.clear();
    }
  }

  void _removeChip(final String v) {
    widget.onChanged(widget.values.where((final e) => e != v).toList());
  }

  @override
  Widget build(final BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Wrap(
        spacing: 8,
        runSpacing: -8,
        children: widget.values
            .map(
              (final v) => Chip(
                label: Text(v),
                onDeleted: () => _removeChip(v),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
            .toList(),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: TextField(
              controller: _ctrl,
              decoration: InputDecoration(
                hintText: "Add ${widget.label}",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(onPressed: _addChip, icon: const Icon(Icons.add)),
        ],
      ),
    ],
  );
}
