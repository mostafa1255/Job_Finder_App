// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/auth/data/model/AppliedJob_model.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/profile/viewmodel/profile_cubit.dart';

class ApplicationsScreen extends StatefulWidget {
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  User? user;
  ProfileCubit? profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = BlocProvider.of<ProfileCubit>(context);
    // Schedule the asynchronous operation to fetch user information
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserInfo();
    });
  }

  Future<void> _fetchUserInfo() async {
    // Fetch user information from Firestore using the cubit method
    var fetchedUser =
        await BlocProvider.of<ProfileCubit>(context).getUserInfo();
    if (mounted) {
      setState(() {
        user = fetchedUser;
      });
    }
  }

  Widget buildBlock() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          user = state.user;
          return buildApplicationsScreen();
        } else if (state is ProfileError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Center(child: Text('Error occurred'));
        }
      },
    );
  }

  Widget buildApplicationsScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'You have ${user?.appliedJobs?.length ?? 0} Applications',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: user!.appliedJobs!.length,
              itemBuilder: (context, index) {
                return ApplicationCard(appliedJob: user!.appliedJobs![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Applications'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            if (user != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user!.profileImageUrl!),
              ),
            SizedBox(width: 10),
          ],
        ),
        body: buildBlock());
  }
}

class ApplicationCard extends StatelessWidget {
  final AppliedJob appliedJob;

  const ApplicationCard({super.key, required this.appliedJob});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      foregroundImage: NetworkImage(
                        appliedJob.companyImageURL ??
                            'https://picsum.photos/200/300', // Replace with actual company logo URL
                      ),
                    ),
                    SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appliedJob.jobTitle ?? 'No Title',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text( 
                          appliedJob.companyName ?? 'No Company',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.only(left: 4),
                  child: Text(appliedJob.salary ?? 'No salary',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 16), 
                      child: Text(appliedJob.jobType ?? 'No Type',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(height: 4),
                    Text(appliedJob.location ?? 'No Location',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 34),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: appliedJob.status == "Canceled"
                            ? Colors.red
                            : Colors.green,
                        width: 1),
                  ),
                  child: Text(
                    appliedJob.status ?? 'no status',
                    style: TextStyle(
                        color: appliedJob.status == "Canceled"
                            ? Colors.red
                            : Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
