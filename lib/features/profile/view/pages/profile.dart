// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/view/widgets/edit_info_bottom_sheet.dart';
import 'package:jop_finder_app/features/profile/view/widgets/edit_bio_bottomsheet.dart';
import 'package:jop_finder_app/features/profile/view/widgets/education_add_bottomsheet.dart';
import 'package:jop_finder_app/features/profile/view/widgets/info_display.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? user;
  ProfileCubit? profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    // Schedule the asynchronous operation to fetch user information
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserInfo();
    });
  }

  Future<void> _fetchUserInfo() async {
    // Fetch user information from Firestore using the cubit method
    var fetchedUser =
        await BlocProvider.of<ProfileCubit>(context).getUserInfo();
    if (mounted) {
      setState(() {
        user = fetchedUser;
      });
    }
  }

  Widget buildBlock() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          user = state.user;
          return buildProfileScreen();
        } else if (state is UserUpdated) {
          user = state.user;
          return buildProfileScreen();
        } else if (state is ProfileError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: Text('Error occurred'));
        }
      },
    );
  }

  Widget buildProfileScreen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          SizedBox(height: 16),
          Center(
              child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60.sp,
                backgroundImage: NetworkImage(user!.profileImageUrl??'https://via.placeholder.com/150'),
                // Replace with actual image URL
              ),
              Positioned(
                // Adjust this value to position the icon on the frame
                right:
                    7.sp, // Adjust this value to position the icon on the frame
                child: Container(
                  padding: EdgeInsets.all(5), // Adjust padding if necessary
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      profileCubit!.pickImageAndUpdateUser();
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                    iconSize: 15.sp, // Adjust icon size if necessary
                    padding: EdgeInsets
                        .zero, // Reduce padding inside IconButton to minimize size
                    constraints:
                        BoxConstraints(), // Remove minimum size constraints
                  ),
                ),
              ),
            ],
          )),
          SizedBox(height: 8),
          Center(
            child: Column(
              children: [
                Text(
                  user!.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user!.jobTitle ?? 'No job title',
                      style: TextStyle(color: Colors.grey),
                    ),
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
          SizedBox(height: 16),
          Center(
            child: Text(
              user!.appliedJobs!.length.toString()??'0',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
          ),
          Center(
            child: Text(
              'Applied',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: CustomInfoDisplay(text: user!.email, icon: Icons.email),
              ),
              SizedBox(width: 10.w), // Adjust spacing based on your layout
              Expanded(
                child: CustomInfoDisplay(
                    text: user!.phoneNumber ??'No phone number',
                    icon: Icons.phone_android_outlined),
              ),
            ],
          ),
          SizedBox(height: 24),
          buildAboutHeader('About', onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => EditBioBottomSheet(profileCubit!),
            );
          }),
          SizedBox(height: 10),
          CustomBioDisplay(text: user!.profile!.bio??'No bio added'),
          SizedBox(height: 24),
          buildSectionHeader('Education', onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => EducationAddBottomSheet(profileCubit!),
            );
          }),
          ListView.builder(
            shrinkWrap:
                true, // This ensures the ListView takes only the necessary height
            physics: NeverScrollableScrollPhysics(),
            itemCount: user!.profile!.education!.length ?? 0,
            itemBuilder: user!.profile!.education!.isEmpty
                ? (context, index) => Center(
                      child: Text('No education added'),
                    )
                : (context, index) {
                    return buildEducationItem(
                        education: user!.profile!.education![index]);
                  },
          ),
          SizedBox(height: 20),
          buildSectionHeader('Resume', onPressed: () {
            GoRouter.of(context).pushNamed('/resumeUploadScreen');
          }),
          resumeDisplay(),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(230, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(230, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryBlue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => EditInfoBottomSheet(profileCubit!, user!),
              );
            },
            icon: Icon(Icons.edit, color: AppColors.primaryBlue),
          ),
          IconButton(
            onPressed: () {
              GoRouter.of(context).pushNamed('/settingsScreen');
            },
            icon: Icon(Icons.settings, color: AppColors.primaryBlue),
          )
        ],
      ),
      body: buildBlock(),
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
            'Add',
            style: TextStyle(color: AppColors.primaryBlue),
          ),
        )
      ],
    );
  }

  Widget buildAboutHeader(String title, {required VoidCallback onPressed}) {
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
            'Edit',
            style: TextStyle(color: AppColors.primaryBlue),
          ),
        )
      ],
    );
  }

  Widget buildEducationItem({
    required Education? education,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 8),
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                education.degree ?? 'No Degree',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                '${education.institution ?? 'no institution'}  • ${education.startDate!.year} - ${education.endDate!.year}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget resumeDisplay() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: (user?.cvUrl == null || user!.cvUrl!.isEmpty)
          ? Center(
              child: Text('No CV. Add one.'.toUpperCase(),
                  style: TextStyle(color: Colors.grey, fontSize: 16)),
            )
          : InkWell(
              onTap: () {
                // Assuming `profileCubit` has the method `openPdf` to open the URL
                profileCubit!.openPdf(user!.cvUrl!);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 4), // Spacing between icon and text
                  Icon(
                    Icons.file_present,
                    size: 30,
                    color: AppColors.primaryBlue,
                  ), // File icon
                  SizedBox(width: 8), // Spacing between icon and text
                  Expanded(
                    child: Text('${user!.name} CV.pdf',
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                  ), // Displaying the file name extracted from the URL
                ],
              ),
            ),
    );
  }
}
