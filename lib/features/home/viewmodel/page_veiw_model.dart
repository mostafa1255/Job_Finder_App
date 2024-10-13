import 'package:flutter/material.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/web_services/firebase_authentication_web_services.dart';
import 'package:jop_finder_app/features/job_search/view/pages/job_search.dart';
import 'package:jop_finder_app/features/profile/view/pages/profile.dart';
import 'package:jop_finder_app/features/profile/view/pages/settings.dart';
import 'package:jop_finder_app/features/profile/viewmodel/firebase_profile_web_services.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';
import '../view/pages/home_screen.dart';

class PageViewModel extends StatefulWidget {
  const PageViewModel({super.key});

  @override
  State<PageViewModel> createState() => _PageViewModelState();
}

class _PageViewModelState extends State<PageViewModel> {
  int _currentIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    HomeScreen(),
    JobSearchScreen(),
    BlocProvider(
      create: (context) => ProfileCubit(
          FirebaseProfileWebServices(FireBaseAuthenticationWebServices())),
      child: ProfileScreen(),
    ),
    BlocProvider(
      create: (context) => ProfileCubit(
          FirebaseProfileWebServices(FireBaseAuthenticationWebServices())),
      child: SettingsScreen(),
    ),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: AnimatedBottomNavigationBar(
        barColor: Colors.white,
        controller: FloatingBottomBarController(initialIndex: 0),
        bottomBar: [
          BottomBarItem(
            icon: const Icon(Icons.home, size: 30),
            iconSelected:
                const Icon(Icons.home, color: AppColors.cherryRed, size: 30),
            title: 'home',
            dotColor: AppColors.cherryRed,
            onTap: (value) {
              _onTabTapped(0); // Home screen index
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.search, size: 30),
            iconSelected:
                const Icon(Icons.search, color: AppColors.cherryRed, size: 30),
            title: 'search',
            dotColor: AppColors.cherryRed,
            onTap: (value) {
              _onTabTapped(1); // Search screen index
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.person, size: 30),
            iconSelected:
                const Icon(Icons.person, color: AppColors.cherryRed, size: 30),
            title: 'profile',
            dotColor: AppColors.cherryRed,
            onTap: (value) {
              _onTabTapped(2); // Profile screen index
            },
          ),
          BottomBarItem(
            icon: const Icon(Icons.settings, size: 30),
            iconSelected: const Icon(Icons.settings,
                color: AppColors.cherryRed, size: 30),
            title: 'settings',
            dotColor: AppColors.cherryRed,
            onTap: (value) {
              _onTabTapped(3); // Settings screen index
            },
          ),
        ],
        bottomBarCenterModel: BottomBarCenterModel(
          centerBackgroundColor: Colors.black,
          centerIcon: FloatingCenterButton(
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRouter.jobPostScreen);
              },
              child: Icon(
                Icons.add,
                color: AppColors.white,
                size: 40.sp,
              ),
            ),
          ),
          centerIconChild: const [],
        ),
      ),
    );
  }
}
