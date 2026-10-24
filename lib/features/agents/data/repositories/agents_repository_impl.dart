import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/domain/repositories/agents_repository.dart';
import 'package:new_block/features/agents/data/datasources/agents_local_data_source.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';

class AgentsRepositoryImpl implements AgentsRepository {
  final AgentsRemoteDataSource remoteDataSource;
  final AgentsLocalDataSource localDataSource;

  AgentsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Agent>>> getAgents() async {
    try {
      final remoteAgents = await remoteDataSource.getAgents();
      await localDataSource.cacheAgents(remoteAgents);

      return Right(remoteAgents);
    } catch (e) {
      try {
        final localAgents = await localDataSource.getLastAgents();
        return Right(localAgents);
      } catch (cacheError) {
        // اگه کش هم خالی بود، ارور میدیم
        return const Left(
          CacheFailure('No internet and no cached data available.'),
        );
      }
    }
  }
}
