// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/constants/strings.dart';
import 'package:jop_finder_app/features/profile/view/widgets/custom_alert.dart.dart';

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
          // buildListItem(Icons.visibility_outlined, 'Profile Visibility'),
          // buildListItem(Icons.lock_outline, 'Change Password'),
          // buildListItem(Icons.email_outlined, 'Change E-mail'),
          // buildListItem(Icons.color_lens_outlined, 'Theme'),
          // buildListItem(Icons.delete_outline, 'Delete Account', color: Colors.red),
          SizedBox(height: 20),
          buildSectionTitle('About'),
          buildListItem(Icons.privacy_tip_outlined, 'Privacy', onTap: () {
            showPrivacyDialog(context);
          }),
          buildListItem(Icons.description_outlined, 'Terms and conditions' , onTap: () {
            showTermsDialog(context);
          }),
          buildListItem(Icons.info_outline, 'About' , onTap: () {
            showAboutDialog(context);
          }),
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

  ListTile buildListItem(IconData icon, String title, {Color color = Colors.black, required Function onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color),
      ),
      onTap: () {
        onTap();
      },
    );
  }
  void showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Privacy',
        body: AppStrings.privacyPolicy,
        actionButtonTitle: 'Done',
      ),
    );
  }
  void showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Terms and Conditions',
        body: AppStrings.termsAndConditions,
        actionButtonTitle: 'Done',
      ),
    );
  }
  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'About',
        body: AppStrings.about,
        actionButtonTitle: 'Done',
      ),
    );
  }

  
}
