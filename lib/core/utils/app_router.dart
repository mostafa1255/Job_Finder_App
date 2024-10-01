import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/features/auth/view/pages/forget_password.dart';
import 'package:jop_finder_app/features/auth/view/pages/login.dart';
import 'package:jop_finder_app/features/auth/view/pages/signin.dart';
import 'package:jop_finder_app/features/home/view/pages/home_screen.dart';
import 'package:jop_finder_app/features/splash/view/splash.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen1.dart';

class AppRouter {
  static const splash = "/splash";
  static const onBoardingScreens = "/onBoardingScreens";
  static const signUp = "/signUp";
  static const login = "/login";
  static const forgetPassword = "/forgetPassword";
  static const homeScreen = "/homeScreen";

  static GoRouter router = GoRouter(
    initialLocation: homeScreen,
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: splash,
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: onBoardingScreens,
        path: onBoardingScreens,
        builder: (context, state) => const OnBoardingScreen1(),
      ),
      GoRoute(
        path: signUp,
        name: signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: login,
        name: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: forgetPassword,
        name: forgetPassword,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        path: homeScreen,
        name: homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
