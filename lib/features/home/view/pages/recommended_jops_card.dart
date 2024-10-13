import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedJopsCard extends StatelessWidget {
  final String company;
  final String title;
  final String salary;
  final Color color;
  final String companyLogo;

  const RecommendedJopsCard({
    super.key,
    required this.company,
    required this.title,
    required this.salary,
    required this.color,
    required this.companyLogo,
  });

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
                radius: 30,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: companyLogo,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Job Title
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Company Name
              Text(
                company,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),

              const SizedBox(height: 2),

              // Tags (now wrapped to avoid overflow)

              const SizedBox(height: 2),

              // Salary
              Text(
                salary,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}