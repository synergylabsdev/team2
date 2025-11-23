// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
    _$ServerFailureImpl value,
    $Res Function(_$ServerFailureImpl) then,
  ) = __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int? statusCode, String? errorCode});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
    _$ServerFailureImpl _value,
    $Res Function(_$ServerFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = freezed,
    Object? errorCode = freezed,
  }) {
    return _then(
      _$ServerFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ServerFailureImpl extends ServerFailure {
  const _$ServerFailureImpl({
    required this.message,
    this.statusCode,
    this.errorCode,
  }) : super._();

  @override
  final String message;
  @override
  final int? statusCode;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'Failure.server(message: $message, statusCode: $statusCode, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode, errorCode);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) {
    return server(message, statusCode, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) {
    return server?.call(message, statusCode, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, statusCode, errorCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure extends Failure {
  const factory ServerFailure({
    required final String message,
    final int? statusCode,
    final String? errorCode,
  }) = _$ServerFailureImpl;
  const ServerFailure._() : super._();

  @override
  String get message;
  int? get statusCode;
  String? get errorCode;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(
    _$NetworkFailureImpl value,
    $Res Function(_$NetworkFailureImpl) then,
  ) = __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? details});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
    _$NetworkFailureImpl _value,
    $Res Function(_$NetworkFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? details = freezed}) {
    return _then(
      _$NetworkFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkFailureImpl extends NetworkFailure {
  const _$NetworkFailureImpl({required this.message, this.details}) : super._();

  @override
  final String message;
  @override
  final String? details;

  @override
  String toString() {
    return 'Failure.network(message: $message, details: $details)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.details, details) || other.details == details));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, details);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) {
    return network(message, details);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) {
    return network?.call(message, details);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, details);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure extends Failure {
  const factory NetworkFailure({
    required final String message,
    final String? details,
  }) = _$NetworkFailureImpl;
  const NetworkFailure._() : super._();

  @override
  String get message;
  String? get details;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CacheFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$CacheFailureImplCopyWith(
    _$CacheFailureImpl value,
    $Res Function(_$CacheFailureImpl) then,
  ) = __$$CacheFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CacheFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$CacheFailureImpl>
    implements _$$CacheFailureImplCopyWith<$Res> {
  __$$CacheFailureImplCopyWithImpl(
    _$CacheFailureImpl _value,
    $Res Function(_$CacheFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$CacheFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$CacheFailureImpl extends CacheFailure {
  const _$CacheFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.cache(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      __$$CacheFailureImplCopyWithImpl<_$CacheFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) {
    return cache(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) {
    return cache?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return cache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return cache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(this);
    }
    return orElse();
  }
}

abstract class CacheFailure extends Failure {
  const factory CacheFailure({required final String message}) =
      _$CacheFailureImpl;
  const CacheFailure._() : super._();

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$AuthFailureImplCopyWith(
    _$AuthFailureImpl value,
    $Res Function(_$AuthFailureImpl) then,
  ) = __$$AuthFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? code});
}

/// @nodoc
class __$$AuthFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$AuthFailureImpl>
    implements _$$AuthFailureImplCopyWith<$Res> {
  __$$AuthFailureImplCopyWithImpl(
    _$AuthFailureImpl _value,
    $Res Function(_$AuthFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? code = freezed}) {
    return _then(
      _$AuthFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthFailureImpl extends AuthFailure {
  const _$AuthFailureImpl({required this.message, this.code}) : super._();

  @override
  final String message;
  @override
  final String? code;

  @override
  String toString() {
    return 'Failure.auth(message: $message, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, code);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      __$$AuthFailureImplCopyWithImpl<_$AuthFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) {
    return auth(message, code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) {
    return auth?.call(message, code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(message, code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return auth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return auth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (auth != null) {
      return auth(this);
    }
    return orElse();
  }
}

abstract class AuthFailure extends Failure {
  const factory AuthFailure({
    required final String message,
    final String? code,
  }) = _$AuthFailureImpl;
  const AuthFailure._() : super._();

  @override
  String get message;
  String? get code;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthFailureImplCopyWith<_$AuthFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Map<String, String>? errors});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? errors = freezed}) {
    return _then(
      _$ValidationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl extends ValidationFailure {
  const _$ValidationFailureImpl({
    required this.message,
    final Map<String, String>? errors,
  }) : _errors = errors,
       super._();

  @override
  final String message;
  final Map<String, String>? _errors;
  @override
  Map<String, String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableMapView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Failure.validation(message: $message, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) {
    return validation(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) {
    return validation?.call(message, errors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, errors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure extends Failure {
  const factory ValidationFailure({
    required final String message,
    final Map<String, String>? errors,
  }) = _$ValidationFailureImpl;
  const ValidationFailure._() : super._();

  @override
  String get message;
  Map<String, String>? get errors;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$PermissionFailureImplCopyWith(
    _$PermissionFailureImpl value,
    $Res Function(_$PermissionFailureImpl) then,
  ) = __$$PermissionFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? permission});
}

/// @nodoc
class __$$PermissionFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$PermissionFailureImpl>
    implements _$$PermissionFailureImplCopyWith<$Res> {
  __$$PermissionFailureImplCopyWithImpl(
    _$PermissionFailureImpl _value,
    $Res Function(_$PermissionFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? permission = freezed}) {
    return _then(
      _$PermissionFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        permission: freezed == permission
            ? _value.permission
            : permission // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PermissionFailureImpl extends PermissionFailure {
  const _$PermissionFailureImpl({required this.message, this.permission})
    : super._();

  @override
  final String message;
  @override
  final String? permission;

  @override
  String toString() {
    return 'Failure.permission(message: $message, permission: $permission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.permission, permission) ||
                other.permission == permission));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, permission);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      __$$PermissionFailureImplCopyWithImpl<_$PermissionFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) {
    return permission(message, this.permission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) {
    return permission?.call(message, this.permission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(message, this.permission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return permission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return permission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(this);
    }
    return orElse();
  }
}

abstract class PermissionFailure extends Failure {
  const factory PermissionFailure({
    required final String message,
    final String? permission,
  }) = _$PermissionFailureImpl;
  const PermissionFailure._() : super._();

  @override
  String get message;
  String? get permission;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(
    _$UnknownFailureImpl value,
    $Res Function(_$UnknownFailureImpl) then,
  ) = __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
    _$UnknownFailureImpl _value,
    $Res Function(_$UnknownFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$UnknownFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UnknownFailureImpl extends UnknownFailure {
  const _$UnknownFailureImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.unknown(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
      String message,
      int? statusCode,
      String? errorCode,
    )
    server,
    required TResult Function(String message, String? details) network,
    required TResult Function(String message) cache,
    required TResult Function(String message, String? code) auth,
    required TResult Function(String message, Map<String, String>? errors)
    validation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message) unknown,
  }) {
    return unknown(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult? Function(String message, String? details)? network,
    TResult? Function(String message)? cache,
    TResult? Function(String message, String? code)? auth,
    TResult? Function(String message, Map<String, String>? errors)? validation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message)? unknown,
  }) {
    return unknown?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? errorCode)?
    server,
    TResult Function(String message, String? details)? network,
    TResult Function(String message)? cache,
    TResult Function(String message, String? code)? auth,
    TResult Function(String message, Map<String, String>? errors)? validation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(AuthFailure value) auth,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(AuthFailure value)? auth,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(CacheFailure value)? cache,
    TResult Function(AuthFailure value)? auth,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure extends Failure {
  const factory UnknownFailure({required final String message}) =
      _$UnknownFailureImpl;
  const UnknownFailure._() : super._();

  @override
  String get message;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
