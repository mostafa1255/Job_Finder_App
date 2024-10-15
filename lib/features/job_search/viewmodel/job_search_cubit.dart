import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

import '../models/repo/search_repository.dart';

class JobSearchCubit extends Cubit<JobSearchState> {
  final SearchRepository _searchRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Set<String> _selectedFilters = {};

  JobSearchCubit(this._searchRepository) : super(JobSearchInitial());

  Timer? _debounce;
  Set<String> _filters = {};
  List<String> _recentSearches = [];

  String? get _userId => _auth.currentUser?.uid;

  void setFilters(Set<String> filters) {
    _filters = filters;
    emit(JobFilterIsSelected(_filters));
  }

  bool isFilterSelected(String filter) {
    return _filters.contains(filter);
  }

  void toggleFilter(String filter) {
    if (_filters.contains(filter)) {
      _filters.remove(filter);
    } else {
      _filters.add(filter);
    }
    emit(JobFilterIsSelected(_filters));
  }

  Future<void> addRecentSearch(String search) async {
    if (_userId != null) {
      await _searchRepository.addRecentSearch(_userId!, search);
    }
  }

  Future<void> fetchRecentSearches() async {
    emit(JobSearchLoading());

    if (_userId != null) {
      List<String> recentSearches =
          await _searchRepository.fetchRecentSearches(_userId!);
      _recentSearches = recentSearches;
      emit(JobSearchSuccess([], {}));
    } else {
      emit(JobSearchNoResult());
    }
  }

  Future<void> removeRecentSearch(String search) async {
    if (_userId != null) {
      await _searchRepository.removeRecentSearch(_userId!, search);
      _recentSearches.remove(search);
      emit(JobSearchSuccess([], {}));
    }
  }

  List<String> get recentSearches => _recentSearches;

  Future<void> searchJob(String query) async {
    emit(JobSearchLoading());

    try {
      if (query.trim().isEmpty) {
        emit(JobSearchInitial());
        return;
      }

      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('allJobs').get();

      List<Job> allJobs = snapshot.docs
          .map((doc) => Job.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      String normalizedQuery = query.trim().toLowerCase().replaceAll(' ', '');

      Map<String, Set<String>> uniqueJobResult = {
        'jobTitles': <String>{},
        'companyNames': <String>{},
        'locations': <String>{}
      };

      List<Job> result = allJobs.where((job) {
        String normalizedJobTitle =
            job.jobTitle?.toLowerCase().replaceAll(' ', '') ?? '';
        String normalizedCompanyName =
            job.companyName?.toLowerCase().replaceAll(' ', '') ?? '';
        String normalizedLocation =
            job.location?.toLowerCase().replaceAll(' ', '') ?? '';

        bool matchesTitle = normalizedJobTitle.startsWith(normalizedQuery);
        bool matchesCompany = normalizedCompanyName.startsWith(normalizedQuery);
        bool matchesLocation = normalizedLocation.startsWith(normalizedQuery);

        if (matchesTitle) {
          uniqueJobResult['jobTitles']?.add(job.jobTitle!);
        }
        if (matchesCompany) {
          uniqueJobResult['companyNames']?.add(job.companyName!);
        }
        if (matchesLocation) {
          uniqueJobResult['locations']?.add(job.location!);
        }

        return matchesTitle || matchesCompany || matchesLocation;
      }).toList();

      if (_filters.isNotEmpty) {
        result = result.where((job) {
          bool matchesLocation =
              _filters.contains(job.location?.toLowerCase().trim() ?? "");
          bool matchesCompany =
              _filters.contains(job.companyName?.toLowerCase().trim() ?? "");
          return matchesCompany || matchesLocation;
        }).toList();
      }

      final jobTitles = uniqueJobResult['jobTitles']?.toList() ?? [];
      final companyNames = uniqueJobResult['companyNames']?.toList() ?? [];
      final locations = uniqueJobResult['locations']?.toList() ?? [];

      if (result.isNotEmpty) {
        emit(JobSearchSuccess(result, {
          'jobTitles': jobTitles,
          'companyNames': companyNames,
          'locations': locations
        }));
      } else {
        emit(JobSearchNoResult());
      }
    } catch (e) {
      emit(JobSearchError("Error occurred while searching for jobs: $e"));
    }
  }

  void filterJobsByTitle(String selectedJobTitle) {
    final currentState = state;
    if (currentState is JobSearchSuccess) {
      final filteredJobs = currentState.jobs
          .where((job) => job.jobTitle == selectedJobTitle)
          .toList();

      emit(JobSearchSuccess(filteredJobs, currentState.uniqueJobResult));
    }
  }

  void filterJobsByLocation(String selectedLocation) {
    final currentState = state;
    if (currentState is JobSearchSuccess) {
      final filteredJobs = currentState.jobs
          .where((job) => job.location == selectedLocation)
          .toList();

      emit(JobSearchSuccess(filteredJobs, currentState.uniqueJobResult));
    }
  }

  void filterJobsByCompanyName(String selectedCompanyName) {
    final currentState = state;
    if (currentState is JobSearchSuccess) {
      final filteredJobs = currentState.jobs
          .where((job) => job.companyName == selectedCompanyName)
          .toList();

      emit(JobSearchSuccess(filteredJobs, currentState.uniqueJobResult));
    }
  }

  Set<String> get selectedFilters => _selectedFilters;

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
