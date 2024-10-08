// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart'; // Ensure correct path
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class EditInfoBottomSheet extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ProfileCubit profileCubit;
  final User? user ;
  EditInfoBottomSheet(this.profileCubit, this.user, {super.key});

  bool isNameValid() {
    if (nameController.text.contains(' ') &&
        nameController.text[0] == nameController.text[0].toUpperCase() &&
        nameController.text[nameController.text.indexOf(' ') + 1] ==
            nameController.text[nameController.text.indexOf(' ') + 1]
                .toUpperCase()) {
      return true;
    }
    return false;
  }

  bool isPhoneNumberValid() {
    if (phoneNumberController.text.length == 11&&
        phoneNumberController.text[0] == '0' &&
        phoneNumberController.text[1] == '1') {
      return true;
    }
    return false;
  }

  bool isEmailValid() {
    if (emailController.text.contains('@') &&
        emailController.text.contains('.com')) {
      return true;
    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EditInfoTextFiled(
            initialText: user!.name,
            controller: nameController,
            hint: "Full Name", // Corrected from hintText to hint
            icon: Icons.person, // Example icon, adjust as needed
          ),
          EditInfoTextFiled(
            initialText: user!.phoneNumber??'',
            controller: phoneNumberController,
            hint: 'Phone Number', // Corrected from hintText to hint
            icon: Icons.phone, // Example icon, adjust as needed
          ),
          EditInfoTextFiled(
            initialText: user!.email,
            controller: emailController,
            hint: "E-mail", // Corrected from hintText to hint
            icon: Icons.email, // Example icon, adjust as needed
          ),
          SizedBox(height: 16),
          Container(
            width: double.infinity,
            child: StyledButton(
              onPressed: () {
                if (nameController.text.isNotEmpty ||
                    phoneNumberController.text.isNotEmpty ||
                    emailController.text.isNotEmpty) {
                      if ( isNameValid() ) {
                        profileCubit.customUpdateToFirebase('name', nameController.text);
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Name is not valid"),
                          ),
                        );
                      }
                      if ( isPhoneNumberValid() ) {
                        profileCubit.customUpdateToFirebase('phoneNumber', phoneNumberController.text);
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Phone number is not valid"),
                          ),
                        );
                      }
                      if ( isEmailValid() ) {
                        profileCubit.customUpdateToFirebase('email', emailController.text);
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Email is not valid"),
                          ),
                        );
                      }
                  
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Fields can't be empty"),
                    ),
                  );
                }
              },
              text:
                  'Save Changes', // Assuming StyledButton requires a text parameter
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class EditInfoTextFiled extends StatelessWidget {
  final String initialText;
  final IconData icon;
  final TextEditingController controller;
  final String hint;

  const EditInfoTextFiled({
    super.key,
    required this.initialText,
    required this.icon,
    required this.controller,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the user's name
    controller.text = initialText;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0,),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 13, 13, 38),
              fontSize: 14,
              fontWeight: FontWeight.w400),
          hintStyle: const TextStyle(
              color: Color.fromARGB(255, 175, 176, 182), fontSize: 14),
          prefixIcon: Icon(
            icon,
            color: MyColor.primaryBlue,
            size: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 175, 176, 182), width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(102, 175, 176, 182),
            ),
          ),
          focusColor: const Color.fromARGB(255, 13, 13, 38),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 13, 13, 38), width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 20.0),
        ),
        controller: controller, // Use the passed controller
        maxLines: 1,
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}