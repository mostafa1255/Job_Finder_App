import 'package:flutter/material.dart';

Widget buildSecondPage() {
  return Container(
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.all(10),
    child: Padding(
      padding: const EdgeInsets.only(top: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/images/Browser stats-amico 1.png'),
          Text('Browse jobs list',
              style: TextStyle(fontSize: 35, color: Colors.black)),
          Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Our job list include several industries, so you can find the best job for you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    ),
  );
}
