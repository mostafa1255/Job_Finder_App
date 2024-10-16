import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'OnboardingScreen2.dart';
import 'OnboardingScreen3.dart';
import 'OnboardingScreen4.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({super.key});

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentPage = _controller.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 3) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      GoRouter.of(context).pushReplacementNamed(AppRouter.signUp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.primaryBlue,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              children: [
                SizedBox(
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.6,
                  child: PageView(
                    controller: _controller,
                    children: [
                      _buildFirstPage(screenWidth, screenHeight),
                      buildSecondPage(),
                      const ThirdScreen(),
                      const FourthScreen(),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: const ExpandingDotsEffect(
                    spacing: 4,
                    radius: 8,
                    dotWidth: 12,
                    dotHeight: 8,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.grey,
                    activeDotColor: Color.fromARGB(255, 53, 104, 153),
                  ),
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => GoRouter.of(context)
                            .pushReplacementNamed(AppRouter.signUp),
                        child: const Text(
                          'Skip',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _goToNextPage,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.1,
                              vertical: screenHeight * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppColors.primaryBlue,
                        ),
                        child: Text(
                          _currentPage == 3 ? 'Explore' : 'Next',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPage(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: ClipRect(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0.8,
              child: Image.asset(
                'assets/images/Job hunt-amico 1.png',
                width: screenWidth * 0.8,
                height: screenHeight * 0.35,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const Text(
          'Search your job',
          style: TextStyle(
              fontSize: 28, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.all(screenWidth * 0.04),
          child: const Text(
            'Figure out your top five priorities whether it is company culture, salary.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}
