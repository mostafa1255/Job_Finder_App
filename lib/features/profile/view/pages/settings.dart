// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/strings.dart';
import 'package:jop_finder_app/features/profile/view/widgets/change_email_bottomsheet.dart';
import 'package:jop_finder_app/features/profile/view/widgets/change_password_bottomsheet.dart';
import 'package:jop_finder_app/features/profile/view/widgets/change_status_bottomsheet.dart';
import 'package:jop_finder_app/features/profile/view/widgets/custom_alert.dart.dart';
import 'package:jop_finder_app/features/profile/view/widgets/delete_acc_bottm_sheet.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  ProfileCubit? profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
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
        } else if (state is AccountDeleted) {
          GoRouter.of(context).pushReplacementNamed('/login');
          return Center();
        } else {
          return Center(child: Text('Error occurred'));
        }
      },
    );
  }

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
        body: buildBlock());
  }

  Widget buildSettingsScreen() {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      children: [
        buildSectionTitle('Applications'),
        buildListItem(Icons.visibility_outlined, 'Profile Status', onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) =>
                StatusUpdateBottomSheet(profileCubit: profileCubit!),
          );
        }),
        // buildListItem(Icons.color_lens_outlined, 'Notifications'),
        buildListItem(Icons.lock_outline, 'Change Password', onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ChangePasswordBottomSheet(profileCubit!),
          );
        }),
        buildListItem(Icons.email_outlined, 'Change E-mail', onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => ChangeEmailBottomSheet(profileCubit!),
          );
        }),
        // buildListItem(Icons.color_lens_outlined, 'Theme'),
        buildListItem(Icons.delete_outline, 'Delete Account', color: Colors.red,
            onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => DeleteAccountBottomSheet(profileCubit!),
          );
        }),
        SizedBox(height: 20),
        buildSectionTitle('About'),
        buildListItem(Icons.privacy_tip_outlined, 'Privacy', onTap: () {
          showPrivacyDialog(context);
        }),
        buildListItem(Icons.description_outlined, 'Terms and conditions',
            onTap: () {
          showTermsDialog(context);
        }),
        buildListItem(Icons.info_outline, 'About', onTap: () {
          showAboutDialog(context);
        }),
      ],
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 18),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  ListTile buildListItem(IconData icon, String title,
      {Color color = Colors.black, required Function onTap}) {
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
