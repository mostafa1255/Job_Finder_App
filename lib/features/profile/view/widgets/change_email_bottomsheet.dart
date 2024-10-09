//i need to make a custom bottom sheet just have one StyledTextfield from the shared file ine the auth folder and have a hint to "Enter your bio" and a button to save the bio when i click on the button it call the method in the cubit to update the bio in the firestore and close the bottom sheet

import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class ChangeEmailBottomSheet extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final ProfileCubit profileCubit;
  ChangeEmailBottomSheet(this.profileCubit, {super.key});
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
              icon: Icons.email,
              controller: emailController,
              hint: "E-mail",
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: StyledButton(
                text: "Save Changes",
                onPressed: () {
                  if (validation()) {
                   profileCubit.updateEmailIfVerified(emailController.text);
                    Navigator.of(context).pop();
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Verification email sent"),
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