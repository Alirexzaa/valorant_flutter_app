abstract class WeaponFavoritesRemoteDataSource {
  Future<void> toggleFavorite(String weaponId, bool isFavorite);
  Future<List<String>> getFavoriteIds();
}
