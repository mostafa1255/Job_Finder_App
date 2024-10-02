// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(244, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(244, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        
        actions: [
          TextButton(
            onPressed: () {
              // Edit button action
            },
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            SizedBox(height: 16),
            Center(
              child: CircleAvatar(
                radius: 50.sp,
                foregroundImage: NetworkImage(
                    'https://picsum.photos/200/300'), // Replace with actual image URL
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Column(
                children: [
                  Text(
                    'Haley Jessica',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'UX Designer',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(
                        Icons.verified,
                        color: Colors.blue,
                        size: 16,
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                '27',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Center(
              child: Text(
                'Applied',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            buildSectionHeader('Education', onPressed: () {}),
            buildExperienceItem(
              title: 'Computer Science',
              subtitle: 'Bachelor | Caltech',
              location: 'Pasadena',
              duration: '2017 - 2020',
              iconData: Icons.school,
            ),
            SizedBox(height: 20),
            buildSectionHeader('About', onPressed: () {}),
            buildExperienceItem(
              title: 'UX Intern',
              subtitle: 'Spotify',
              location: 'San Jose, US',
              duration: 'Dec 20 - Feb 21',
              iconData: Icons.music_note,
            ),
            SizedBox(height: 20),
            buildSectionHeader('Resume', onPressed: () {}),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // CV download action
                        },
                        child: Text('CV'),
                      ),
                      SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          // PDF download action
                        },
                        child: Text('PDF'),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Haley Jessica',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        Text(
                          'UX Designer',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Creative UX Designer with 3+ years of experience working with cross-functional teams to produce beautiful, functional designs.',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title, {required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            'See all',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget buildExperienceItem({
    required String title,
    required String subtitle,
    required String location,
    required String duration,
    required IconData iconData,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(iconData, size: 40, color: Colors.orange),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '$location • $duration',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
