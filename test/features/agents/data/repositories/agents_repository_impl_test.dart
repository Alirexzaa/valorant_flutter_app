import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:new_block/core/errors/failures.dart';

import 'package:new_block/features/agents/data/datasources/agents_local_data_source.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';
import 'package:new_block/features/agents/data/models/agent_model.dart';
import 'package:new_block/features/agents/data/repositories/agents_repository_impl.dart';

class MockAgentsRemoteDataSource extends Mock
    implements AgentsRemoteDataSource {}

class MockAgentsLocalDataSource extends Mock implements AgentsLocalDataSource {}

void main() {
  late MockAgentsRemoteDataSource mockRemoteDataSource;
  late MockAgentsLocalDataSource mockLocalDataSource;
  late AgentsRepositoryImpl repository;

  const tAgents = [
    AgentModel(id: '1', name: 'Jett', role: 'Duelist', imageUrl: 'url1'),
    AgentModel(id: '2', name: 'Omen', role: 'Controller', imageUrl: 'url2'),
  ];

  setUp(() {
    mockRemoteDataSource = MockAgentsRemoteDataSource();
    mockLocalDataSource = MockAgentsLocalDataSource();

    repository = AgentsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('AgentsRepositoryImpl', () {
    // ═══════════════════════════════════════════
    // تست ۱: وقتی API موفق میشه
    // ═══════════════════════════════════════════
    test('should return remote data when the call to remote data source is successful', () async {
      when(() => mockRemoteDataSource.getAgents())
          .thenAnswer((_) async => tAgents);
      when(() => mockLocalDataSource.cacheAgents(tAgents))
          .thenAnswer((_) async => {});

      final result = await repository.getAgents();

      // ✅ به جای expect ساده، از fold استفاده میکنیم تا ببینیم Right برگشته
      result.fold((l) => fail('Should return Right (Success)'), (r) {
        expect(r.length, 2);
        expect(r.first.id, '1');
      });

      verify(() => mockRemoteDataSource.getAgents()).called(1);
      verify(() => mockLocalDataSource.cacheAgents(tAgents)).called(1);
    });

    // ═══════════════════════════════════════════
    // تست ۲: وقتی API خطا میده ولی کش داریم
    // ═══════════════════════════════════════════
    test('should return locally cached data when remote data source throws an error', () async {
      when(() => mockRemoteDataSource.getAgents())
          .thenThrow(Exception('No Internet'));
      when(() => mockLocalDataSource.getLastAgents())
          .thenAnswer((_) async => tAgents);

      final result = await repository.getAgents();

      // ✅ باید Right برگرده (چون از کش خونده)
      result.fold(
        (l) => fail('Should return Right (Cached Data)'),
        (r) => expect(r.length, 2),
      );

      verify(() => mockRemoteDataSource.getAgents()).called(1);
      verify(() => mockLocalDataSource.getLastAgents()).called(1);
    });

    // ═══════════════════════════════════════════
    // تست ۳: وقتی API و کش هر دو خطا میدن
    // ═══════════════════════════════════════════
    test(
      'should return Left(CacheFailure) when remote and local both fail',
      () async {
        when(() => mockRemoteDataSource.getAgents())
            .thenThrow(Exception('No Internet'));
        when(() => mockLocalDataSource.getLastAgents())
            .thenThrow(Exception('No Cache'));

        final result = await repository.getAgents();

        // ✅ باید Left برگرده (دیگه throw نمیکنه)
        result.fold(
          (l) => expect(l, isA<CacheFailure>()),
          (r) => fail('Should return Left (Failure)'),
        );
      },
    );
  });
}
