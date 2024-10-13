import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/job_search/models/jobs.dart';
import 'package:jop_finder_app/features/job_search/viewmodel/job_search_state.dart';

class JobSearchCubit extends Cubit<JobSearchState> {
  JobSearchCubit() : super(JobSearchInitial()){fetchRecentSearches();}
  final Set<String> _selectedFilters = {};
  Timer? _debounce;
  Set<String> _filters = {};
   List<String> _recentSearches = [];

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;



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

  void removeRecentSearch(String search) {
    if (_userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .collection('searches')
          .where('searchTerm', isEqualTo: search)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

    }
    emit(JobSearchInitial());
  }

  Future<void> fetchRecentSearches() async {
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

      if (_filters.isNotEmpty) {
        result = result.where((job) {
          bool matchesCompany = _filters.contains(job.companyName);
          bool matchesLocation = _filters.contains(job.location);
          return matchesCompany || matchesLocation;
        }).toList();
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
