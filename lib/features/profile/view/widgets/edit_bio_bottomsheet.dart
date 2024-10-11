//i need to make a custom bottom sheet just have one StyledTextfield from the shared file ine the auth folder and have a hint to "Enter your bio" and a button to save the bio when i click on the button it call the method in the cubit to update the bio in the firestore and close the bottom sheet

import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class EditBioBottomSheet extends StatelessWidget {
  final TextEditingController bioController = TextEditingController();
  final ProfileCubit profileCubit;
  EditBioBottomSheet(this.profileCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StyledTextField(
            icon: Icons.info,
            controller: bioController,
            hint: "Enter your new bio",
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: StyledButton(
              text: "Save Changes",
              onPressed: () {
                //i need to check if the bioController is not empty
                if (bioController.text.isNotEmpty) {
                  profileCubit.updateBio(bioController.text);
                  Navigator.pop(context);
                } else {
                  //i need to show a snackbar with a message "Bio can't be empty"
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bio can't be empty"),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
