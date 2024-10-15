import 'package:cloud_firestore/cloud_firestore.dart';

class PostedJob {
  final String? jobId;
  final String? jobTitle;
  final String? companyName;
  final String? description;
  final String? salary;
  final String? location;
  final DateTime? postedDate;
  final List<String>? applicantIds;
  final List<String>? jobTags;
  final String? imageUrl;
  final String? about;
  final List<String>? requirements;
  final String? postedByUserId; 

  PostedJob({
    this.jobId,
    this.jobTitle,
    this.companyName,
    this.description,
    this.salary,
    this.location,
    this.postedDate,
    this.applicantIds,
    this.jobTags,
    this.imageUrl,
    this.about,
    this.requirements,
    this.postedByUserId, 
  });

  factory PostedJob.fromMap(Map<String, dynamic> map) {
    return PostedJob(
      jobId: map['jobId'] as String?,
      jobTitle: map['jobTitle'] as String?,
      companyName: map['companyName'] as String?,
      description: map['description'] as String?,
      salary: map['salary'] as String?,
      location: map['location'] as String?,
      postedDate: (map['postedDate'] as Timestamp?)?.toDate(),
      applicantIds: List<String>.from(map['applicantIds'] ?? []),
      jobTags: List<String>.from(map['jobTags'] ?? []),
      imageUrl: map['imageUrl'] as String?,
      about: map['about'] as String?,
      requirements: List<String>.from(map['requirements'] ?? []),
      postedByUserId: map['postedByUserId'] as String?, // Map new field
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobId': jobId,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'description': description,
      'salary': salary,
      'location': location,
      'postedDate': postedDate != null ? Timestamp.fromDate(postedDate!) : null,
      'applicantIds': applicantIds,
      'jobTags': jobTags,
      'imageUrl': imageUrl,
      'about': about,
      'requirements': requirements,
      'postedByUserId': postedByUserId, // Include new field in map
    };
  }
}
