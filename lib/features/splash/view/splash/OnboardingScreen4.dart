import 'package:flutter/material.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRect(
            child: Align(
              alignment: Alignment
                  .topCenter, // Aligns the part of the image you want to show
              heightFactor:
                  0.8, // Adjust this to control how much of the image is shown
              child: Image.asset(
                'assets/images/Career progress-amico 1 (1).png',
                width: screenWidth * 0.8,
                height: screenHeight * 0.35,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Text(
          'Make your career',
          style: TextStyle(
              fontSize: 28, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: const EdgeInsets.all(15),
          child: const Text(
            'We help you find your dream job based on your skillset, location, demand.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
