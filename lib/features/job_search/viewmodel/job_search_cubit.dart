import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

import '../../auth/data/model/user_model.dart';
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
      emit(JobSearchSuccess(
        [],
        [],
        [],
        [],
        [],
        [],
      ));
    } else {
      emit(JobSearchNoResult());
    }
  }

  Future<void> removeRecentSearch(String search) async {
    if (_userId != null) {
      await _searchRepository.removeRecentSearch(_userId!, search);
      _recentSearches.remove(search);
      emit(JobSearchSuccess(
        [],
        [],
        [],
        [],
        [],
        [],
      ));
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

      List<Job> allJobs = await _searchRepository.fetchJobs();
      List<UserModel?> allUsers = await _searchRepository.fetchAllUserNames();

      String normalizedQuery = query.trim().toLowerCase().replaceAll(' ', '');

      List<Job> result = allJobs.where((job) {
        String normalizedJobTitle =
            job.jobTitle!.toLowerCase().replaceAll(' ', '');
        return normalizedJobTitle.startsWith(normalizedQuery);
      }).toList();

      List<Job> resultCompany = allJobs.where((company) {
        String normalizedJobTitle =
            company.companyName!.toLowerCase().replaceAll(' ', '');
        return normalizedJobTitle.startsWith(normalizedQuery);
      }).toList();

      List<UserModel?> userNames = allUsers.where((user) {
        String normalizedJobTitle =
            user!.name.toLowerCase().replaceAll(' ', '');
        return normalizedJobTitle.startsWith(normalizedQuery);
      }).toList();

      if (_filters.isNotEmpty) {
        result = result.where((job) {
          bool matchesCompany = _filters.contains(job.companyName);
          bool matchesLocation = _filters.contains(job.location);
          return matchesCompany || matchesLocation;
        }).toList();
      }

      final List<String?> uniqueTitles =
          result.map((job) => job.jobTitle).toSet().toList();

      final List<String?> uniqueUserNames =
          userNames.map((user) => user?.name).toSet().toList();

      final List<String?> uniqueCompanyNames =
          resultCompany.map((company) => company.companyName).toSet().toList();

      if (result.isNotEmpty ||
          userNames.isNotEmpty ||
          resultCompany.isNotEmpty) {
        emit(JobSearchSuccess(
          result,
          userNames,
          resultCompany,
          uniqueTitles,
          uniqueUserNames,
          uniqueCompanyNames,
        ));
      } else {
        emit(JobSearchNoResult());
      }
    } catch (e) {
      emit(JobSearchError("Error occurred while searching: $e"));
    }
  }

  Set<String> get selectedFilters => _selectedFilters;

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
