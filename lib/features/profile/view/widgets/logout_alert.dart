import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';

class CustomLogoutAlert extends StatelessWidget {
  const CustomLogoutAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Logout ',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColor.primaryBlue,
            fontSize: 24),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Are you sure you want to logout?',
        textAlign: TextAlign.center,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: const Text('Cancel',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: MyColor.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  // Handle logout logic
                  Navigator.of(context).pop();
                  GoRouter.of(context).pushNamed('/login');
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
