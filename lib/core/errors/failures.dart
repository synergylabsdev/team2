import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Base failure class for error handling
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  /// Server-related failures (API errors, 500, etc.)
  const factory Failure.server({
    required String message,
    int? statusCode,
    String? errorCode,
  }) = ServerFailure;

  /// Network-related failures (no internet, timeout, etc.)
  const factory Failure.network({
    required String message,
    String? details,
  }) = NetworkFailure;

  /// Cache-related failures (local storage errors)
  const factory Failure.cache({
    required String message,
  }) = CacheFailure;

  /// Authentication-related failures
  const factory Failure.auth({
    required String message,
    String? code,
  }) = AuthFailure;

  /// Validation failures (form validation errors)
  const factory Failure.validation({
    required String message,
    Map<String, String>? errors,
  }) = ValidationFailure;

  /// Permission-related failures (camera, microphone, etc.)
  const factory Failure.permission({
    required String message,
    String? permission,
  }) = PermissionFailure;

  /// Unknown/unexpected failures
  const factory Failure.unknown({
    required String message,
  }) = UnknownFailure;
}
