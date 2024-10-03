import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';

class CustomInfoDisplay extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomInfoDisplay({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 175, 176, 182), width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey,size: 30,),
          const SizedBox(width: 10),
          Text(
            selectionColor: MyColor.primaryBlue,
            text,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CustomInfoTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;

  const CustomInfoTile({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap?.call();
      },
      leading: Icon(icon, color: MyColor.primaryBlue),
      title: Text(
        text,
        style: const TextStyle(color: MyColor.primaryBlue, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
            color: Color.fromARGB(255, 175, 176, 182), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
