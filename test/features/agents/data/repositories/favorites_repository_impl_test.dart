import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';

import 'package:new_block/features/agents/data/datasources/favorites_remote_data_source.dart';
import 'package:new_block/features/agents/data/repositories/favorites_repository_impl.dart';

// ۱. ساخت Mock برای DataSource
class MockFavoritesRemoteDataSource extends Mock
    implements FavoritesRemoteDataSource {}

void main() {
  late MockFavoritesRemoteDataSource mockRemoteDataSource;
  late FavoritesRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockFavoritesRemoteDataSource();
    repository = FavoritesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group('FavoritesRepositoryImpl', () {
    // ═══════════════════════════════════════════
    // تست ۱: موفقیت در تغییر وضعیت (Toggle)
    // ═══════════════════════════════════════════
    test(
      'should return Right(null) when toggleFavorite is successful',
      () async {
        // چیکار کن؟
        // به Mock بگو وقتی toggleFavorite صدا زده شد، یه Future موفق برگردونه (مثلاً thenAnswer((_) async => {})).
        when(() => mockRemoteDataSource.toggleFavorite('1', true))
            .thenAnswer((_) async => Future.value(null));

        // act:
        final result = await repository.toggleFavorite('1', true);

        // assert:
        expect(result, Right(null));
      },
    );

    // ═══════════════════════════════════════════
    // تست ۲: خطا در تغییر وضعیت (Toggle)
    // ═══════════════════════════════════════════
    test(
      'should return Left(ServerFailure) when toggleFavorite fails',
      () async {
        when(() => mockRemoteDataSource.toggleFavorite('1', true))
            .thenThrow(Exception('Something went wrong'));

        final result = await repository.toggleFavorite('1', true);

        // ✅ چک کردن اینکه Left برگشته و نوعش ServerFailure هست
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, contains('Failed to update favorite'));
        }, (_) => fail('Should have returned Left'));
      },
    );
    // ═══════════════════════════════════════════
    // تست ۳: دریافت لیست علاقه‌مندی‌ها
    // ═══════════════════════════════════════════
    test(
      'should return Left(ServerFailure) when toggleFavorite fails',
      () async {
        when(() => mockRemoteDataSource.toggleFavorite('1', true))
            .thenThrow(Exception('Something went wrong'));

        final result = await repository.toggleFavorite('1', true);

        // ✅ چک کردن اینکه Left برگشته و نوعش ServerFailure هست
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<ServerFailure>());
          expect(failure.message, contains('Failed to update favorite'));
        }, (_) => fail('Should have returned Left'));
      },
    );
  });
}
