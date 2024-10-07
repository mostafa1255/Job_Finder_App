import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jop_finder_app/core/utils/app_router.dart';
import 'package:jop_finder_app/features/auth/data/model/AppliedJob_model.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';

Widget buildApplyButton(
    {required PostedJob job, required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _applyForJob(context, job),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color(0xff2C557D),
        ),
        child: const Text(
          'Apply Now',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}

void _applyForJob(BuildContext context, PostedJob job) async {
  try {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in to apply for the job.")),
      );
      return;
    }

    AppliedJob appliedJob = AppliedJob(
      jobId: job.jobId,
      companyName: job.companyName,
      jobTitle: job.jobTitle,
      appliedDate: DateTime.now(),
      status: 'Pending',
      salary: job.salary,
      companyImageURL: job.imageUrl,
      location: job.location,
      jobType: 'Full Time',
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('appliedJobs')
        .doc(job.jobId)
        .set(appliedJob.toMap());

    await FirebaseFirestore.instance.collection('jobs').doc(job.jobId).update({
      'applicantIds': FieldValue.arrayUnion([userId]),
    });

    if (context.mounted) {
      GoRouter.of(context).push(AppRouter.successScreen);
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error applying for the job: $error")),
    );
  }
}
