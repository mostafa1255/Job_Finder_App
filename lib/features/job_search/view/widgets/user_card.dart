import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.userName,
    required this.profileImageUrl,
    required this.onClick,
  });

  final String userName;
  final String profileImageUrl;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onClick,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImageUrl),
                ),
                const SizedBox(width: 10),
                Text(userName),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
