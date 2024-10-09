import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
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

    // Fetch all jobs from Firestore
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('jobs').get();

    print("Snapshot: ${snapshot.docs}");

    // Map the snapshot to Job objects
    List<Job> allJobs = snapshot.docs
        .map((doc) => Job.fromMap(doc.data() as Map<String, dynamic>))
        .toList();

    // Normalize the query: remove spaces and convert to lowercase
    String normalizedQuery = query.trim().toLowerCase().replaceAll(' ', '');

    // Filter based on the normalized query
    List<Job> result = allJobs.where((job) {
      // Normalize the job title: remove spaces and convert to lowercase
      String normalizedJobTitle = job.jobTitle!.toLowerCase().replaceAll(' ', '');
      return normalizedJobTitle.startsWith(normalizedQuery);
    }).toList();

    // Apply additional filters if any
    if (_filters.isNotEmpty) {
      result = result.where((job) {
        bool matchesCompany = _filters.contains(job.companyName);
        bool matchesLocation = _filters.contains(job.location);
        return matchesCompany || matchesLocation;
      }).toList();
    }

    final List<String?> uniqueJobTitles = result.map((job) => job.jobTitle).toSet().toList();

    if (result.isNotEmpty) {
      emit(JobSearchSuccess(result, uniqueJobTitles));
      print("Result: $result");
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
