import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';

abstract class WeaponFavoritesRepository {
  Future<Either<Failure, void>> toggleFavorite(
    String weaponId,
    bool isFavorite,
  );
  Future<Either<Failure, List<String>>> getFavoriteIds();
}
