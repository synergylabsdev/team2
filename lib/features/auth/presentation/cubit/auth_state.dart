import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:team2/features/auth/domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

/// Authentication state for the app.
@freezed
class AuthState with _$AuthState {
  /// Initial state - no authentication action has been taken.
  const factory AuthState.initial() = _Initial;

  /// Loading state - authentication action is in progress.
  const factory AuthState.loading() = _Loading;

  /// Authenticated state - user is successfully authenticated.
  const factory AuthState.authenticated(UserEntity user) = _Authenticated;

  /// Unauthenticated state - user is not authenticated.
  const factory AuthState.unauthenticated() = _Unauthenticated;

  /// Error state - authentication action failed.
  const factory AuthState.error(String message) = _Error;
}
