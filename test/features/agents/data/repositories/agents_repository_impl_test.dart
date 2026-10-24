import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:new_block/features/agents/data/datasources/agents_local_data_source.dart';
import 'package:new_block/features/agents/data/datasources/agents_remote_data_source.dart';
import 'package:new_block/features/agents/data/models/agent_model.dart';
import 'package:new_block/features/agents/data/repositories/agents_repository_impl.dart';

// ۱. ساخت Mock برای DataSourceها (چون قرار نیست واقعاً به اینترنت یا دیتابیس وصل بشیم)
class MockAgentsRemoteDataSource extends Mock
    implements AgentsRemoteDataSource {}

class MockAgentsLocalDataSource extends Mock implements AgentsLocalDataSource {}

void main() {
  late MockAgentsRemoteDataSource mockRemoteDataSource;
  late MockAgentsLocalDataSource mockLocalDataSource;
  late AgentsRepositoryImpl repository;

  // داده‌های فیک برای تست
  const tAgents = [
    AgentModel(id: '1', name: 'Jett', role: 'Duelist', imageUrl: 'url1'),
    AgentModel(id: '2', name: 'Omen', role: 'Controller', imageUrl: 'url2'),
  ];

  setUp(() {
    mockRemoteDataSource = MockAgentsRemoteDataSource();
    mockLocalDataSource = MockAgentsLocalDataSource();

    // Repository رو با Mockها می‌سازیم
    repository = AgentsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('AgentsRepositoryImpl', () {
    // ═══════════════════════════════════════════
    // تست ۱: وقتی API موفق میشه، باید دیتا رو کش کنه
    // ═══════════════════════════════════════════
    test('should return remote data when the call to remote data source is successful', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAgents())
          .thenAnswer((_) async => tAgents);
      when(() => mockLocalDataSource.cacheAgents(tAgents))
          .thenAnswer((_) async => {});

      // Act
      final result = await repository.getAgents();

      // Assert
      expect(result, tAgents);
      // چک میکنیم که آیا دیتا کش شده یا نه
      verify(() => mockRemoteDataSource.getAgents()).called(1);
      verify(() => mockLocalDataSource.cacheAgents(tAgents)).called(1);
    });

    // ═══════════════════════════════════════════
    // تست ۲: وقتی API خطا میده، باید از کش بخونه
    // ═══════════════════════════════════════════
    test('should return locally cached data when remote data source throws an error', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAgents())
          .thenThrow(Exception('No Internet'));
      when(() => mockLocalDataSource.getLastAgents())
          .thenAnswer((_) async => tAgents);

      // Act
      final result = await repository.getAgents();

      // Assert
      expect(result, tAgents);
      verify(() => mockRemoteDataSource.getAgents()).called(1);
      verify(() => mockLocalDataSource.getLastAgents()).called(1);
    });

    // ═══════════════════════════════════════════
    // تست ۳: وقتی API خطا میده و کش هم خالیه، باید Exception بده
    // ═══════════════════════════════════════════
    test('should throw an exception when remote and local data sources both throw errors', () async {
      // Arrange
      when(() => mockRemoteDataSource.getAgents())
          .thenThrow(Exception('No Internet'));
      when(() => mockLocalDataSource.getLastAgents())
          .thenThrow(Exception('No Cache'));

      // Act
      final call = repository.getAgents;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
    });
  });
}
