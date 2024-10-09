import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/models/mock_data.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

class JobSearchCubit extends Cubit<JobSearchState> {
  JobSearchCubit() : super(JobSearchInitial());
  final Set<String> _selectedFilters = {};

  Timer? _debounce;
  Set<String> _filters = {};

  void setFilters(Set<String> filters) {
    _filters = filters;
    print(_filters);
    emit(JobFilterIsSelected(_filters));
  }

  bool isFilterSelected(String filter) {
    return _selectedFilters.contains(filter);
  }

  void toggleFilter(String filter) {
    if (_selectedFilters.contains(filter)) {
      _selectedFilters.remove(filter);
    } else {
      _selectedFilters.add(filter);
    }
    emit(JobFilterIsSelected(_selectedFilters));
  }

  Future<void> searchJob(String query) async {
    emit(JobSearchLoading());

    try {
      if (query.trim().isEmpty) {
        emit(JobSearchInitial());
        return;
      }

      await Future.delayed(const Duration(seconds: 1));

      List<Job> result = allJobs
          .where((job) =>
              job.jobTitle.trim().toLowerCase().contains(query.toLowerCase()))
          .toList();

      print("Filters: $_filters");
      if (_filters.isNotEmpty) {
        result = result.where((job) {
          bool matchesCompany = _filters.contains(job.companyName);
          bool matchesLocation = _filters.contains(job.location);
          bool matchesExperienceLevel = _filters.contains(job.experienceLevel);
          bool matchesJobType = _filters.contains(job.jobType);
          bool matchesRole = _filters.contains(job.role);

          return matchesCompany ||
              matchesLocation ||
              matchesExperienceLevel ||
              matchesJobType ||
              matchesRole;
        }).toList();
      }

      final List<String> uniqueJobTitles =
          result.map((job) => job.jobTitle).toSet().toList();

      if (result.isNotEmpty) {
        emit(JobSearchSuccess(result, uniqueJobTitles));
      } else {
        emit(JobSearchNoResult());
      }
    } catch (e) {
      emit(JobSearchError("Error occurred while searching for jobs: $e"));
    }
  }

  Set<String> get selectedFilters => _selectedFilters;

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
