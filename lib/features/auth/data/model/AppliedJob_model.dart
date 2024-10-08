import 'package:cloud_firestore/cloud_firestore.dart';

class AppliedJob {
  final String? jobId;
  final String? companyName;
  final String? jobTitle;
  final DateTime? appliedDate;
  final String? status;
  final String? salary;
  final String? companyImageURL;
  final String? location;
  final String? jobType;

  AppliedJob({
    this.jobId,
    this.companyName,
    this.jobTitle,
    this.appliedDate,
    this.status,
    this.salary,
    this.companyImageURL,
    this.location,
    this.jobType,
  });

  factory AppliedJob.fromMap(Map<String, dynamic> map) {
    return AppliedJob(
      jobId: map['jobId'] as String?,
      companyName: map['companyName'] as String?,
      jobTitle: map['jobTitle'] as String?,
      appliedDate: (map['appliedDate'] as Timestamp?)?.toDate(),
      status: map['status'] as String?,
      salary: map['salary'] as String?,
      companyImageURL: map['jobImageURL'] as String?,
      location: map['location'] as String?,
      jobType: map['jobType'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'appliedDate':
          appliedDate != null ? Timestamp.fromDate(appliedDate!) : null,
      'status': status,
      'salary': salary,
      'companyImageURL': companyImageURL,
      'location': location,
      'jobType': jobType,
    };
  }
}
