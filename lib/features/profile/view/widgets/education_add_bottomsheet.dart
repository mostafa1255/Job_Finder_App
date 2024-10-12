import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/profile/view/widgets/profile_education_text_form.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
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
    if (_formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  EducationAddBottomSheet(this.profileCubit, {super.key});

  // Helper method to handle setting DateTime
  void setDate(DateTime date, bool isStartDate) {
    if (isStartDate) {
      startDate = date;
      startDateController.text = DateFormat('yyyy-MM-dd').format(date);
    } else {
      endDate = date;
      endDateController.text = DateFormat('yyyy-MM-dd').format(date);
    }
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
        child: ListView(
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
              isDateField: true,
              onDatePicked: (date) => setDate(date, true), // Set startDate
            ),
            const SizedBox(height: 16),
            ProfileEducationTextForm(
              icon: Icons.date_range,
              controller: endDateController,
              hint: "End Date",
              isDateField: true,
              onDatePicked: (date) => setDate(date, false), // Set endDate
            ),
            const SizedBox(height: 16),
            StyledButton(
              onPressed: () {
                if (validation() && (startDate!.isBefore(endDate!)) ) {
                  profileCubit.addEducation(
                    Education(
                      institution: institutionController.text,
                      degree: degreeController.text,
                      fieldOfStudy: fieldOfStudyController.text,
                      startDate: startDate!,
                      endDate: endDate!,
                    ),
                  );
                  Navigator.pop(context);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Start Date must be before End Date'),
                    ),
                  );
                }
              },
              text: 'Add Education',
            ),
          ],
        ),
      ),
    );
  }
}
