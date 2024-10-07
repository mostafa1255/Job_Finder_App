import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/profile/view/widgets/profile_education_text_form.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class EducationAddBottomSheet extends StatelessWidget {
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController fieldOfStudyController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final ProfileCubit profileCubit;
  final _formKey = GlobalKey<FormState>();
  DateTime? startDate;
  DateTime? endDate;

  bool validation() {
    if (_formKey.currentState!.validate()&&startDate != null &&
        endDate != null) {
      return true;
    }
    return false;
  }

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      if (isStartDate) {
        startDate = picked;
      } else {
        endDate = picked;
      }
    }
  }

  EducationAddBottomSheet(this.profileCubit, {super.key});

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
            ProfileEducationTextForm(
              icon: Icons.school,
              controller: institutionController,
              hint: "Institution",
            ),
            const SizedBox(height: 16),
            ProfileEducationTextForm(
              icon: Icons.school,
              controller: degreeController,
              hint: "Degree",
            ),
            const SizedBox(height: 16),
            ProfileEducationTextForm(
              icon: Icons.school,
              controller: fieldOfStudyController,
              hint: "FieldOfStudy",
            ),
            const SizedBox(height: 16),
            ProfileEducationTextForm(
              icon: Icons.date_range,
              controller: startDateController,
              hint: "Start Date",
              
            ),
            const SizedBox(height: 16),
            ProfileEducationTextForm(
              icon: Icons.date_range,
              controller: endDateController,
              hint: "End Date",
              isDateField: true,
            ),
            const SizedBox(height: 16),
            StyledButton(
              onPressed: () {
                if (validation()) {
                  profileCubit.updateEducation(
                    Education(
                      institution: institutionController.text,
                      degree: degreeController.text,
                      fieldOfStudy: fieldOfStudyController.text,
                      startDate: startDate!,
                      endDate: endDate!,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("All fields are required"),
                    ),
                  );
                }
              },
              text: 'Save Changes',
            ),
          ],
        ),
      ),
    );
  }
}
