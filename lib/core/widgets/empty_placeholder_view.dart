import "package:flutter/material.dart";
import "package:tabemashou/core/constants/kaomoji.dart";

class EmptyPlaceholderView extends StatelessWidget {
  final String message;
  const EmptyPlaceholderView({super.key, required this.message});

  @override
  Widget build(final BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          KaomojiConstants.random,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        Text(message),
      ],
    ),
  );
}
