import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jop_finder_app/features/job_search/models/repo/search_repository.dart';

class FirebaseSearchRepository implements SearchRepository {
  final FirebaseFirestore _firestore;

  FirebaseSearchRepository(this._firestore);

  @override
  Future<void> addRecentSearch(String userId, String search) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('searches')
        .add({
      'searchTerm': search,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<List<String>> fetchRecentSearches(String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('searches')
        .orderBy('timestamp', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => doc['searchTerm'] as String)
        .toList();
  }

  @override
  Future<void> removeRecentSearch(String userId, String search) async {
    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('searches')
        .where('searchTerm', isEqualTo: search)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
