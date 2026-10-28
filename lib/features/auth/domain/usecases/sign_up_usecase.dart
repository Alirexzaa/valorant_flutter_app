import 'package:fpdart/fpdart.dart';
import 'package:new_block/core/errors/failures.dart';
import 'package:new_block/features/auth/domain/entities/app_user.dart';
import 'package:new_block/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;
  SignUpUseCase(this.repository);

  Future<Either<Failure, AppUser>> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
