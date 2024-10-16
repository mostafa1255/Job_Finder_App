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

  const OthersProfileScreen({super.key, required this.user});
  final UserModel user;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title:  Text('${user.name} Profile'),
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
              child: Uri.parse(user.profileImageUrl ?? "").hasAbsolutePath
                  ? CachedNetworkImage(
                      imageUrl: user.profileImageUrl!,
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
                  user.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.profile!.jobTitle ?? 'No job title',
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
                  user.profile!.status ?? 'No status',
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
          CustomInfoDisplay(text: user.email, icon: Icons.email),
          SizedBox(width: 10.w), // Adjust spacing based on your layout width
          CustomInfoDisplay(
              text: user.phoneNumber ?? 'No phone number',
              icon: Icons.phone_android),
          SizedBox(height: 24),
          Text(
            "Bio",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          SizedBox(height: 10),
          CustomBioDisplay(text: user.profile!.bio ?? 'No bio'),
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
    if (user.profile?.education == null || user.profile!.education!.isEmpty) {
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
    } else {
      return ListView.builder(
        shrinkWrap:
            true, // This ensures the ListView takes only the necessary height
        physics: NeverScrollableScrollPhysics(),
        itemCount: user.profile!.education!.length,
        itemBuilder: (context, index) {
          return buildEducationItem(
              education: user.profile!.education![index], context: context);
        },
      );
    }
  }

  Widget buildEducationItem({
    required Education? education, 
    BuildContext? context, 
  }) {
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
                education!.fieldOfStudy ?? 'No Field',
                style: Theme.of(context!).textTheme.displayMedium,
              ),
              const SizedBox(height: 4),
              Text(
                education.degree ?? 'No Degree',
              ),
              Text(
                '${education.institution ?? 'no institution'}  • ${education.startDate!.year} - ${education.endDate!.year}',
              ),
            ],
          )
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
      child: (user.cvUrl == null || user.cvUrl!.isEmpty)
          ? Center(
              child: Text('No CV. '.toUpperCase(),
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4),
                Icon(
                  Icons.file_present,
                  size: 30,
                  color: AppColors.primaryBlue,
                ),
                SizedBox(width: 12),
                InkWell(
                  onTap: () async {
                     if (await canLaunch(user.cvUrl!)) {
                      await launch(user.cvUrl!);
                    } else {
                      throw 'Could not launch ${user.cvUrl}';
                    }
                  },
                  child: Text(
                      '${user.name}_${user.profile!.jobTitle}_CV.pdf',
                      style: Theme.of(context).textTheme.displayMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
    );
  }
}
