import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedJobsCard extends StatelessWidget {
  final String company;
  final String title;
  final String salary;
  final Color color;
  final String companyLogo;

  const RecommendedJobsCard({
    super.key,
    required this.company,
    required this.title,
    required this.salary,
    required this.color,
    required this.companyLogo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Container(
        width: 180.w,
        constraints: BoxConstraints(maxHeight: 280.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -20.h,
              right: -20.w,
              child: CircleAvatar(
                radius: 50.r,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Uri.parse(companyLogo).hasAbsolutePath
                          ? CachedNetworkImage(
                              imageUrl: companyLogo,
                              fit: BoxFit.cover,
                              width: 60.w,
                              height: 60.h,
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      CircularProgressIndicator(
                                value: progress.progress,
                                strokeWidth: 2.w,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error, size: 25.sp),
                            )
                          : Icon(Icons.business, size: 30.sp, color: color),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    company,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '${salary}\$ / month',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
