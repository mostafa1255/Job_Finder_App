import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/viewmodel/cubit/auth_cubit.dart';
import 'package:jop_finder_app/features/home/view/pages/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigateFromSplash();
    super.initState();
  }

  void navigateFromSplash() async {
    await Future.delayed(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      String? userToken = prefs.getString(userTokenKey);

      if (userToken != null) {
        GoRouter.of(context).pushReplacementNamed(AppRouter.homeScreen);
                // GoRouter.of(context).pushReplacementNamed(AppRouter.jobPostScreen);

      } else {
        if (mounted) {
          GoRouter.of(context)
              .pushReplacementNamed(AppRouter.onBoardingScreens);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromARGB(255, 53, 104, 153),
            padding: const EdgeInsets.all(100),
            child: Center(
              child: Image.asset(
                'assets/images/Group 218.png',
                fit: BoxFit.fill,
                color: Colors.white,
              ),
            )));
  }
}
