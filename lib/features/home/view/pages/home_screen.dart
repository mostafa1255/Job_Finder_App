import 'package:flutter/material.dart';
import 'recommended_jops_card.dart';
import 'job_card.dart';
import 'bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'), // Add your profile image here
            radius: 20,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome Back!', style: TextStyle(fontSize: 24)),
              Text('John Lucas 👋', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured Jobs', style: TextStyle(fontSize: 20)),
                  Text('See all', style: TextStyle(fontSize: 16, color: Colors.blue)),
                ],
              ),

              SizedBox(height: 10),

              // Featured job cards
              SizedBox(
                height: 200, // Adjust height for job cards
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    JobCard(
                      company: 'Google',
                      title: 'Product Designer',
                      salary: '\$160,000/year',
                      location: 'California, USA',
                      tags: ['Design', 'Full-Time', 'Junior'],
                      color: Colors.blueAccent,
                    ),
                    JobCard(
                      company: 'Facebook',
                      title: 'Sr Engineer',
                      salary: '\$120,000/year',
                      location: 'New York, USA',
                      tags: ['Engineering', 'Full-Time', 'Senior'],
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended Jobs', style: TextStyle(fontSize: 20)),
                  Text('See all', style: TextStyle(fontSize: 16, color: Colors.blue)),
                ],
              ),

              SizedBox(height: 10),

              // Recommended job cards

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RecommendedJopsCard(
                    company: 'Dribbble',
                    title: 'UX Designer',
                    salary: '\$80,000/year',
                    color: Colors.pinkAccent,
                    companyLogo: Image.asset('assets/images/b.jpeg'),
                  ),
                  SizedBox(height: 10),
                  RecommendedJopsCard(
                    company: 'Facebook',
                    title: 'Sr Engineer',
                    salary: '\$96,000/year',
                    companyLogo: Image.asset('assets/images/c.jpeg'),

                    color: Colors.blueAccent,
                  ),
                ],
              ),


            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(), // Custom widget for navigation
    );
  }
}
