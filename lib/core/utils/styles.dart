import 'dart:ui';

import 'package:jop_finder_app/core/constants/app_colors.dart';

abstract class AppTextStyles {
  static  TextStyle primaryTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 22,
    color: AppColors.primaryText,
    fontWeight: FontWeight.w600,
  );

  static TextStyle secondaryTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    color: AppColors.secondaryText,
    fontWeight: FontWeight.w500,
  );

  static TextStyle subTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.subText,
    fontWeight: FontWeight.w400,
  );
}

