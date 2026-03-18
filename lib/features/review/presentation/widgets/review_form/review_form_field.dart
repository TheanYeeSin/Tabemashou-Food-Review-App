import "package:flutter/material.dart";

class ReviewFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool? required;
  final int? maxLines;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;

  const ReviewFormField({
    super.key,
    required this.controller,
    required this.label,
    this.required = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(final BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
      ),
    ),
  );
}
