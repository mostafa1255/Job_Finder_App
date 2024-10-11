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

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key});

  @override
  State<SeeAllPage> createState() => _SeeAllPage();
}

class _SeeAllPage extends State<SeeAllPage> {
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
      appBar: AppBar(
        title: const Text('Featured Jobs'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(AppRouter.profileScreen);
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: Container(height: 0.0)),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  GoRouter.of(context).push(AppRouter.jobSearchScreen);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
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
                      height: 570.h,
                      child: ListView.builder(
                        itemCount: jobs.length,
                        scrollDirection: Axis.vertical,

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
            ],
          ),
        ),
      ),
    );
  }
}