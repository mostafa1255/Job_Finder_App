import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/jobs_card.dart';
import 'package:jop_finder_app/features/job_search/view/widgets/user_card.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({
    super.key,
    required this.userName,
    required this.users,
  });

  final String userName;
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return UserCard(
              userName: user.name ?? 'Unknown Title',
              profileImageUrl: user.profileImageUrl ?? 'Unknown Title',
              onClick:() {
                GoRouter.of(context).push("/othersProfileScreen",
                  extra:
                    {
                      'user': users,
                      'index': index,
                    },
                );
              }
            );
          },
        ),
      ),
    );
  }
}
