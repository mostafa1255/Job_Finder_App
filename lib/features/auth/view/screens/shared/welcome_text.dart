import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText(
      {required this.title,
      required this.headline,
      required this.text,
      this.crossAxisAlignment,
      this.innerPadding,
      super.key});

  final String? crossAxisAlignment;
  final String title;
  final String headline;
  final String text;
  final double? innerPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          (crossAxisAlignment == null || crossAxisAlignment == "start")
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: (innerPadding == null) ? 5 : innerPadding),
        Text(
          headline,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: (innerPadding == null) ? 3 : innerPadding),
        Text(text,
            textAlign:
                (crossAxisAlignment == null || crossAxisAlignment == "start")
                    ? TextAlign.start
                    : TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
