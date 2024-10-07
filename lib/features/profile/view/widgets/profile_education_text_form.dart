import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class ProfileEducationTextForm extends StatefulWidget {
  const ProfileEducationTextForm(
      {required this.hint, required this.icon, this.controller,this.isDateField=false, super.key});

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool isDateField;

  @override
  State<ProfileEducationTextForm> createState() => _ProfileEducationTextFormState();
}

class _ProfileEducationTextFormState extends State<ProfileEducationTextForm> {
  final _formKey = GlobalKey<FormState>();

   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      widget.controller?.text = DateFormat('y/M/d').format(picked); // Format the date
    }
  }

  void validation() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller!.text.isNotEmpty ? widget.controller : null,
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
                icon: Icon(Icons.calendar_today),
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
        focusColor: const Color.fromARGB(255, 13, 13, 38),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 13, 13, 38), width: 1),
        ),
        suffixIcon: const SizedBox(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      ),
    );
  }
}
