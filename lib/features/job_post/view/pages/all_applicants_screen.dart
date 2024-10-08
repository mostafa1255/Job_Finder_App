import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllApplicantsScreen extends StatelessWidget {
  final String jobId;

  const AllApplicantsScreen({super.key, required this.jobId});

  Future<List<Map<String, dynamic>>> _fetchApplicants() async {
    DocumentSnapshot jobSnapshot = await FirebaseFirestore.instance
        .collection('jobs')
        .doc(jobId)
        .get();

    List<String> applicantIds = jobSnapshot.get('applicantIds');

    List<Map<String, dynamic>> applicants = [];
    for (var userId in applicantIds) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      applicants.add(userSnapshot.data() as Map<String, dynamic>);
    }

    return applicants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Applicants"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchApplicants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No applicants found"));
          } else {
            final applicants = snapshot.data!;
            return ListView.builder(
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                final applicant = applicants[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(applicant['profileImageURL'] ?? ''),
                      child: applicant['profileImageURL'] == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(applicant['name'] ?? 'No Name'),
                    subtitle: Text(applicant['email'] ?? 'No Email'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
