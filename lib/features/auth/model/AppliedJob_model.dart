import 'package:cloud_firestore/cloud_firestore.dart';

class AppliedJob {
  final String jobId;
  final String companyName;
  final String jobTitle;
  final DateTime appliedDate;
  final String status;

  AppliedJob({
    required this.jobId,
    required this.companyName,
    required this.jobTitle,
    required this.appliedDate,
    required this.status,
  });

  factory AppliedJob.fromMap(Map<String, dynamic> map) {
    return AppliedJob(
      jobId: map['jobId'],
      companyName: map['companyName'],
      jobTitle: map['jobTitle'],
      appliedDate: (map['appliedDate'] as Timestamp).toDate(),
      status: map['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'appliedDate': Timestamp.fromDate(appliedDate),
      'status': status,
    };
  }
}
