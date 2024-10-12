import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              _buildFirstPage(),
              buildSecondPage(),
              ThirdScreen(),
              const FourthScreen(),
            ],
          ),
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                   Padding(
                     padding: const EdgeInsets.all(32),
                     child: SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: const ExpandingDotsEffect(
                        spacing: 3,
                        radius: 8,
                        dotWidth: 12,
                        dotHeight: 12,
                        paintStyle: PaintingStyle.fill,
                        dotColor: Colors.grey,
                        activeDotColor: Color.fromARGB(255, 53, 104, 153),
                      ),
                     ),
                   ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal:16),
                          ),
                          if (_currentPage != 3)
                          Text('Skip', style: TextStyle(fontSize: 18, color: Colors.grey.withOpacity(0.6)),),
                          Spacer(),
                             ElevatedButton(
                            onPressed: _goToNextPage,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Color.fromARGB(255, 53, 104, 153),
                            ),
                            child: Text(
                              _currentPage == 3 ? 'Explore' : 'Next' ,
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            ),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal:16),
                          ),
                        ],
                      ),
                const SizedBox(height: 50),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstPage() {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/Job hunt-amico 1.png'),
          const Text(
            'Search your job',
            style: TextStyle(fontSize: 35, color: Colors.black),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              'Figure out your top five priorities whether it is company culture, salary.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
