import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';
import 'package:jop_finder_app/features/auth/data/web_services/firebase_authentication_web_services.dart';
import 'package:jop_finder_app/features/auth/view/screens/forget_password.dart';
import 'package:jop_finder_app/features/auth/view/screens/signin.dart';
import 'package:jop_finder_app/features/auth/view/screens/signup.dart';
import 'package:jop_finder_app/features/home/view/pages/home_screen.dart';
import 'package:jop_finder_app/features/job_apply/view/pages/job_apply.dart';
import 'package:jop_finder_app/features/job_apply/view/pages/succefull_Screen.dart';
import 'package:jop_finder_app/features/job_post/view/pages/all_applicants_screen.dart';
import 'package:jop_finder_app/features/job_post/view/pages/job_post.dart';
import 'package:jop_finder_app/features/job_post/view/pages/my_postedJob.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_cubit.dart';
import 'package:jop_finder_app/features/profile/view/pages/applications.dart';
import 'package:jop_finder_app/features/profile/view/pages/profile.dart';
import 'package:jop_finder_app/features/profile/view/pages/proposals.dart';
import 'package:jop_finder_app/features/profile/view/pages/resume.dart';
import 'package:jop_finder_app/features/profile/view/pages/settings.dart';
import 'package:jop_finder_app/features/profile/viewmodel/firebase_profile_web_services.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';
import 'package:jop_finder_app/features/splash/view/splash.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen1.dart';

import '../../features/home/view/pages/see_all_page.dart';
import '../../features/job_search/view/pages/job_search.dart';

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
  static const allApplicantsScreen = "/allApplicantsScreen";
  static const myPostedJob = "/myPostedJob";
  static const successScreen = "/successScreen";
  static const jobSearchScreen = "/jobSearchScreen";
  static const seeAllPage = "/seeAllPage";



  static FireBaseAuthenticationWebServices fireBaseAuthenticationWebServices =
      FireBaseAuthenticationWebServices();
  static FirebaseProfileWebServices firebaseProfileWebServices =
      FirebaseProfileWebServices(fireBaseAuthenticationWebServices);
  static ProfileCubit profileCubit = ProfileCubit(firebaseProfileWebServices);

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
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SignUpScreen(),
          transitionsBuilder: _fadeTransition, // Slide transition
        ),
      ),
      GoRoute(
        path: login,
        name: login,
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
          path: forgetPassword,
          name: forgetPassword,
          pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const ForgetPasswordScreen(),
                transitionsBuilder: _slideTransition, // Slide transition
              )),
      GoRoute(
        path: homeScreen,
        name: homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: jobSearchScreen,
        name: jobSearchScreen,
        builder: (context, state) => BlocProvider.value(
          value: JobSearchCubit(),
          child: const JobSearchScreen(),
        ),
      ),
      GoRoute(
        path: jobApplyScreen,
        name: jobApplyScreen,
        builder: (context, state) =>
            JobApplyScreen(job: state.extra as PostedJob),
      ),

      GoRoute(
        path: successScreen,
        name: successScreen,
        builder: (context, state) => SuccefullScreen(),
      ),
      GoRoute(
        path: jobPostScreen,
        name: jobPostScreen,
        builder: (context, state) => JobPostScreen(),
      ),
      GoRoute(
        path: seeAllPage,
        name: seeAllPage,
        builder: (context, state) => SeeAllPage(),
      ),
      GoRoute(
        path: myPostedJob,
        name: myPostedJob,
        builder: (context, state) => const MyPostedJob(),
      ),
      GoRoute(
        path: allApplicantsScreen,
        name: allApplicantsScreen,
        builder: (context, state) =>
            AllApplicantsScreen(jobId: state.extra as String),
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
              )),
      GoRoute(
        path: settingsScreen,
        name: settingsScreen,
        builder: (context, state) => BlocProvider.value(
          value: profileCubit,
          child: SettingsScreen(),
        ),
      ),
      GoRoute(
        path: applicationsScreen,
        name: applicationsScreen,
        builder: (context, state) => BlocProvider.value(
          value: profileCubit,
          child: ApplicationsScreen(),
        ),
      ),
      GoRoute(
        path: proposalsScreen,
        name: proposalsScreen,
        builder: (context, state) => BlocProvider.value(
          value: profileCubit,
          child: ProposalsScreen(),
        ),
      ),
      //end bodaSayed
    ],
  );

  // Slide transition
  static Widget _slideTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0); // Slide from right
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  // Fade transition
  static Widget _fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
