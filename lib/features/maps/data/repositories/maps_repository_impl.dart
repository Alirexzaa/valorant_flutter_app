import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/maps/data/datasources/maps_local_data_source.dart';
import 'package:new_block/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:new_block/features/maps/domain/entities/map.dart';
import 'package:new_block/features/maps/domain/repositories/maps_repository.dart';

class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteDataSource remoteDataSource;
  final MapsLocalDataSource localDataSource;

  MapsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<ValorantMap>>> getMaps() async {
    try {
      final remoteMaps = await remoteDataSource.getMaps();
      final entities = remoteMaps.map((model) => model as ValorantMap).toList();
      await localDataSource.cacheMaps(remoteMaps);

      return Right(entities);
    } catch (e) {
      try {
        final localMaps = await localDataSource.getLastMaps();
        return Right(localMaps);
      } catch (cacheError) {
        // اگه کش هم خالی بود، ارور میدیم
        return const Left(
          CacheFailure('No internet and no cached data available.'),
        );
      }
    }
  }
}
