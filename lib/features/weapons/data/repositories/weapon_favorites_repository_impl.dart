import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/weapons/domain/repositories/weapon_favorites_repository.dart';
import 'package:new_block/features/weapons/data/datasources/weapon_favorites_remote_data_source.dart';

class WeaponFavoritesRepositoryImpl implements WeaponFavoritesRepository {
  final WeaponFavoritesRemoteDataSource remoteDataSource;

  WeaponFavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> toggleFavorite(
    String weaponId,
    bool isFavorite,
  ) async {
    try {
      await remoteDataSource.toggleFavorite(weaponId, isFavorite);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Failed to update favorite'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFavoriteIds() async {
    try {
      final favoriteIds = await remoteDataSource.getFavoriteIds();
      return Right(favoriteIds);
    } catch (e) {
      return const Left(ServerFailure('Failed to load favorites'));
    }
  }
}
