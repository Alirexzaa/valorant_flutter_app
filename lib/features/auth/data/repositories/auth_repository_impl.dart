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
      return Left(AuthFailure(e.message ?? 'Authentication Error'));
    } catch (e) {
      return const Left(AuthFailure('Unexpected Error'));
    }
  }

  @override
  Future<Either<Failure, AppUser>> signUp(String email, String password) async {
    try {
      final user = await remoteDataSource.signUp(email, password);
      return Right(AppUser(uid: user.uid, email: user.email ?? ''));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? 'Authentication Error'));
    } catch (e) {
      return const Left(AuthFailure('Unexpected Error'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return const Left(AuthFailure('Failed to sign out'));
    }
  }
}
