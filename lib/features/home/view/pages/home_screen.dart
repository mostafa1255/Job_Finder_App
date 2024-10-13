import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth/data/model/user_model.dart';
import '../../../profile/viewmodel/profile_cubit.dart';
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
  int _selectedIndex = 0;
  int index = 0;
  UserModel? user;
  PageController _pageController = PageController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
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

  Future<void> _fetchUserInfo() async {
    var fetchedUser = await BlocProvider.of<ProfileCubit>(context).getUserInfo();
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SAFE AREA
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(child: Container( height: 0.0,)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Welcome Back!', style: TextStyle(fontSize: 24)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.profileScreen);
                    },
                    child:CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        user?.profileImageUrl ?? 'https://picsum.photos/200/300',
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                  user?.name ??'John Lucas 👋',//take from fire base
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Featured Jobs',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.seeAllPage);
                    },
                    child:  Text('See all',
                      style: TextStyle(fontSize: 16, color: Colors.grey,),
                    ),

                  ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Recommended Jobs',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.seeAllPage);
                    },
                    child:  Text('See all',
                      style: TextStyle(fontSize: 16, color: Colors.grey,),
                    ),

                  ),


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
                              companyLogo: Image.network(jobs[index].imageUrl ?? ''),
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
      // bottomNavigationBar: BottomNavigation( ),

      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home,color: Colors.black,),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search,color: Colors.black,),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.add,color: Colors.black,),
      //         label: 'Post Job',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person,color: Colors.black,),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),//Custom widget for navigation

    );
  }
}
