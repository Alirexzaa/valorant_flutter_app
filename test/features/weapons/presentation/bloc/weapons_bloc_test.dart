import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/weapons/domain/entities/weapon.dart';
import 'package:new_block/features/weapons/domain/usecases/get_weapons_usecase.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_bloc.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_event.dart';
import 'package:new_block/features/weapons/presentation/bloc/weapons_state.dart';

class MockGetWeaponsUseCase extends Mock implements GetWeaponsUseCase {}

void main() {
  late MockGetWeaponsUseCase mockGetWeaponsUseCase;
  late WeaponsBloc bloc;

  const tWeapons = [
    Weapon(id: '1', name: 'Vandal', category: 'Rifle', imageUrl: 'url1'),
    Weapon(id: '2', name: 'Phantom', category: 'Rifle', imageUrl: 'url2'),
  ];

  setUp(() {
    mockGetWeaponsUseCase = MockGetWeaponsUseCase();
    bloc = WeaponsBloc(getWeaponsUseCase: mockGetWeaponsUseCase);
  });

  tearDown(() {
    bloc.close();
  });

  group('WeaponsBloc', () {
    // ═══════════════════════════════════════════
    // تست ۱: State اولیه
    // ═══════════════════════════════════════════
    test('initial state should be WeaponsInitial', () {
      expect(bloc.state, const WeaponsState.initial());
    });

    // ═══════════════════════════════════════════
    // تست ۲: حالت موفقیت (Success)
    // ═══════════════════════════════════════════
    blocTest<WeaponsBloc, WeaponsState>(
      'emits [Loading, Success] when FetchWeaponsEvent is added and UseCase succeeds',
      build: () {
        // ✅ جادوی جدید: به جای return کردن مستقیم لیست، از Right استفاده میکنیم
        when(() => mockGetWeaponsUseCase())
            .thenAnswer((_) async => const Right(tWeapons));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchWeaponsEvent()),
      expect: () => [
        const WeaponsState.loading(),
        const WeaponsState.success(tWeapons),
      ],
    );

    // ═══════════════════════════════════════════
    // تست ۳: حالت خطا (Error)
    // ═══════════════════════════════════════════
    blocTest<WeaponsBloc, WeaponsState>(
      'emits [Loading, Error] when FetchWeaponsEvent is added and UseCase returns Failure',
      build: () {
        // ✅ جادوی جدید: به جای thenThrow، یه Left برمیگردونیم
        when(
          () => mockGetWeaponsUseCase(),
        ).thenAnswer((_) async => const Left(ServerFailure('Network Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(const FetchWeaponsEvent()),
      expect: () => [
        const WeaponsState.loading(),
        const WeaponsState.error('Network Error'), // حالا پیام دقیقا مشخصه
      ],
    );

    // ═══════════════════════════════════════════
    // تست ۴: droppable (جلوگیری از درخواست همزمان)
    // ═══════════════════════════════════════════
    blocTest<WeaponsBloc, WeaponsState>(
      'emits [Loading, Success] only once when event is added twice rapidly',
      build: () {
        // شبیه‌سازی اینترنت کند (۱۰۰ میلی‌ثانیه)
        when(() => mockGetWeaponsUseCase()).thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 100));
          return const Right(tWeapons);
        });
        return bloc;
      },
      act: (bloc) {
        bloc.add(const FetchWeaponsEvent());
        bloc.add(const FetchWeaponsEvent());
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        const WeaponsState.loading(),
        const WeaponsState.success(tWeapons),
      ],
      verify: (_) {
        // چک میکنیم که UseCase فقط ۱ بار صدا زده شده (درخواست دوم drop شده)
        verify(() => mockGetWeaponsUseCase()).called(1);
      },
    );
  });
}
