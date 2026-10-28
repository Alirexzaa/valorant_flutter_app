import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/auth/domain/entities/app_user.dart';
import 'package:new_block/features/auth/domain/repositories/auth_repository.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AppUser>> signIn(String email, String password) async {
    try {
      final user = await remoteDataSource.signIn(email, password);
      return Right(AppUser(uid: user.uid, email: user.email ?? ''));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(_mapAuthError(e.code)));
    } catch (e) {
      // ✅ اینجا ارورهای عجیب مثل همون HTML 403 گوگل رو میگیریم
      return const Left(
        AuthFailure(
          'خطای شبکه یا محدودیت منطقه‌ای. لطفاً VPN خود را روشن کنید.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUp(String email, String password) async {
    try {
      final user = await remoteDataSource.signUp(email, password);
      return Right(AppUser(uid: user.uid, email: user.email ?? ''));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(_mapAuthError(e.code)));
    } catch (e) {
      return const Left(
        AuthFailure(
          'خطای شبکه یا محدودیت منطقه‌ای. لطفاً VPN خود را روشن کنید.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return const Left(AuthFailure('خطا در خروج از حساب کاربری'));
    }
  }

  // ✅ تابعی برای ترجمه ارورهای فایربیس به فارسی
  String _mapAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'کاربری با این ایمیل یافت نشد.';
      case 'wrong-password':
        return 'رمز عبور اشتباه است.';
      case 'email-already-in-use':
        return 'این ایمیل قبلاً ثبت‌نام کرده است.';
      case 'weak-password':
        return 'رمز عبور باید حداقل ۶ کاراکتر باشد.';
      case 'invalid-email':
        return 'فرمت ایمیل وارد شده صحیح نیست.';
      case 'network-request-failed':
        return 'خطای شبکه. لطفاً اتصال اینترنت خود را بررسی کنید.';
      default:
        return 'خطایی رخ داد. لطفاً دوباره تلاش کنید. (کد: $code)';
    }
  }
}
