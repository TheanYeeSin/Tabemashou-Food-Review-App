import "package:flutter/material.dart";

class ReviewFormSwitch extends StatefulWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? secondary;

  const ReviewFormSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.secondary,
  });

  @override
  State<ReviewFormSwitch> createState() => _ReviewFormSwitchState();
}

class _ReviewFormSwitchState extends State<ReviewFormSwitch> {
  @override
  Widget build(final BuildContext context) => SwitchListTile(
    title: Text(widget.title),
    value: widget.value,
    onChanged: widget.onChanged,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    secondary: widget.secondary,
  );
}
