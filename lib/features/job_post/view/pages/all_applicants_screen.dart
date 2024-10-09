import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AllApplicantsScreen extends StatelessWidget {
  final String jobId;

  const AllApplicantsScreen({super.key, required this.jobId});

  Future<List<Map<String, dynamic>>> _fetchApplicants() async {
    DocumentSnapshot jobSnapshot =
        await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();

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
        backgroundColor: Colors.white,
        title: const Text(
          "All Applicants",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        applicant['email'] ?? 'No Email',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            const Text(
              'Skills:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('View Profile',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 53, 104, 153),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Contact', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 53, 104, 153),
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
