// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/view/widgets/info_display.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class OthersProfileScreen extends StatelessWidget {

  const OthersProfileScreen({super.key, required this.user, required this.index});
  final List<UserModel> user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text('${user[index].name} Profile'),
        centerTitle: true,
      ),
      body: SafeArea(child: buildProfileScreen(context)),
    );
  }

  Widget buildProfileScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          SizedBox(height: 16),
          Center(
              child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.grey.shade200,
            child: ClipOval(
              child: Uri.parse(user[index].profileImageUrl ?? "").hasAbsolutePath
                  ? CachedNetworkImage(
                      imageUrl: user[index].profileImageUrl!,
                      fit: BoxFit.cover,
                      width: 120.w,
                      height: 120.h,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    )
                  : const Icon(Icons.person),
            ),
          )),
          SizedBox(height: 8),
          Center(
            child: Column(
              children: [
                Text(
                  user[index].name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user[index].profile!.jobTitle ?? 'No job title',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.verified,
                      color: AppColors.primaryBlue,
                      size: 16,
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Text(
                  user[index].profile!.status ?? 'No status',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Status',
                ),
              ],
            ),
          ),
          SizedBox(height: 44),
          Text(
            'Contacts ',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 10),
          CustomInfoDisplay(text: user[index].email, icon: Icons.email),
          SizedBox(width: 10.w), // Adjust spacing based on your layout width
          CustomInfoDisplay(
              text: user[index].phoneNumber ?? 'No phone number',
              icon: Icons.phone_android),
          SizedBox(height: 24),
          Text(
            "Bio",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 10),
          CustomBioDisplay(text: user[index].profile!.bio ?? 'No bio'),
          SizedBox(height: 28),
          Text(
            "Education",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 10),
          buildEducationSection(),
          SizedBox(height: 26),
          Text(
            "Resume",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 10),
          resumeDisplay( context),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget buildEducationSection() {
  // Check if profile or education list is null or empty
  if (user[index].profile == null || user[index].profile!.education == null || user[index].profile!.education!.isEmpty) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Center(
        child: Text('No education added'.toUpperCase(),
            style: TextStyle(color: Colors.grey, fontSize: 16)),
      ),
    );
  }

  // Otherwise, return the ListView
  return ListView.builder(
    shrinkWrap: true, // This ensures the ListView takes only the necessary height
    physics: NeverScrollableScrollPhysics(),
    itemCount: user[index].profile!.education!.length,
    itemBuilder: (context, eduIndex) {
      return buildEducationItem(
          education: user[index].profile!.education![eduIndex], context: context);
    },
  );
}

Widget buildEducationItem({
  required Education? education,
  required BuildContext context,
}) {
  if (education == null) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Center(
        child: Text('No education information'.toUpperCase(),
            style: TextStyle(color: Colors.grey, fontSize: 16)),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
    margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(Icons.school, size: 40, color: AppColors.primaryBlue),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              education.fieldOfStudy ?? 'No Field',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 4),
            Text(education.degree ?? 'No Degree'),
            Text(
              '${education.institution ?? 'no institution'}  • ${education.startDate?.year ?? 'Past'} - ${education.endDate?.year ?? 'Present'}',
            ),
          ],
        ),
      ],
    ),
  );
}

  Widget resumeDisplay( BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: (user[index].cvUrl == null || user[index].cvUrl!.isEmpty)
          ? Center(
              child: Text('No CV. '.toUpperCase(),
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            )
          : Center(
            child: Row(
                children: [
                  SizedBox(width: 4),
                  Icon(
                    Icons.file_present,
                    size: 30,
                    color: AppColors.primaryBlue,
                  ),
                  SizedBox(width: 12),
                  InkWell(
                    onTap: ()  {
                      launch(user[index].cvUrl!);
                    },
                    child: Text(
                        '${user[index].name}_${user[index].profile!.jobTitle}_CV.pdf',
                        style: Theme.of(context).textTheme.displayMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
          ),
    );
  }
}
