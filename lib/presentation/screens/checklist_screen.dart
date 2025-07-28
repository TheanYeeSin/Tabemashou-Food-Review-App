import "package:flutter/material.dart";

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Checklist"), centerTitle: true),
  );
}
