import 'package:flutter/material.dart';

class TextBetweenDivider extends StatelessWidget {
  const TextBetweenDivider({
    required this.text,
    super.key});
  
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
              color: Color.fromARGB(255, 175, 176, 182),
              fontSize: 13,
            ),
          ),
        ),
        const Expanded(child: Divider(thickness: 1.0)),
      ],
    );
  }
}