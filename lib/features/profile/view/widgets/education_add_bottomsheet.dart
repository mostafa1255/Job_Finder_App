import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:jop_finder_app/features/auth/view/screens/shared/styled_button.dart';
import 'package:jop_finder_app/features/profile/view/widgets/profile_education_text_form.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

// ignore: must_be_immutable
class EducationAddDialog extends StatefulWidget {
  final ProfileCubit profileCubit;

  const EducationAddDialog(this.profileCubit, {super.key});

  @override
  State<EducationAddDialog> createState() =>
      _EducationAddDialogState();
}

class _EducationAddDialogState extends State<EducationAddDialog> {
  final TextEditingController institutionController = TextEditingController();

  final TextEditingController degreeController = TextEditingController();

  final TextEditingController fieldOfStudyController = TextEditingController();

  final TextEditingController startDateController = TextEditingController();

  final TextEditingController endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  DateTime? startDate;

  DateTime? endDate;
  bool showError = false;

  bool validation() {
    return _formKey.currentState?.validate() ?? false;
  }

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
    return Dialog(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(18),
          child: ListView(
            shrinkWrap: true, // Allow the bottom sheet to resize
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
                onDatePicked: (date) => setDate(date, true),
              ),
              const SizedBox(height: 16),
              ProfileEducationTextForm(
                icon: Icons.date_range,
                controller: endDateController,
                hint: "End Date",
                isDateField: true,
                onDatePicked: (date) => setDate(date, false),
              ),
              if (showError)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Start Date must be before End Date',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 16),
              StyledButton(
                onPressed: () {
                  if (validation() && (startDate!.isBefore(endDate!))) {
                     widget.profileCubit.addEducation(
                      Education(
                        institution: institutionController.text,
                        degree: degreeController.text,
                        fieldOfStudy: fieldOfStudyController.text,
                        startDate: startDate!,
                        endDate: endDate!,
                      ),
                    );
                    Navigator.pop(context);
                    showError = false; // Reset error state
                  } else {
                    setState(() {
                      showError = true; // Show error message
                    });
                  }
                },
                text: 'Add Education',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
