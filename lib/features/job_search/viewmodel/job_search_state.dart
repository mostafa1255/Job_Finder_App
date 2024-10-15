import 'package:jop_finder_app/features/job_search/models/jobs.dart';

abstract class JobSearchState {}

class JobSearchInitial extends JobSearchState {}

class JobSearchLoading extends JobSearchState {}

class JobSearchSuccess extends JobSearchState {
  final List<Job> jobs;
  final Map<String, List<String>> uniqueJobResult;

  JobSearchSuccess(this.jobs, this.uniqueJobResult);
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
