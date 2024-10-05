import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/features/auth/data/web_services/firebase_authentication_web_services.dart';
import 'package:jop_finder_app/features/auth/view/screens/forget_password.dart';
import 'package:jop_finder_app/features/auth/view/screens/signin.dart';
import 'package:jop_finder_app/features/auth/view/screens/signup.dart';
import 'package:jop_finder_app/features/home/view/pages/home_screen.dart';
import 'package:jop_finder_app/features/job_apply/view/pages/job_apply.dart';
import 'package:jop_finder_app/features/job_post/view/pages/job_post.dart';
import 'package:jop_finder_app/features/profile/view/pages/applications.dart';
import 'package:jop_finder_app/features/profile/view/pages/profile.dart';
import 'package:jop_finder_app/features/profile/view/pages/proposals.dart';
import 'package:jop_finder_app/features/profile/view/pages/resume.dart';
import 'package:jop_finder_app/features/profile/view/pages/settings.dart';
import 'package:jop_finder_app/features/profile/viewmodel/firebase_profile_web_services.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';
import 'package:jop_finder_app/features/splash/view/splash.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen1.dart';

class AppRouter {
  static const splash = "/splash";
  static const onBoardingScreens = "/onBoardingScreens";
  static const signUp = "/signUp";
  static const login = "/login";
  static const forgetPassword = "/forgetPassword";
  static const homeScreen = "/homeScreen";
  static const jobApplyScreen = "/jobApplyScreen";
  static const jobPostScreen = "/jobPostScreen";
  static const profileScreen = "/profileScreen";
  static const resumeUploadScreen = "/resumeUploadScreen";
  static const settingsScreen = "/settingsScreen";
  static const applicationsScreen = "/applicationsScreen";
  static const proposalsScreen = "/proposalsScreen";

  static FireBaseAuthenticationWebServices fireBaseAuthenticationWebServices =
      FireBaseAuthenticationWebServices();
  static FirebaseProfileWebServices firebaseProfileWebServices =
      FirebaseProfileWebServices(fireBaseAuthenticationWebServices);
  static ProfileCubit profileCubit = ProfileCubit(firebaseProfileWebServices);

  static GoRouter router = GoRouter(
    initialLocation: resumeUploadScreen,
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
      GoRoute(
        path: jobApplyScreen,
        name: jobApplyScreen,
        builder: (context, state) => JobApplyScreen(),
      ),
      GoRoute(
        path: jobPostScreen,
        name: jobPostScreen,
        builder: (context, state) => JobPostScreen(),
      ),
      //bodaSayed
      GoRoute(
        path: profileScreen,
        name: profileScreen,
        builder: (context, state) => BlocProvider.value(
          value: profileCubit,
          child: ProfileScreen(),
        ),
      ),
      GoRoute(
        path: resumeUploadScreen,
        name: resumeUploadScreen,
        builder: (context, state) => BlocProvider.value(
          value: profileCubit,
          child: ResumeUploadScreen(),
          )
        ),
      GoRoute(
        path: settingsScreen,
        name: settingsScreen,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: applicationsScreen,
        name: applicationsScreen,
        builder:  (context, state) => BlocProvider.value(
          value: profileCubit,
          child: ApplicationsScreen(),
        ),
      ),
      GoRoute(
        path: proposalsScreen,
        name: proposalsScreen,
        builder: (context, state) => ProposalsScreen(),
      ),
      //end bodaSayed
    ],
  );
}
