import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required IconData icon,
  int maxLines = 1,
}) {
  return TextFormField(
    style: const TextStyle(color: AppColors.primaryText),
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue, width: 1),
      ),
      filled: true,
      fillColor: Colors.white,
      errorStyle: const TextStyle(color: Colors.red),
    ),
    maxLines: maxLines,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $label';
      }
      return null;
    },
  );
}
