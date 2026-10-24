import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ایمپورت‌های پروژه
// import 'package:new_block/features/agents/domain/entities/agent.dart';
import 'package:new_block/features/agents/domain/usecases/get_agents_usecase.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_bloc.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_event.dart';
import 'package:new_block/features/agents/presentation/bloc/agents_state.dart';

// ۱. ساخت Mock برای UseCase
class MockGetAgentsUseCase extends Mock implements GetAgentsUseCase {}

void main() {
  late MockGetAgentsUseCase mockGetAgentsUseCase;
  late AgentsBloc bloc;

  // یک لیست ساختگی از ایجنت‌ها برای جواب دادن
  // const tAgents = [
  //   Agent(id: '1', name: 'Jett', role: 'Duelist', imageUrl: 'url1'),
  //   Agent(id: '2', name: 'Omen', role: 'Controller', imageUrl: 'url2'),
  // ];

  setUp(() {
    mockGetAgentsUseCase = MockGetAgentsUseCase();
    // به Bloc، UseCase فیک رو پاس میدیم
    bloc = AgentsBloc(getAgentsUseCase: mockGetAgentsUseCase);
  });

  tearDown(() {
    bloc.close(); // تمیزکاری بعد از هر تست
  });

  group('AgentsBloc', () {
    // ═══════════════════════════════════════════
    // تست ۱: State اولیه
    // ═══════════════════════════════════════════
    // test('initial state should be AgentsInitial', () {
    //   // State اولیه باید AgentsInitial باشه
    //   expect(bloc.state, const AgentsState.initial());
    // });

    // // ═══════════════════════════════════════════
    // // تست ۲: حالت موفقیت (Success)
    // // ═══════════════════════════════════════════
    // blocTest<AgentsBloc, AgentsState>(
    //   'emits [Loading, Success] when FetchAgentsEvent is added and UseCase succeeds',
    //   // وقتی Event فچ اضافه میشه و UseCase موفق میشه،
    //   // باید Loading و سپس Success رو emit کنه
    //   build: () {
    //     // به Mock میگیم وقتی UseCase صدا زده شد، لیست tAgents رو برگردون
    //     when(() => mockGetAgentsUseCase()).thenAnswer((_) async => tAgents);
    //     return bloc;
    //   },
    //   act: (bloc) => bloc.add(const FetchAgentsEvent()),
    //   expect: () => [
    //     const AgentsState.loading(),
    //     const AgentsState.success(tAgents),
    //   ],
    // );

    // ═══════════════════════════════════════════
    // تست ۳: حالت خطا (Error)
    // ═══════════════════════════════════════════
    blocTest<AgentsBloc, AgentsState>(
      'emits [Loading, Error] when FetchAgentsEvent is added and UseCase throws',
      // وقتی Event فچ اضافه میشه و UseCase خطا میده،
      // باید Loading و سپس Error رو emit کنه
      build: () {
        // به Mock میگیم وقتی UseCase صدا زده شد، خطا بده
        when(() => mockGetAgentsUseCase())
            .thenThrow(Exception('Network Error'));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchAgentsEvent()),
      expect: () => [
        const AgentsState.loading(),
        isA<
          AgentsError
        >(), // چون پیام خطا دقیقاً مشخص نیست، فقط نوعش رو چک میکنیم
      ],
    );
    // ═══════════════════════════════════════════
    // test 4 : droppable test
    // ═══════════════════════════════════════════
    // blocTest<AgentsBloc, AgentsState>(
    //   'emits [Loading, Success] only once when event is added twice rapidly',
    //   build: () {
    //     // اینجا به Mock میگیم که 100 میلی‌ثانیه طول بکشه تا جواب بده (شبیه‌سازی اینترنت کند)
    //     when(() => mockGetAgentsUseCase()).thenAnswer((_) async {
    //       await Future.delayed(const Duration(milliseconds: 100));
    //       return tAgents;
    //     });
    //     return bloc;
    //   },
    //   act: (bloc) {
    //     // دو تا درخواست پشت سر هم می‌فرستیم
    //     bloc.add(const FetchAgentsEvent());
    //     bloc.add(const FetchAgentsEvent());
    //   },
    //   // صبر میکنیم تا درخواست اول تموم بشه و بعد نتیجه رو بررسی میکنیم
    //   wait: const Duration(milliseconds: 200),
    //   expect: () => [
    //     const AgentsState.loading(),
    //     const AgentsState.success(tAgents),
    //   ],
    //   verify: (_) {
    //     // حالا این verify صدق میکنه! چون درخواست دوم در حین انجام درخواست اول اومده و drop شده
    //     verify(() => mockGetAgentsUseCase()).called(1);
    //   },
    // );
  });
}
