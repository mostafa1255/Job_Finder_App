import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});
  @override
  Widget build(BuildContext context) {
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
                'assets/images/Resume-amico 1 (2).png',
                width: 430,
                height: 430,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Text(
          'Apply to best jobs',
          style: TextStyle(
              fontSize: 28, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: const EdgeInsets.all(15),
          child: const Text(
            'You can apply to your desirable jobs very quickly and easily with ease.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
