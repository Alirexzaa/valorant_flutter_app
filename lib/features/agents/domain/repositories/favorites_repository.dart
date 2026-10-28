import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, void>> toggleFavorite(String agentId, bool isFavorite);
  Future<Either<Failure, List<String>>> getFavoriteIds();
}
