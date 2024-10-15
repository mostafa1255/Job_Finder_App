// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/view/widgets/custom_alert.dart.dart';
import 'package:jop_finder_app/features/profile/view/widgets/edit_info_dialog.dart';
import 'package:jop_finder_app/features/profile/view/widgets/edit_bio_dialog.dart';
import 'package:jop_finder_app/features/profile/view/widgets/education_add_dialog.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((context) {
      _fetchUserInfo();
    });
  }

  Future<void> _fetchUserInfo() async {
    // Fetch user information from Firestore using the cubit method
    var fetchedUser =
        await BlocProvider.of<ProfileCubit>(context).getUserInfo();
    if (fetchedUser.profile == null) {
      UserProfile userProfile = UserProfile(
        bio: 'No bio added',
        education: [],
        jobTitle: 'No job title',
        status: 'No status',
      );
      BlocProvider.of<ProfileCubit>(context).updateUserProfile(userProfile);
    }
    if (mounted) {
      setState(() {
        user = fetchedUser;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => EditInfoDialog(profileCubit!, user!),
              );
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
          IconButton(
            onPressed: () {
              // GoRouter.of(context).pushNamed('/applicationsScreen');
              GoRouter.of(context).pushNamed('/settingsScreen');
            },
            icon: Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body:  SafeArea(child: buildBlock()),
    );
  }

  Widget buildBlock() {
    if (profileCubit == null) {
      return Center(child: Text('ProfileCubit is null'));
    }
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded ) {
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
                radius: 80,
                backgroundColor: Colors.grey.shade200,
                child: ClipOval(
                  child: Uri.parse(user?.profileImageUrl ?? "").hasAbsolutePath
                      ? CachedNetworkImage(
                          imageUrl: user!.profileImageUrl!,
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
              ),
              Positioned(
                right:
                    7.w, 
                child: Container(
                  width: 35,
                  height: 35,
                  padding: EdgeInsets.all(5), 
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      profileCubit!.pickImageAndUpdateUser();
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
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
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user!.profile!.jobTitle ?? 'No job title',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      user!.appliedJobs!.length.toString(),
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'Applied',
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      user!.profile!.status ?? 'No status',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'Status',
                    ),
                  ],
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
          CustomInfoDisplay(text: user!.email, icon: Icons.email),
          SizedBox(width: 10.w), // Adjust spacing based on your layout width
          CustomInfoDisplay(
              text: user!.phoneNumber ?? 'No phone number',
              icon: Icons.phone_android),
          SizedBox(height: 24),
          buildBioHeader('Bio', onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EditBioDialog(profileCubit!),
            );
          }),
          SizedBox(height: 10),
          CustomBioDisplay(text: user!.profile!.bio ?? 'No bio'),
          SizedBox(height: 28),
          buildSectionHeader('Education', onPressed: () {
            showDialog(
              context: context,
              builder: (context) => EducationAddDialog(profileCubit!),
            );
          }),
          SizedBox(height: 10),
          buildEducationSection(),
          SizedBox(height: 26),
          buildSectionHeader('Resume', onPressed: () {
            GoRouter.of(context).pushNamed('/resumeUploadScreen');
          }),
          SizedBox(height: 10),
          resumeDisplay(),
          SizedBox(height: 32),
        ],
      ),
    );
  }


  Widget buildSectionHeader(String title, {required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
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

  Widget buildBioHeader(String title, {required VoidCallback onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayLarge,
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

  Widget buildEducationSection() {
    if (user?.profile?.education == null || user!.profile!.education!.isEmpty) {
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
        itemCount: user!.profile!.education!.length,
        itemBuilder: (context, index) {
          return buildEducationItem(
              education: user!.profile!.education![index]);
        },
      );
    }
  }

  Widget buildEducationItem({
    required Education? education,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.school, size: 40, color: AppColors.primaryBlue),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    education!.fieldOfStudy ?? 'No Field',
                    style: Theme.of(context).textTheme.displayMedium,
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
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomAlertDialog(
                    title: 'Delete Education',
                    body: 'Are you sure you want to Delete this Education?',
                    actionButtonTitle: 'Delete',
                    onActionButtonPressed: () {
                      Navigator.of(context).pop();
                      profileCubit!.removeEducation(education);
                    },
                  );
                },
              );
            },
            icon: Icon(Icons.delete, color: AppColors.primaryBlue),
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
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 4), 
                    Icon(
                      Icons.file_present,
                      size: 30,
                      color: AppColors.primaryBlue,
                    ),
                    SizedBox(width: 12), 
                    InkWell(
                      onTap: () {
                        profileCubit!.openPdf(user!.cvUrl!);
                      },
                      child: Text(
                          '${user!.name}_${user!.profile!.jobTitle}_CV.pdf',
                          style: Theme.of(context).textTheme.displayMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                    ), 
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          title: 'Delete CV ',
                          body: 'Are you sure you want to Delete this CV?',
                          actionButtonTitle: 'Delete',
                          onActionButtonPressed: () {
                            Navigator.of(context).pop();
                            profileCubit!.customUpdateToFirebase("cvUrl", "");
                          },
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete, color: AppColors.primaryBlue),
                )
              ],
            ),
    );
  }
}
