import "package:flutter/material.dart";
import "package:tabemashou/features/review/presentation/widgets/review_form/review_form.dart";

class ReviewFormScreen extends StatelessWidget {
  const ReviewFormScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Review Form")),
    body: ReviewForm(onSubmit: (review) => Navigator.pop(context, review)),
  );
}
