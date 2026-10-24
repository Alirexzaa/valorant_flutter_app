import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';
import 'package:new_block/features/weapons/domain/repositories/weapons_repository.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_local_data_source.dart';
import 'package:new_block/features/weapons/data/datasources/weapons_remote_data_source.dart';

class WeaponsRepositoryImpl implements WeaponsRepository {
  final WeaponsRemoteDataSource remoteDataSource;
  final WeaponsLocalDataSource localDataSource; // ← اضافه شد

  WeaponsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource, // ← اضافه شد
  });

  @override
  Future<Either<Failure, List<Weapon>>> getWeapons() async {
    try {
      final remoteWeapons = await remoteDataSource.getWeapons();
      await localDataSource.cacheWeapons(remoteWeapons);

      return Right(remoteWeapons);
    } catch (e) {
      try {
        final localWeapons = await localDataSource.getLastWeapons();
        return Right(localWeapons);
      } catch (cacheError) {
        // ❌ خطا: خطا رو توی Left بذار (دیگه throw نمیکنیم)
        return const Left(
          CacheFailure('No internet and no cached data available.'),
        );
      }
    }
  }
}
