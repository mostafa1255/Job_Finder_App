abstract class SearchRepository {
  Future<void> addRecentSearch(String userId, String search);
  Future<List<String>> fetchRecentSearches(String userId);
  Future<void> removeRecentSearch(String userId, String search);
}
