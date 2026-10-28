import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/auth/domain/entities/app_user.dart';
import 'package:new_block/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;
  SignInUseCase(this.repository);

  Future<Either<Failure, AppUser>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
