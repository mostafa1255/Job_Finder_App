// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';



class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        children: [
          buildSectionTitle('Applications'),
          buildListItem(Icons.visibility_outlined, 'Profile Visibility'),
          buildListItem(Icons.notifications_outlined, 'Notification'),
          buildListItem(Icons.lock_outline, 'Change Password'),
          buildListItem(Icons.email_outlined, 'Change E-mail'),
          buildListItem(Icons.color_lens_outlined, 'Theme'),
          buildListItem(Icons.delete_outline, 'Delete Account', color: Colors.red),
          SizedBox(height: 20),
          buildSectionTitle('About'),
          buildListItem(Icons.privacy_tip_outlined, 'Privacy'),
          buildListItem(Icons.description_outlined, 'Terms and conditions'),
          buildListItem(Icons.info_outline, 'About'),
        ],
      ),
    );
  }

  Padding buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 18),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  ListTile buildListItem(IconData icon, String title, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      onTap: () {
        // Add your onTap functionality here
      },
    );
  }
}
