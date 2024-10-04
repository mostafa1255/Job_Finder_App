import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/profile/view/widgets/logout_alert.dart';

void main() {
  runApp(const MaterialApp(
      home: Scaffold(
    body: Center(
      child: CustomLogoutAlert(),
    ),
  )));
}
