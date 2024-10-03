import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/profile/view/widgets/info_display.dart';


void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      body: CustomInfoDisplay(text: '01204052152',icon: Icons.phone_android_outlined,),
    ),
  ));
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:  Expanded (
        child: ListTile (
          title: Text(
            'Email',
            style: TextStyle(color: Colors.grey),
          ),
          subtitle: Text(
            'user.email',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
