// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/auth/data/model/AppliedJob_model.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  Stream<List<AppliedJob>> getAppliedJobs() {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection("appliedJobs")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => AppliedJob.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applications'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<AppliedJob>>(
          stream: getAppliedJobs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
                    const SizedBox(height: 16),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.work_off, size: 60, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No jobs Applied yet',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              );
            } else {
              final appliedJobs = snapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: appliedJobs.length,
                itemBuilder: (context, index) {
                  return ApplicationCard(appliedJob: appliedJobs[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class ApplicationCard extends StatelessWidget {
  final AppliedJob appliedJob;
  const ApplicationCard({super.key, required this.appliedJob});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
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
                    if (appliedJob.companyImageURL != null)
                      CircleAvatar(
                        radius: 35,
                        foregroundImage:
                            NetworkImage(appliedJob.companyImageURL!),
                      )
                    else
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.work, color: Colors.grey),
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
                  child: Text('\$ ${appliedJob.salary ?? 'No salary'}',
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
                        color: getStatusColor(appliedJob.status), width: 1),
                  ),
                  child: Text(
                    appliedJob.status ?? 'no status',
                    style: TextStyle(
                      color: getStatusColor(appliedJob.status),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String? status) {
    switch (status) {
      case "Canceled":
        return Colors.red;
      case "Pending":
        return Colors.orange;
      case "Accepted":
        return Colors.green;
      default:
        return Colors.grey; // Default color if status is unknown
    }
  }
}
