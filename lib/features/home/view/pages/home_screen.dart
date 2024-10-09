import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recommended_jops_card.dart';
import 'job_card.dart';
import 'bottom_navigation.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';

const String userTokenKey = 'userToken';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    saveUserToken();
    super.initState();
  }

  void saveUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userTokenKey, FirebaseAuth.instance.currentUser!.uid);
  }

  Future<List<PostedJob>> fetchJobs() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('jobs').get();
    return querySnapshot.docs
        .map((doc) => PostedJob.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Welcome Back!', style: TextStyle(fontSize: 24)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.profileScreen);
                    },
                    child:const CircleAvatar(
                      radius: 20,
                    ),
                  ),
                ],
              ),
              const Text('John Lucas 👋',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Featured Jobs',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('See all',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<PostedJob>>(
                future: fetchJobs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No jobs available'));
                  } else {
                    List<PostedJob> jobs = snapshot.data!;
                    return SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        itemCount: jobs.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                  AppRouter.jobApplyScreen,
                                  extra: jobs[index]);
                            },
                            child: JobCard(
                              company: jobs[index].companyName ?? '',
                              title: jobs[index].jobTitle ?? '',
                              salary: jobs[index].salary ?? '',
                              location: jobs[index].location ?? '',
                              tags: jobs[index].jobTags ?? [],
                              color: Colors.blue,
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 40.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recommended Jobs',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('See all',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              SizedBox(height: 20.h),
              FutureBuilder<List<PostedJob>>(
                future: fetchJobs(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No jobs available'));
                  } else {
                    List<PostedJob> jobs = snapshot.data!;
                    return SizedBox(
                      height: 230.h,
                      child: ListView.builder(
                        itemCount: jobs.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                  AppRouter.jobApplyScreen,
                                  extra: jobs[index]);
                            },
                            child: RecommendedJopsCard(
                              company: jobs[index].companyName ?? '',
                              title: jobs[index].jobTitle ?? '',
                              salary: jobs[index].salary ?? '',
                              color: Colors.pinkAccent,
                              companyLogo: jobs[index].imageUrl ?? '',
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:const BottomNavigation(), // Custom widget for navigation
    );
  }
}
