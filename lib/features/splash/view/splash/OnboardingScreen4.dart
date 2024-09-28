import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/pages/signin.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen5.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/Career progress-amico 1 (1).png'),
            const Text(
              'Make your career',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
              ),
            ),
            const Text(
              'We help you find your dream job based on your skillset, location, demand.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Registeration(),
                      ));
                },
                child: Container(
                  width: 220,
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: const Center(
                    child: Text(
                      'Explore',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
