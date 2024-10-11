//i need to make a custom bottom sheet just have one StyledTextfield from the shared file ine the auth folder and have a hint to "Enter your bio" and a button to save the bio when i click on the button it call the method in the cubit to update the bio in the firestore and close the bottom sheet

import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final ProfileCubit profileCubit;
  ChangePasswordBottomSheet(this.profileCubit, {super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validation() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
              icon: Icons.lock,
              controller: passwordController,
              hint: "Password",
              isPassword: true,
            ),
            const SizedBox(height: 16),
            StyledTextField(
              icon: Icons.lock,
              controller: confirmPasswordController,
              hint: "Confirm Password",
              isPassword: true,
              password: passwordController,  
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: StyledButton(
                text: "Save Changes",
                onPressed: () {
                  if (validation()) {
                    profileCubit.changeUserPassword(passwordController.text);
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password Updated Successfully"),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}