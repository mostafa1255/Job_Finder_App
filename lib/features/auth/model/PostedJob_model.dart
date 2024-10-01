import 'package:cloud_firestore/cloud_firestore.dart';

class PostedJob {
  final String jobId;
  final String jobTitle;
  final String description;
  final DateTime postedDate;
  final String status;
  final List<String> applicantIds;

  PostedJob({
    required this.jobId,
    required this.jobTitle,
    required this.description,
    required this.postedDate,
    required this.status,
    this.applicantIds = const [],
  });

  factory PostedJob.fromMap(Map<String, dynamic> map) {
    return PostedJob(
      jobId: map['jobId'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      description: map['description'] ?? '',
      postedDate: (map['postedDate'] as Timestamp).toDate(),
      status: map['status'] ?? 'open',
      applicantIds: List<String>.from(map['applicantIds'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'jobTitle': jobTitle,
      'description': description,
      'postedDate': Timestamp.fromDate(postedDate),
      'status': status,
      'applicantIds': applicantIds,
    };
  }
}
