import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

class JobSearchCubit extends Cubit<JobSearchState> {
  JobSearchCubit() : super(JobSearchInitial()){}
  final Set<String> _selectedFilters = {};
  Timer? _debounce;
  Set<String> _filters = {};
   List<String> _recentSearches = [];

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  void setFilters(Set<String> filters) {
    _filters = filters;
    emit(JobFilterIsSelected(_filters));
    print('initial filters: $_filters');
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
    _filters = _selectedFilters;
    emit(JobFilterIsSelected(_selectedFilters));
  }

  Future<void> addRecentSearch(String search) async {
    if (_userId != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('searches')
          .add({
        'searchTerm': search,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  void removeRecentSearch(String search) async {
    if (_userId != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('searches')
          .where('searchTerm', isEqualTo: search)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      _recentSearches.remove(search);

      emit(JobSearchSuccess([], []));
    }
  }


  Future<void> fetchRecentSearches() async {
    emit(JobSearchLoading());
    if (_userId != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('searches')
          .orderBy('timestamp', descending: true)
          .get();

      List<String> recentSearches = snapshot.docs
          .map((doc) => doc['searchTerm'] as String)
          .toList();

      _recentSearches = recentSearches;

      emit(JobSearchSuccess([], []));
    } else {
      emit(JobSearchNoResult());
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
          await FirebaseFirestore.instance.collection('jobs').get();

      List<Job> allJobs = snapshot.docs
          .map((doc) => Job.fromMap(doc.data() as Map<String, dynamic>))
          .toList();

      String normalizedQuery = query.trim().toLowerCase().replaceAll(' ', '');

      List<Job> result = allJobs.where((job) {
        String normalizedJobTitle =
            job.jobTitle!.toLowerCase().replaceAll(' ', '');
        return normalizedJobTitle.startsWith(normalizedQuery);
      }).toList();
      print('filters:$_filters');
      if (_filters.isNotEmpty) {
        result = result.where((job) {
          bool matchesLocation = _filters.contains(job.location?.toLowerCase().trim() ?? "");
          bool matchesCompany = _filters.contains(job.companyName?.toLowerCase().trim() ?? "");
          return matchesCompany || matchesLocation;

        }).toList();
        print('filters:$_filters');
      }

      final List<String?> uniqueJobTitles =
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
