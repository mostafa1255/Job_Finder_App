import 'package:flutter/material.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';

class CustomInfoDisplay extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomInfoDisplay({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: AppColors.primaryBlue,
            size: 30,
          ),
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}

class CustomBioDisplay extends StatelessWidget {
  final String text;

  const CustomBioDisplay({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.info,
            color: AppColors.primaryBlue,
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
