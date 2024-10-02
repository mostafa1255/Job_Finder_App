// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    ListTile buildDrawerItem(IconData icon, String title,
        {Color color = Colors.black, required String screen}) {
      return ListTile(
        contentPadding: EdgeInsets.only(left: 20.w), // 24 pixels padding
        leading: Icon(icon, color: color),
        title: Text(title, style: TextStyle(color: color, fontSize: 10.sp)),
        onTap: () {
          Navigator.pop(context); 
          GoRouter.of(context).pushNamed(screen);
                  
        },
      );
    }

    return Drawer(
      width: 0.6.sw, // 80% of screen width
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40.h), // 50 pixels from top
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40.w, // 90 pixels width
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150', // Replace with your image URL
                        ),
                      ),
                    ),
                    Positioned(
                      top: -6.h, // 10 pixels from top
                      right: 6.w, // 6 pixels from right
                      child: IconButton(
                        icon: Icon(Icons.close, size: 14.sp), // 30 pixels size
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h), // 10 pixels height
                Text(
                  'Haley Jessica',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp), // 24 pixels font size
                ),
                SizedBox(height: 4.h), // 10 pixels height
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'UX Designer',
                      style: TextStyle(color: Colors.grey, fontSize: 8.sp),
                    ),
                    Icon(
                      Icons.verified,
                      color: Colors.blue,
                      size: 8.sp, // 16 pixels size
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          // Drawer ItemsbuildDrawerItem(Icons.person_outline, 'Personal Info', route: '/personal-info'),

          buildDrawerItem(Icons.person_outline, ' View Profile',
              screen: '/profileScreen'),
          buildDrawerItem(Icons.app_registration, 'Applications',
              screen: '/applicationsScreen'),
          buildDrawerItem(Icons.description_outlined, 'Proposals',
              screen:   '/proposalsScreen'),
          buildDrawerItem(Icons.assignment_ind_outlined, 'Resume',
              screen: '/resumeUploadScreen'),
          buildDrawerItem(Icons.settings_outlined, 'Settings',
              screen: '/settingsScreen'),
          buildDrawerItem(Icons.logout, 'Logout',
              color: Colors.red, screen: '/login'),
        ],
      ),
    );
  }
}
