import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_block/features/auth/domain/entities/app_user.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success(AppUser user) = AuthSuccess;
  const factory AuthState.error(String message) = AuthError;
}
