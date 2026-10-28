import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/agents/domain/repositories/favorites_repository.dart';

class GetFavoriteIdsUseCase {
  final FavoritesRepository repository;
  GetFavoriteIdsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call() {
    return repository.getFavoriteIds();
  }
}
