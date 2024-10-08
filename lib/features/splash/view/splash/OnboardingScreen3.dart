import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/Resume-amico 1 (2).png'),
          const Text(
            'Apply to best jobs',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              'You can apply to your desirable jobs very quickly and easily with ease.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
