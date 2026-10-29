import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/weapons/domain/repositories/weapon_favorites_repository.dart';

class GetFavoriteWeaponIdsUseCase {
  final WeaponFavoritesRepository repository;
  GetFavoriteWeaponIdsUseCase(this.repository);

  Future<Either<Failure, List<String>>> call() {
    return repository.getFavoriteIds();
  }
}
