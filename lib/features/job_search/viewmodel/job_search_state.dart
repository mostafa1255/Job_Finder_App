import 'package:jop_finder_app/features/auth/data/model/user_model.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';

abstract class JobSearchState {}

class JobSearchInitial extends JobSearchState {}

class JobSearchLoading extends JobSearchState {}

class JobSearchSuccess extends JobSearchState {
  final List<Job> jobs;
  final List<UserModel?> users;
  final List<Job> companyNames;
  final List<String?> uniqueTitles;
  final List<String?> uniqueUserNames;
  final List<String?> uniqueCompanyNames;

  JobSearchSuccess(
    this.jobs,
    this.users,
    this.companyNames,
    this.uniqueTitles,
    this.uniqueUserNames,
    this.uniqueCompanyNames,
  );
}

class JobSearchNoResult extends JobSearchState {}

class JobSearchError extends JobSearchState {
  final String message;

  JobSearchError(this.message);
}

class JobFilterInitial extends JobSearchState {}

class JobFilterIsSelected extends JobSearchState {
  final Set<String> selectedFilters;

  JobFilterIsSelected(this.selectedFilters);
}
