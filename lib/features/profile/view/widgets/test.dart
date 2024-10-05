
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/auth/data/model/AppliedJob_model.dart';
import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';
import 'package:jop_finder_app/features/auth/data/model/UserProfile_model.dart';
import 'package:flutter/material.dart';
import 'package:jop_finder_app/features/profile/view/widgets/logout_alert.dart';
import 'package:jop_finder_app/firebase_options.dart';

void main() async{WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
      home: Scaffold(
    body: Center(
      child: TextButton(
        onPressed:() {
          createFakeUserDocument();
        }
      , child: const Text('post')
      )
    ),
  )));
}


Future<void> createFakeUserDocument() async {
  // Assuming you have a Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fake user ID
  String fakeUserId = "fakeUserId1234";

  // Create fake data for the User model
  User fakeUser = User(
    id: fakeUserId,
    name: "John Doe",
    email: "johndoe@example.com",
    phoneNumber: "1234567890",
    profileImageUrl: "https://example.com/profile.jpg",
    appliedJobs: [
      AppliedJob(jobId: "jobId1", appliedDate: DateTime.now()),
    ],
    postedJobs: [
      PostedJob(jobId: "jobId2", postedDate: DateTime.now()),
    ],
    cvUrl: "https://example.com/cv.pdf",
    additionalInfo: {"key": "value"},
    profile: UserProfile(
      bio: "A short bio",
      skills: ["Dart", "Flutter"],
      education: [
        Education(
          institution: "University",
          degree: "Bachelor",
          fieldOfStudy: "Computer Science",
          startDate: DateTime(2020),
          endDate: DateTime(2024),
        ),
      ],
    ),
  );

  // Convert the fake user data to a Map
  Map<String, dynamic> userData = fakeUser.toFirestore();

  // Create a document in the 'users' collection with the fake user data
  try {
  await firestore.collection('users').add(userData);
} catch (e) {
  if (e is FirebaseException) {
    // Handle Firebase exceptions here
    print(e.message);
  } else {
    // Other exceptions
    print(e.toString());
  }
}
}