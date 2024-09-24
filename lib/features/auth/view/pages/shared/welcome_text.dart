import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    required this.title,
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
      crossAxisAlignment: (crossAxisAlignment == null || crossAxisAlignment == "start") ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          title, 
          style: const TextStyle(
            color: Color.fromARGB(255, 53, 104, 153),
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: (innerPadding == null)? 5 : innerPadding),
        Text(
          headline,
          style: const TextStyle(
            color: Color.fromARGB(255, 13, 13, 38),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: (innerPadding == null)? 3 : innerPadding),
        Text(
          text,
          textAlign:  (crossAxisAlignment == null || crossAxisAlignment == "start") ? TextAlign.start : TextAlign.center,
          style: const TextStyle(
            color: Color.fromARGB(102, 13, 13, 38),
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }
}