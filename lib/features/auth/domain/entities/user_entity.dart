import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:team2/shared/models/user_role.dart';

part 'user_entity.freezed.dart';

/// User entity representing a user in the system.
///
/// This entity corresponds to the `users` collection in Firestore.
/// Document ID is the Firebase Auth UID.
@freezed
abstract class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id, // Firebase Auth UID
    required String name,
    required String email,
    required String phone,
    required UserRole role,
    required DateTime createdAt,
  }) = _UserEntity;
}
