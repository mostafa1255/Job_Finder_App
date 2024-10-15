import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import 'job_card.dart';
import 'recommended_jops_card.dart';

const String userTokenKey = 'userToken';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? user;
  List<PostedJob> allJobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    saveUserToken();
    _fetchUserInfo();
    _fetchAllJobs();
  }

  Future<void> _fetchUserInfo() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          user = UserModel.fromFirestore(userDoc);
        });
      } else {
        print('User not found');
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
  }

  void saveUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userTokenKey, FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> _fetchAllJobs() async {
    try {
      final jobsSnapshot =
          await FirebaseFirestore.instance.collection('allJobs').get();

      setState(() {
        allJobs = jobsSnapshot.docs
            .map((jobDoc) => PostedJob.fromMap(jobDoc.data()))
            .toList();
        isLoading = false; // Set loading to false once data is fetched
      });
    } catch (e) {
      print('Error fetching jobs: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
<<<<<<< HEAD
                        Text(
                          'Welcome Back! 👋',
=======
                        const Text(
                          'Welcome Back!',
>>>>>>> 04bb0c29da68465165ddfd5035ff06f29a5a9014
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(149, 150, 157, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
<<<<<<< HEAD
=======
                        Text("${user?.name}👋" ?? 'John Lucas 👋',
                            style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryText)),
>>>>>>> 04bb0c29da68465165ddfd5035ff06f29a5a9014
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.profileScreen);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.shade200,
                        child: ClipOval(
                          child: Uri.parse(user?.profileImageUrl ?? "")
                                  .hasAbsolutePath
                              ? CachedNetworkImage(
                                  imageUrl: user!.profileImageUrl!,
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Center(
                                    child: Icon(Icons.error),
                                  ),
                                )
                              : const Icon(Icons.person),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.jobSearchScreen);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10.w),
                        const Expanded(
                          child: Text(
                            'Search for jobs...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                _buildJobSection(
                    'Featured Jobs', allJobs, AppColors.primaryText),
                SizedBox(height: 40.h),
                _buildJobSection(
                    'Recommended Jobs', allJobs, AppColors.primaryText),
              ],
            ),
          ),
        ),
      ),
      // BottomNavigationBar for navigation if needed
    );
  }

  Widget _buildJobSection(String title, List<PostedJob> jobs, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).push(AppRouter.seeAllPage);
              },
              child: Text(
                'See all',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : (jobs.isEmpty
                ? const Center(child: Text('No jobs available'))
                : SizedBox(
                    height: title == 'Featured Jobs' ? 200.h : 230.h,
                    child: ListView.builder(
                      itemCount: jobs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(AppRouter.jobApplyScreen,
                                extra: jobs[index]);
                          },
                          child: title == 'Featured Jobs'
                              ? JobCard(
                                  company: jobs[index].companyName ?? '',
                                  title: jobs[index].jobTitle ?? '',
                                  salary: jobs[index].salary ?? '',
                                  location: jobs[index].location ?? '',
                                  tags: jobs[index].jobTags ?? [],
                                  color: Colors.blue,
                                )
                              : RecommendedJobsCard(
                                  company: jobs[index].companyName ?? '',
                                  title: jobs[index].jobTitle ?? '',
                                  salary: jobs[index].salary ?? '',
                                  color: Colors.pinkAccent,
                                  companyLogo: jobs[index].imageUrl ?? '',
                                ),
                        );
                      },
                    ),
                  )),
      ],
    );
  }
}
