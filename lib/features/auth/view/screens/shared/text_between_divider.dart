import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';

class TextBetweenDivider extends StatelessWidget {
  const TextBetweenDivider({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1.0)),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.hintColor,
              fontSize: 13,
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1.0)),
      ],
    );
  }
}
