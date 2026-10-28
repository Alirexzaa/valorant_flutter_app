import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/domain/usecases/get_agents_usecase.dart';
import 'package:new_block/features/agents/domain/usecases/toggle_favorite_usecase.dart';
import 'package:new_block/features/agents/domain/usecases/get_favorite_ids_usecase.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';

class MockGetAgentsUseCase extends Mock implements GetAgentsUseCase {}

class MockToggleFavoriteUseCase extends Mock implements ToggleFavoriteUseCase {}

class MockGetFavoriteIdsUseCase extends Mock implements GetFavoriteIdsUseCase {}

void main() {
  late MockGetAgentsUseCase mockGetAgentsUseCase;
  late MockToggleFavoriteUseCase mockToggleFavoriteUseCase;
  late MockGetFavoriteIdsUseCase mockGetFavoriteIdsUseCase;
  late AgentsBloc bloc;

  const tAgents = [
    Agent(id: '1', name: 'Jett', role: 'Duelist', imageUrl: 'url1'),
    Agent(id: '2', name: 'Omen', role: 'Controller', imageUrl: 'url2'),
  ];

  setUp(() {
    mockGetAgentsUseCase = MockGetAgentsUseCase();
    mockToggleFavoriteUseCase = MockToggleFavoriteUseCase();
    mockGetFavoriteIdsUseCase = MockGetFavoriteIdsUseCase();

    bloc = AgentsBloc(
      getAgentsUseCase: mockGetAgentsUseCase,
      toggleFavoriteUseCase: mockToggleFavoriteUseCase,
      getFavoriteIdsUseCase: mockGetFavoriteIdsUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('AgentsBloc', () {
    test('initial state should be AgentsInitial', () {
      expect(bloc.state, const AgentsState.initial());
    });

    blocTest<AgentsBloc, AgentsState>(
      'emits [Loading, Success] when FetchAgentsEvent is added and UseCase succeeds',
      build: () {
        // ✅ اضافه کردن mock برای دریافت لیست علاقه‌مندی‌ها
        when(() => mockGetAgentsUseCase())
            .thenAnswer((_) async => const Right(tAgents));
        when(() => mockGetFavoriteIdsUseCase())
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchAgentsEvent()),
      expect: () => [
        const AgentsState.loading(),
        // ✅ حالا AgentsState.success دو تا پارامتر میگیره: (agents, favoriteIds)
        const AgentsState.success(tAgents, []),
      ],
    );

    blocTest<AgentsBloc, AgentsState>(
      'emits [Loading, Error] when FetchAgentsEvent is added and UseCase returns Failure',
      build: () {
        when(
          () => mockGetAgentsUseCase(),
        ).thenAnswer((_) async => const Left(ServerFailure('Network Error')));
        when(() => mockGetFavoriteIdsUseCase())
            .thenAnswer((_) async => const Right([]));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchAgentsEvent()),
      expect: () => [
        const AgentsState.loading(),
        const AgentsState.error('Network Error'),
      ],
    );
  });
}
