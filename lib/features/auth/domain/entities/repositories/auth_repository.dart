import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AppUser>> signIn(String email, String password);
  Future<Either<Failure, AppUser>> signUp(String email, String password);
  Future<Either<Failure, void>> signOut();
}
