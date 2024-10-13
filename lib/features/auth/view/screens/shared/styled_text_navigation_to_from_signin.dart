import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';

class StyledTextNavigationToFromSignin extends StatelessWidget {
  const StyledTextNavigationToFromSignin({
    required this.headText,
    required this.tailText,
    super.key,
  });

  final String headText;
  final String tailText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(
            headText,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        TextButton(
          onPressed: () {
            // Navigate to register screen
            if (tailText == 'Register') {
              GoRouter.of(context).pushReplacementNamed(AppRouter.signUp);
            } else {
              GoRouter.of(context).pushReplacementNamed(AppRouter.login);
            }
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            tailText,
            style: const TextStyle(
              color: AppColors.mainColor,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
