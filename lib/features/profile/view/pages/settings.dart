// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/core/constants/strings.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/view/widgets/change_email_dialog.dart';
import 'package:jop_finder_app/features/profile/view/widgets/change_password_dialog.dart';
import 'package:jop_finder_app/features/profile/view/widgets/change_status_bottomsheet.dart';
import 'package:jop_finder_app/features/profile/view/widgets/custom_alert.dart.dart';
import 'package:jop_finder_app/features/profile/view/widgets/delete_acc_dialog.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProfileCubit? profileCubit;
  UserModel? user;


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
          title: Text(
            "Settings",
          ),
        ),
        body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is SignedOut || state is AccountDeleted) {
            GoRouter.of(context).pushReplacementNamed(AppRouter.login);
          }
        },
        child: SafeArea(child: buildBlock()),
      )
      );
  }

  Widget buildBlock() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          return buildSettingsScreen(); 
        } else if (state is UserUpdated) {
          return buildSettingsScreen();
        } else if (state is ProfileError) {
          return Center(child: Text(state.errorMessage));
        } else if (state is PasswordChanged) {
          return Center(child: Text('Password changed successfully'));
        } else {
          return Center(child: Text('Error occurred'));
        }
      },
    );
  }

  Widget buildSettingsScreen() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
      children: [
        buildSectionTitle('Applications'),
        buildListItem(Icons.visibility, 'Profile Status', onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) =>
                StatusUpdateBottomSheet(profileCubit: profileCubit!),
          );
        }),
        buildListItem(Icons.lock, 'Change Password', onTap: () {
          showDialog(
            context: context,
            builder: (context) => ChangePasswordDialog(profileCubit!),
          );
        }),
        buildListItem(Icons.email, 'Change E-mail', onTap: () {
          showDialog(
            context: context,
            builder: (context) => ChangeEmailDialog(profileCubit!),
          );
        }),
        buildListItem(Icons.logout, 'Logout', onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Logout',
                body: 'Are you sure you want to logout ?',
                actionButtonTitle: 'Logout',
                onActionButtonPressed: () {
                  Navigator.of(context).pop();
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    profileCubit!.signOut();
                  });
                },
              );
            },
          );
        }),
        buildListItem(Icons.delete, 'Delete Account', color: Colors.red,
            onTap: () {
          showDialog(
            context: context,
            builder: (context) => DeleteAccountDialog(profileCubit!),
          );
        }),
        SizedBox(height: 20),
        buildSectionTitle('About'),
        buildListItem(Icons.privacy_tip, 'Privacy', onTap: () {
          showPrivacyDialog(context);
        }),
        buildListItem(Icons.description, 'Terms and conditions', onTap: () {
          showTermsDialog(context);
        }),
        buildListItem(Icons.info, 'About', onTap: () {
          showAboutDialog(context);
        }),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  ListTile buildListItem(IconData icon, String title,
      {Color color = AppColors.primaryBlue, required Function onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: (title == 'Delete Account')
            ? TextStyle(color: color)
            : (Theme.of(context).textTheme.displayMedium),
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
        onActionButtonPressed: () {
          Navigator.of(context).pop();
        },
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
        onActionButtonPressed: () {
          Navigator.of(context).pop();
        },
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
        onActionButtonPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
