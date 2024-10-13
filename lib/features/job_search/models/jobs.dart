class Job {
  final String? jobTitle;
  final String? salary;
  final String? companyName;
  final String? location;
  final String? imageUrl;
  // final String experienceLevel;
  // final String jobType;
  // final String role;

  Job({
    required this.jobTitle,
    required this.salary,
    required this.companyName,
    required this.location,
    required this.imageUrl,
    // required this.experienceLevel,
    // required this.jobType,
    // required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'salary': salary,
      'companyName': companyName,
      'location': location,
      'imageUrl': imageUrl,
      // 'experienceLevel': job.experienceLevel,
      // 'jobType': job.jobType,
      // 'role': job.role,
    };
  }

  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      jobTitle: map['jobTitle'] as String?,
      salary: map['salary'] as String?,
      companyName: map['companyName'] as String?,
      location: map['location'] as String?,
      imageUrl: map['imageUrl'] as String?,
      // experienceLevel: map['experienceLevel'],
      // jobType: map['jobType'],
      // role: map['role'],
    );
  }
}