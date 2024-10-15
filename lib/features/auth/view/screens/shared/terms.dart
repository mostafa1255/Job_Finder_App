import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/constants/strings.dart';
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
        const Text(
          "By clicking Register, you agree our",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
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
        )
      ],
    );
  }
}
