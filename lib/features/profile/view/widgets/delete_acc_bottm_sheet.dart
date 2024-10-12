// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class DeleteAccountDialog extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // Assuming you have a ProfileCubit or similar for handling the delete action
  final ProfileCubit profileCubit;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DeleteAccountDialog(this.profileCubit, {super.key});

  bool validate() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              StyledTextField(
                icon: Icons.email_outlined,
                controller: emailController,
                hint: "E-mail",
              ),
              const SizedBox(height: 16),
              StyledTextField(
                icon: Icons.lock_outline,
                controller: passwordController,
                hint: "Password",
                isPassword: true, // Assuming StyledTextField supports a isPassword flag
              ),
              const SizedBox(height: 16),
              ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              if (validate()) {
                 profileCubit.reauthenticateAndDeleteUser(emailController.text, passwordController.text);
                Navigator.pop(context);
              }              
              
            }, // add your save function here
            child: const SizedBox(
                width: double.infinity,
                height: 50,
                child: Center(
                    child: Text(
                  'Delete Account',
                  style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ))),
          ),
            ],
          ),
        ),
      ),
    );
  }
}