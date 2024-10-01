import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'recommended_jops_card.dart';
import 'job_card.dart';
import 'bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Welcome Back!', style: TextStyle(fontSize: 24)),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.jpg'),
                    radius: 20,
                  ),
                ],
              ),
              Text('John Lucas 👋',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Search for jobs...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured Jobs',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('See all',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return JobCard(
                          company: 'Facebook',
                          title: 'Sr Engineer',
                          salary: '\$120,000/year',
                          location: 'New York, USA',
                          tags: ['Engineering', 'Full-Time', 'Senior'],
                          color: Colors.blue,
                        );
                      })),
              SizedBox(height: 40.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended Jobs',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('See all',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RecommendedJopsCard(
                        company: 'Dribbble',
                        title: 'UX Designer',
                        salary: '\$80,000/year',
                        color: Colors.pinkAccent,
                        companyLogo: Image.asset('assets/images/b.jpeg'),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(), // Custom widget for navigation
    );
  }
}
