//i need to make a custom bottom sheet just have one StyledTextfield from the shared file ine the auth folder and have a hint to "Enter your bio" and a button to save the bio when i click on the button it call the method in the cubit to update the bio in the firestore and close the bottom sheet

import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class ChangeEmailDialog extends StatelessWidget {
  final TextEditingController currentEmailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final ProfileCubit profileCubit;
  ChangeEmailDialog(this.profileCubit, {super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validation() {
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Container(

          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StyledTextField(
                icon: Icons.email,
                controller: currentEmailController,
                hint: "E-mail",
              ),
              const SizedBox(height: 16),
              StyledTextField(
                icon: Icons.lock,
                controller: currentPasswordController,
                hint: "Password",
                isPassword: true, // Assuming StyledTextField supports a isPassword flag
              ),
              const SizedBox(height: 16),
               const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Divider( color: Colors.grey,),
                    Text("New Email", style: TextStyle(color: Colors.grey,fontSize: 12),),
                    Divider( color: Colors.grey,),
                 ],
               ),
               const SizedBox(height: 16),
              StyledTextField(
                icon: Icons.email,
                controller: newEmailController,
                hint: "E-mail",
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: StyledButton(
                  text: "Save Changes",
                  onPressed: () {
                    if (validation()) {
                     profileCubit.updateEmail(currentEmailController.text, currentPasswordController.text, newEmailController.text);
                      Navigator.of(context).pop();
                     ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Email updated successfully"),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}