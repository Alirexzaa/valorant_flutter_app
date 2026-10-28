abstract class FavoritesRemoteDataSource {
  Future<void> toggleFavorite(String agentId, bool isFavorite);
  Future<List<String>> getFavoriteIds();
}
