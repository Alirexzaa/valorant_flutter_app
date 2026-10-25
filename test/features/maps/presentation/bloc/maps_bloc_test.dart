import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/maps/domain/entities/map.dart';
import 'package:new_block/features/maps/domain/usecases/get_maps_usecase.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_bloc.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_event.dart';
import 'package:new_block/features/maps/presentation/bloc/maps_state.dart';

class MockGetMapsUseCase extends Mock implements GetMapsUseCase {}

void main() {
  late MockGetMapsUseCase mockGetMapsUseCase;
  late MapsBloc bloc;

  const tMaps = [
    ValorantMap(id: '1', name: 'Gauntlet', imageUrl: 'url1'),
    ValorantMap(id: '2', name: 'Ascent', imageUrl: 'url2'),
  ];

  setUp(() {
    mockGetMapsUseCase = MockGetMapsUseCase();
    bloc = MapsBloc(getMapsUseCase: mockGetMapsUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('MapsBloc', () {
    // ═══════════════════════════════════════════
    // تست ۱: State اولیه
    // ═══════════════════════════════════════════
    test('initial state should be MapsInitial', () {
      expect(bloc.state, const MapsState.initial());
    });

    // ═══════════════════════════════════════════
    // تست ۲: حالت موفقیت (Success)
    // ═══════════════════════════════════════════
    blocTest<MapsBloc, MapsState>(
      'emits [Loading, Success] when FetchMapsEvent is added and UseCase succeeds',
      build: () {
        // ✅ جادوی جدید: به جای return کردن مستقیم لیست، از Right استفاده میکنیم
        when(() => mockGetMapsUseCase())
            .thenAnswer((_) async => const Right(tMaps));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMapsEvent()),
      expect: () => [const MapsState.loading(), const MapsState.success(tMaps)],
    );

    // ═══════════════════════════════════════════
    // تست ۳: حالت خطا (Error)
    // ═══════════════════════════════════════════
    blocTest<MapsBloc, MapsState>(
      'emits [Loading, Error] when FetchMapsEvent is added and UseCase returns Failure',
      build: () {
        // ✅ جادوی جدید: به جای thenThrow، یه Left برمیگردونیم
        when(
          () => mockGetMapsUseCase(),
        ).thenAnswer((_) async => const Left(ServerFailure('Network Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchMapsEvent()),
      expect: () => [
        const MapsState.loading(),
        const MapsState.error('Network Error'), // حالا پیام دقیقا مشخصه
      ],
    );

    // ═══════════════════════════════════════════
    // تست ۴: droppable (جلوگیری از درخواست همزمان)
    // ═══════════════════════════════════════════
    blocTest<MapsBloc, MapsState>(
      'emits [Loading, Success] only once when event is added twice rapidly',
      build: () {
        // شبیه‌سازی اینترنت کند (۱۰۰ میلی‌ثانیه)
        when(() => mockGetMapsUseCase()).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return const Right(tMaps);
        });
        return bloc;
      },
      act: (bloc) {
        bloc.add(const FetchMapsEvent());
        bloc.add(const FetchMapsEvent());
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [const MapsState.loading(), const MapsState.success(tMaps)],
      verify: (_) {
        // چک میکنیم که UseCase فقط ۱ بار صدا زده شده (درخواست دوم drop شده)
        verify(() => mockGetMapsUseCase()).called(1);
      },
    );
  });
}
