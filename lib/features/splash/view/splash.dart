import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen1.dart';
// import 'package:jop_finder_app/features/splash/view/splash/Page1,2.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoardingScreen1(),
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.indigo,
            padding: EdgeInsets.all(100),
            child: Center(
              child: Image.asset(
                'assets/images/Group 218.png',
                fit: BoxFit.fill,
                color: Colors.white,
              ),
            )));
  }
}
