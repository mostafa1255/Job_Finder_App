import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jop_finder_app/core/constants/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AllApplicantsScreen extends StatelessWidget {
  final String jobId;

  const AllApplicantsScreen({super.key, required this.jobId});

  Future<List<Map<String, dynamic>>> _fetchApplicants() async {
    DocumentSnapshot jobSnapshot =
        await FirebaseFirestore.instance.collection('allJobs').doc(jobId).get();

    if (!jobSnapshot.exists) {
      print('Job document does not exist!');
      return [];
    }

    List<String> applicantIds;
    try {
      applicantIds = List<String>.from(jobSnapshot.get('applicantIds'));
    } catch (e) {
      print('Error fetching applicantIds: $e');
      return [];
    }

    print('Applicant IDs: $applicantIds');

    List<Map<String, dynamic>> applicants = [];
    for (var userId in applicantIds) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        applicants.add(userSnapshot.data() as Map<String, dynamic>);
      } else {
        print('User document for $userId does not exist');
      }
    }

    return applicants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBlue,
        title: const Text(
          "All Applicants",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchApplicants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No applicants yet!",
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          } else {
            final applicants = snapshot.data!;
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: applicants.length,
              itemBuilder: (context, index) {
                final applicant = applicants[index];
                return ApplicantCard(applicant: applicant);
              },
            );
          }
        },
      ),
    );
  }
}

class ApplicantCard extends StatelessWidget {
  final Map<String, dynamic> applicant;

  const ApplicantCard({super.key, required this.applicant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 53, 104, 153),
                  radius: 30,
                  backgroundImage: Uri.parse(applicant["profileImageUrl"] ?? "")
                          .hasAbsolutePath
                      ? CachedNetworkImageProvider(applicant["profileImageUrl"])
                      : null,
                  child: Uri.parse(applicant["profileImageUrl"] ?? "")
                          .hasAbsolutePath
                      ? null
                      : Icon(Icons.person, size: 30, color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        applicant['name'] ?? 'No Name',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        applicant['email'] ?? 'No Email',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              applicant['skills'] == null ? '' : 'Skills:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (applicant['skills'] as List<dynamic>? ?? [])
                  .map((skill) => Chip(
                        label: Text(skill),
                        backgroundColor: Colors.blue[100],
                        labelStyle: TextStyle(color: Colors.blue[800]),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Contact Information'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Email: ${applicant['email'] ?? 'Not provided'}'),
                            SizedBox(height: 8),
                            Text(
                                'Phone: ${applicant['phoneNumber'] ?? 'Not provided'}'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text('Email'),
                            onPressed: () async {
                              final email = applicant['email'];
                              if (email != null) {
                                final Uri emailUri = Uri(
                                  scheme: 'mailto',
                                  path: email,
                                );
                                if (await canLaunch(emailUri.toString())) {
                                  await launch(emailUri.toString());
                                } else {
                                  throw 'Could not launch $emailUri';
                                }
                              }
                            },
                          ),
                          TextButton(
                            child: Text('Call'),
                            onPressed: () async {
                              final phoneNumber = applicant['phoneNumber'];
                              if (phoneNumber != null) {
                                final Uri phoneUri = Uri(
                                  scheme: 'tel',
                                  path: phoneNumber,
                                );
                                if (await canLaunch(phoneUri.toString())) {
                                  await launch(phoneUri.toString());
                                } else {
                                  throw 'Could not launch $phoneUri';
                                }
                              }
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                ),
                child: const Text('Contact',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
