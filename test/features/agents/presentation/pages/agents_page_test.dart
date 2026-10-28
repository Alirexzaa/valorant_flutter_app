import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:new_block/core/widgets/shimmer_loading_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_block/features/agents/presentation/pages/agents_page.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';
import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/core/injection_container.dart' as di;

// ۱. Mock کردن Bloc
class MockAgentsBloc extends MockBloc<AgentsEvent, AgentsState>
    implements AgentsBloc {}

// ۲. ساخت Fake برای Event (برای اینکه any() کار کنه)
class FakeAgentsEvent extends Fake implements AgentsEvent {}

void main() {
  late MockAgentsBloc mockAgentsBloc;

  // ۳. ثبت Fake قبل از شروع تست‌ها
  setUpAll(() {
    registerFallbackValue(FakeAgentsEvent());
  });

  setUp(() {
    mockAgentsBloc = MockAgentsBloc();

    // استاب کردن Stream و add
    when(() => mockAgentsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockAgentsBloc.add(any())).thenAnswer((_) {});

    di.sl.registerFactory<AgentsBloc>(() => mockAgentsBloc);
  });

  tearDown(() {
    di.sl.reset();
  });

  group('AgentsPage Widget Test', () {
    // تست ۱: حالت Loading
    testWidgets('shows CircularProgressIndicator when state is Loading', (
      tester,
    ) async {
      when(() => mockAgentsBloc.state).thenReturn(const AgentsState.loading());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AgentsBloc>.value(
            value: mockAgentsBloc, // ✅ بلوک فیک رو به صفحه تزریق میکنیم
            child: const AgentsPage(),
          ),
        ),
      );
      expect(find.byType(ShimmerLoadingWidget), findsOneWidget);
    });

    // تست ۲: حالت Success
    testWidgets('shows GridView and agent name when state is Success', (
      tester,
    ) async {
      const tAgents = [
        Agent(id: '1', name: 'Jett', role: 'Duelist', imageUrl: 'url1'),
      ];

      when(() => mockAgentsBloc.state)
          .thenReturn(const AgentsState.success(tAgents, []));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AgentsBloc>.value(
            value: mockAgentsBloc, // ✅ بلوک فیک رو به صفحه تزریق میکنیم
            child: const AgentsPage(),
          ),
        ),
      );
      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('Jett'), findsOneWidget);
    });
  });
}
