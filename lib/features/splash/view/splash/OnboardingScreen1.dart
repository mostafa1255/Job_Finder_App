import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'OnboardingScreen2.dart';
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
    print('');
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              SizedBox(
                width: 430,
                height: 500,
                child: PageView(
                  controller: _controller,
                  children: [
                    _buildFirstPage(),
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
              const Expanded(child: SizedBox()),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Skip',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    ElevatedButton(
                      onPressed: _goToNextPage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.primaryBlue,
                      ),
                      child: Text(
                        _currentPage == 3 ? 'Explore' : 'Next',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPage() {
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
                'assets/images/Job hunt-amico 1.png',
                width: 430,
                height: 430,
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
          margin: const EdgeInsets.all(15),
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
