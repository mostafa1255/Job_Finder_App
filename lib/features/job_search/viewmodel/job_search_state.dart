import 'package:jop_finder_app/features/auth/data/model/PostedJob_model.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';

abstract class JobSearchState {}

class JobSearchInitial extends JobSearchState {}

class JobSearchLoading extends JobSearchState {}

class JobSearchSuccess extends JobSearchState {
  final List<PostedJob> jobs;
  final List<String?> uniqueJobTitles;

  JobSearchSuccess(this.jobs, this.uniqueJobTitles);
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
