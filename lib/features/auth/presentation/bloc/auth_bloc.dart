import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_block/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:new_block/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:new_block/features/auth/domain/usecases/sign_out_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(const AuthState.initial()) {
    on<SignInRequested>((event, emit) async {
      emit(const AuthState.loading());
      final result = await signInUseCase(event.email, event.password);
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (user) => emit(AuthState.success(user)),
      );
    });

    on<SignUpRequested>((event, emit) async {
      emit(const AuthState.loading());
      final result = await signUpUseCase(event.email, event.password);
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (user) => emit(AuthState.success(user)),
      );
    });

    on<SignOutRequested>((event, emit) async {
      emit(const AuthState.loading());
      final result = await signOutUseCase();
      result.fold(
        (failure) => emit(AuthState.error(failure.message)),
        (_) => emit(const AuthState.initial()),
      );
    });
  }
}
