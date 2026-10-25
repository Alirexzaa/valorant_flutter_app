import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart'; // ← برای Right و Left

import 'package:new_block/core/errors/failures.dart'; // ← برای Failure
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/domain/usecases/get_agents_usecase.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';

// ۱. ساخت Mock برای UseCase
class MockGetAgentsUseCase extends Mock implements GetAgentsUseCase {}

void main() {
  late MockGetAgentsUseCase mockGetAgentsUseCase;
  late AgentsBloc bloc;

  // یک لیست ساختگی از ایجنت‌ها
  const tAgents = [
    Agent(id: '1', name: 'Jett', role: 'Duelist', imageUrl: 'url1'),
    Agent(id: '2', name: 'Omen', role: 'Controller', imageUrl: 'url2'),
  ];

  setUp(() {
    mockGetAgentsUseCase = MockGetAgentsUseCase();
    bloc = AgentsBloc(getAgentsUseCase: mockGetAgentsUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('AgentsBloc', () {
    // ═══════════════════════════════════════════
    // تست ۱: State اولیه
    // ═══════════════════════════════════════════
    test('initial state should be AgentsInitial', () {
      expect(bloc.state, const AgentsState.initial());
    });

    // ═══════════════════════════════════════════
    // تست ۲: حالت موفقیت (Success)
    // ═══════════════════════════════════════════
    blocTest<AgentsBloc, AgentsState>(
      'emits [Loading, Success] when FetchAgentsEvent is added and UseCase succeeds',
      build: () {
        // ✅ جادوی جدید: به جای return کردن مستقیم لیست، از Right استفاده میکنیم
        when(() => mockGetAgentsUseCase())
            .thenAnswer((_) async => const Right(tAgents));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchAgentsEvent()),
      expect: () => [
        const AgentsState.loading(),
        const AgentsState.success(tAgents),
      ],
    );

    // ═══════════════════════════════════════════
    // تست ۳: حالت خطا (Error)
    // ═══════════════════════════════════════════
    blocTest<AgentsBloc, AgentsState>(
      'emits [Loading, Error] when FetchAgentsEvent is added and UseCase returns Failure',
      build: () {
        // ✅ جادوی جدید: به جای thenThrow، یه Left برمیگردونیم
        when(
          () => mockGetAgentsUseCase(),
        ).thenAnswer((_) async => const Left(ServerFailure('Network Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchAgentsEvent()),
      expect: () => [
        const AgentsState.loading(),
        const AgentsState.error('Network Error'), // حالا پیام دقیقا مشخصه
      ],
    );

    // ═══════════════════════════════════════════
    // تست ۴: droppable (جلوگیری از درخواست همزمان)
    // ═══════════════════════════════════════════
    blocTest<AgentsBloc, AgentsState>(
      'emits [Loading, Success] only once when event is added twice rapidly',
      build: () {
        // شبیه‌سازی اینترنت کند (۱۰۰ میلی‌ثانیه)
        when(() => mockGetAgentsUseCase()).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return const Right(tAgents);
        });
        return bloc;
      },
      act: (bloc) {
        bloc.add(const FetchAgentsEvent());
        bloc.add(const FetchAgentsEvent());
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        const AgentsState.loading(),
        const AgentsState.success(tAgents),
      ],
      verify: (_) {
        // چک میکنیم که UseCase فقط ۱ بار صدا زده شده (درخواست دوم drop شده)
        verify(() => mockGetAgentsUseCase()).called(1);
      },
    );
  });
}
