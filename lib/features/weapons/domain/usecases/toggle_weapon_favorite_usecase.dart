import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/weapons/domain/repositories/weapon_favorites_repository.dart';

class ToggleWeaponFavoriteUseCase {
  final WeaponFavoritesRepository repository;
  ToggleWeaponFavoriteUseCase(this.repository);

  Future<Either<Failure, void>> call(String weaponId, bool isFavorite) {
    return repository.toggleFavorite(weaponId, isFavorite);
  }
}
