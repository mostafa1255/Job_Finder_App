import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'OnboardingScreen2.dart';
import 'OnboardingScreen4.dart';



class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
    if (_currentPage < 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ThirdScreen()));
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
              FourthScreen(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [

                SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    spacing: 6,
                    radius: 10,
                    dotWidth: 24,
                    dotHeight: 16,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.indigo,
                  ),
                ),
                SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(context, MaterialPageRoute(builder: (context) => SixScreen()));
                //       },
                //       child: Text('Skip', style: TextStyle(fontSize: 17, color: Colors.grey)),
                //     ),
                //     ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Colors.indigo,
                //       ),
                //       onPressed: _goToNextPage,
                //       child: Container(
                //         width: 80,
                //         height: 50,
                //         child: Center(
                //           child: Text('Next', style: TextStyle(fontSize: 24, color: Colors.white)),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFirstPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('images/Job hunt-amico 1.png'),
        Text('Search your job', style: TextStyle(fontSize: 35, color: Colors.black)),
        Container(
          margin: EdgeInsets.all(20),
          child: Text(
            'Figure out your top five priorities whether it is company culture, salary.',
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }


}