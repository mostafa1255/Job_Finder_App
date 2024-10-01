import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jop_finder_app/features/auth/view/pages/signin.dart';
import 'package:jop_finder_app/main.dart';

class FourthScreen extends StatelessWidget {
  const FourthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/Career progress-amico 1 (1).png'),
          const Text(
            'Make your career',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
            ),
          ),
          const Text(
            'We help you find your dream job based on your skillset, location, demand.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          // SizedBox(
          //   width: 200.w,
          //   height: 50.h,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.indigo,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //     onPressed: () {
          //       Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => const Registeration(),
          //           ));
          //     },
          //     child: Text(
          //       'Explore',
          //       style: TextStyle(fontSize: 24, color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
