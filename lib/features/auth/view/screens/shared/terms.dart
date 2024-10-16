import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jop_finder_app/core/constants/strings.dart';
import 'package:jop_finder_app/features/home/view/pages/home_screen.dart';
import 'package:jop_finder_app/features/profile/view/widgets/custom_alert.dart.dart';

void showTermsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => CustomAlertDialog(
      title: 'Terms and Conditions',
      body: AppStrings.termsAndConditions,
      actionButtonTitle: 'Done',
      onActionButtonPressed: () {
        Navigator.of(context).pop();
      },
    ),
  );
}

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "By clicking Register, you agree to our",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: () {
            showTermsDialog(context);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            ' Terms and conditions',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
