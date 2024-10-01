import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String? bio;
  final List<String> skills;
  final List<Education> education;
  // final List<WorkExperience> workExperience;

  UserProfile({
    this.bio,
    this.skills = const [],
    this.education = const [],
    // this.workExperience = const [],
  });

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      bio: map['bio'],
      skills: List<String>.from(map['skills'] ?? []),
      education: (map['education'] as List? ?? [])
          .map((edu) => Education.fromMap(edu))
          .toList(),
      // workExperience: (map['workExperience'] as List? ?? [])
      //     .map((exp) => WorkExperience.fromMap(exp))
      //     .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bio': bio,
      'skills': skills,
      'education': education.map((edu) => edu.toMap()).toList(),
      // 'workExperience': workExperience.map((exp) => exp.toMap()).toList(),
    };
  }
}

class Education {
  final String institution;
  final String degree;
  final String fieldOfStudy;
  final DateTime startDate;
  final DateTime? endDate;

  Education({
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    this.endDate,
  });

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      institution: map['institution'],
      degree: map['degree'],
      fieldOfStudy: map['fieldOfStudy'],
      startDate: (map['startDate'] as Timestamp).toDate(),
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
      'startDate': Timestamp.fromDate(startDate),
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
    };
  }
}

// class WorkExperience {
//   final String company;
//   final String position;
//   final DateTime startDate;
//   final DateTime? endDate;
//   final String description;

//   WorkExperience({
//     required this.company,
//     required this.position,
//     required this.startDate,
//     this.endDate,
//     required this.description,
//   });

//   factory WorkExperience.fromMap(Map<String, dynamic> map) {
//     return WorkExperience(
//       company: map['company'],
//       position: map['position'],
//       startDate: (map['startDate'] as Timestamp).toDate(),
//       endDate: map['endDate'] != null
//           ? (map['endDate'] as Timestamp).toDate()
//           : null,
//       description: map['description'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'company': company,
//       'position': position,
//       'startDate': Timestamp.fromDate(startDate),
//       'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
//       'description': description,
//     };
//   }
// }
