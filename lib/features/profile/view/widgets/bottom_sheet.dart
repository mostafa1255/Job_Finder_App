import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart'; // Ensure correct path
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';

class CustomBottomSheet extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          StyledTextField(
            controller: nameController,
            hint: 'New Name', // Corrected from hintText to hint
            icon: Icons.person, // Example icon, adjust as needed
          ),
          const SizedBox(height: 16),
          StyledTextField(
            controller: phoneNumberController,
            hint: 'New Phone Number', // Corrected from hintText to hint
            icon: Icons.phone, // Example icon, adjust as needed
          ),
          const SizedBox(height: 16),
          StyledTextField(
            controller: emailController,
            hint: 'New Email', // Corrected from hintText to hint
            icon: Icons.email, // Example icon, adjust as needed
          ),
          const SizedBox(height: 16),
          StyledButton(
            onPressed: () {
              // Implement the logic to save updates, e.g., to Firebase
             
              // Example: Save newName, newPhoneNumber, and newEmail to Firebase
            },
            text:
                'Save Changes', // Assuming StyledButton requires a text parameter
          ),
        ],
      ),
    );
  }
}

