import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/auth/model/AppliedJob_model.dart';
import 'package:jop_finder_app/features/auth/model/PostedJob_model.dart';
import 'package:jop_finder_app/features/auth/model/UserProfile_model.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? profileImageUrl;
  final List<AppliedJob> appliedJobs;
  final List<PostedJob> postedJobs;
  final String? cvUrl;
  final Map<String, dynamic> additionalInfo;
  final UserProfile? profile;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.profileImageUrl,
    this.appliedJobs = const [],
    this.postedJobs = const [],
    this.cvUrl,
    this.additionalInfo = const {},
    this.profile,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'],
      profileImageUrl: data['profileImageUrl'],
      appliedJobs: (data['appliedJobs'] as List? ?? [])
          .map((job) => AppliedJob.fromMap(job))
          .toList(),
      postedJobs: (data['postedJobs'] as List? ?? [])
          .map((job) => PostedJob.fromMap(job))
          .toList(),
      cvUrl: data['cvUrl'],
      additionalInfo: data['additionalInfo'] ?? {},
      profile:
          data['profile'] != null ? UserProfile.fromMap(data['profile']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'appliedJobs': appliedJobs.map((job) => job.toMap()).toList(),
      'postedJobs': postedJobs.map((job) => job.toMap()).toList(),
      'cvUrl': cvUrl,
      'additionalInfo': additionalInfo,
      'profile': profile?.toMap(),
    };
  }
}
