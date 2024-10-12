import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting


class ProfileEducationTextForm extends StatefulWidget {
  const ProfileEducationTextForm(
      {required this.hint,
      required this.icon,
      this.controller,
      this.isDateField = false,
      this.onDatePicked, // Add this parameter
      super.key});

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool isDateField;
  final ValueChanged<DateTime>? onDatePicked; // Add this to pass back the selected date

  @override
  State<ProfileEducationTextForm> createState() =>
      _ProfileEducationTextFormState();
}

class _ProfileEducationTextFormState extends State<ProfileEducationTextForm> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        widget.controller?.text = DateFormat('yyyy-MM-dd').format(picked); // Format the date
      });
      if (widget.onDatePicked != null) {
        widget.onDatePicked!(picked); // Pass the picked date back to the parent widget
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.headlineMedium,
      readOnly: widget.isDateField, // Make the field read-only if it's a date field
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter ${widget.hint}';
        } else if ((widget.hint == "Institution" ||
                widget.hint == "Degree" ||
                widget.hint == "FieldOfStudy") &&
            !RegExp(r'^[A-Z]').hasMatch(value)) {
          return "${widget.hint} must start with an uppercase letter";
        }
        return null;
      },
      decoration: InputDecoration(
        suffixIcon: widget.isDateField // If it's a date field, show an icon
            ? IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context),
              )
            : null,
        labelText: widget.hint,
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 13, 13, 38),
            fontSize: 14,
            fontWeight: FontWeight.w400),
        hintStyle: const TextStyle(
            color: Color.fromARGB(255, 175, 176, 182), fontSize: 14),
        prefixIcon: Icon(
          widget.icon,
          color: const Color.fromARGB(255, 175, 176, 182),
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 13, 13, 38), width: 1),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
    );
  }
}
