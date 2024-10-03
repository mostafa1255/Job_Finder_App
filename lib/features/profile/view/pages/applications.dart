// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
class ApplicationsScreen extends StatelessWidget {
  final List<Application> applications = [
    Application('Google', 'Jr Executive', '\$115,000/y', 'Canceled', 'Full-Time', 'Los Angeles, US', Colors.redAccent),
    Application('Beats', 'Mid Executive', '\$86,000/y', 'Reviewing', 'Full-Time', 'San Jose, US', Colors.greenAccent),
    Application('Spotify', 'Sr Executive', '\$96,000/y', 'Delivered', 'Full-Time', 'San Francisco, US', Colors.blueAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
              backgroundColor: Colors.white,

        title: Text('Applications'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://example.com/profile.jpg'), // Placeholder for profile image
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have 27 Applications ',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  return ApplicationCard(application: applications[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Application {
  final String company;
  final String title;
  final String salary;
  final String status;
  final String jobType;
  final String location;
  final Color statusColor;

  Application(this.company, this.title, this.salary, this.status, this.jobType, this.location, this.statusColor);
}


class ApplicationCard extends StatelessWidget {
  final Application application;

  const ApplicationCard({required this.application});

  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Placeholder for company logos
                Image.network(
                  'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png', // Replace with actual company logo URL
                  height: 40,
                  width: 40,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      application.company,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(application.salary, style: TextStyle(fontSize: 16)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: application.statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    application.status,
                    style: TextStyle(color: application.statusColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(application.jobType, style: TextStyle(fontSize: 14, color: Colors.grey)),
            SizedBox(height: 4),
            Text(application.location, style: TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
