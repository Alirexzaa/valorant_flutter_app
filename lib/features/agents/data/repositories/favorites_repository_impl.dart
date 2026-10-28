import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/agents/domain/repositories/favorites_repository.dart';

import '../datasources/favorites_remote_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> toggleFavorite(
    String agentId,
    bool isFavorite,
  ) async {
    try {
      await remoteDataSource.toggleFavorite(agentId, isFavorite);
      return const Right(null);
    } catch (e) {
      print('🔥 Firestore Actual Error: $e'); // ✅ خطای واقعی رو چاپ میکنه
      return Left(ServerFailure('Failed to update favorite: $e'));
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
