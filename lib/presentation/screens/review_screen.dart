import "package:flutter/material.dart";

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(final BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text("Reviews"), centerTitle: true));
}
