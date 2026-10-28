import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/agents/domain/repositories/favorites_repository.dart';

class ToggleFavoriteUseCase {
  final FavoritesRepository repository;
  ToggleFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(String agentId, bool isFavorite) {
    return repository.toggleFavorite(agentId, isFavorite);
  }
}
