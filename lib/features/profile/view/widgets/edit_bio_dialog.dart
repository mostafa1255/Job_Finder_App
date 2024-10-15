import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_textField.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class EditBioDialog extends StatelessWidget {
  final TextEditingController bioController = TextEditingController();
  final ProfileCubit profileCubit;
  EditBioDialog(this.profileCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                  if (bioController.text.isNotEmpty) {
                    profileCubit.updateBio(bioController.text);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
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
      ),
    );
  }
}
