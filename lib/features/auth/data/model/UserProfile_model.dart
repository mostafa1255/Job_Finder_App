import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String? jobTitle;
  final String? bio;
  final List<String>? skills;
  final List<Education>? education;
  final String? status;

  UserProfile({
    this.jobTitle,
    this.bio,
    this.skills,
    this.education,
    this.status,
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      jobTitle: map['jobTitle'] as String?,
      bio: map['bio'] as String?,
      skills: List<String>.from(map['skills'] ?? []),
      education: (map['education'] as List? ?? [])
          .map((edu) => Education.fromMap(edu))
          .toList(),
      status: map['status'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'bio': bio,
      'skills': skills,
      'education': education?.map((edu) => edu.toMap()).toList(),
      'status': status,
    };
  }
}

class Education {
  final String? institution;
  final String? degree;
  final String? fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;

  Education({
    this.institution,
    this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
  });

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      institution: map['institution'] as String?,
      degree: map['degree'] as String?,
      fieldOfStudy: map['fieldOfStudy'] as String?,
      startDate: (map['startDate'] as Timestamp?)?.toDate(),
      endDate: map['endDate'] != null
          ? (map['endDate'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate != null ? Timestamp.fromDate(startDate!) : null,
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
    };
  }
}

// Uncomment this section if needed
// class WorkExperience {
//   final String? company;
//   final String? position;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? description;

//   WorkExperience({
//     this.company,
//     this.position,
//     this.startDate,
//     this.endDate,
//     this.description,
//   });

//   factory WorkExperience.fromMap(Map<String, dynamic> map) {
//     return WorkExperience(
//       company: map['company'] as String?,
//       position: map['position'] as String?,
//       startDate: (map['startDate'] as Timestamp?)?.toDate(),
//       endDate: map['endDate'] != null
//           ? (map['endDate'] as Timestamp).toDate()
//           : null,
//       description: map['description'] as String?,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'company': company,
//       'position': position,
//       'startDate': startDate != null ? Timestamp.fromDate(startDate!) : null,
//       'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
//       'description': description,
//     };
//   }
// }
