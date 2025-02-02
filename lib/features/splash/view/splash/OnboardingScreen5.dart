import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/splash/view/splash/OnboardingScreen6.dart';
// import 'package:jobsearch/Page4.dart';
// import 'package:jobsearch/Page6.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FifthScreen extends StatelessWidget {
  const FifthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/images/Career progress-pana 1 (1).png'),
            Container(
              child: const Text(
                'Search your dream job fast and ease',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: const Text(
                'Figure out your top five priorities -- whether it is company culture, salaryor a specific job position. ',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 170),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 90),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SixScreen(),
                          ));
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SixScreen(),
                          ));
                    },
                    child: Container(
                      width: 80,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                      ),
                      child: Container(
                          child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      )),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
