import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jop_finder_app/features/home/view/pages/home_screen.dart';

class RecommendedJopsCard extends StatelessWidget {
  final String company;
  final String title;
  final String salary;
  final Color color;
  final Image companyLogo;

  const RecommendedJopsCard({
    Key? key,
    required this.company,
    required this.title,
    required this.salary,
    required this.color,
    required this.companyLogo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: 150.w,
        height: 260,
        decoration: BoxDecoration(
          // Setting the card background with opacity
          color: color, // Adjust the background opacity here
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    companyLogo.image, // Add your profile image here
                radius: 30,
              ),

              SizedBox(height: 15),

              // Job Title
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Company Name
              Text(
                company,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),

              SizedBox(height: 2),

              // Tags (now wrapped to avoid overflow)



              // Salary
              Text(
                salary,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
