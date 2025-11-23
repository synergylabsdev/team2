import 'package:team2/features/auth/domain/entities/user_entity.dart';

/// Abstract repository interface for authentication operations.
///
/// This repository handles:
/// - Firebase Authentication (sign in, sign up, sign out)
/// - Firestore user document management (users collection)
/// - Role-specific registration (job_seekers, employers collections)
/// - Password reset functionality
/// - Auth state management
abstract class AuthRepository {
  /// Signs in a user with email and password.
  ///
  /// Returns the authenticated [UserEntity] on success.
  /// Throws [AuthException] on failure.
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Creates a new user account with email and password.
  ///
  /// Creates:
  /// - Firebase Auth user
  /// - User document in `users` collection
  ///
  /// Returns the created [UserEntity] on success.
  /// Throws [AuthException] on failure.
  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role, // 'seeker' | 'employer' | 'admin'
  });

  /// Registers a job seeker with complete profile information.
  ///
  /// Creates:
  /// - Firebase Auth user
  /// - User document in `users` collection with role='seeker'
  /// - Job seeker document in `job_seekers` collection
  ///
  /// Returns the created [UserEntity] on success.
  /// Throws [AuthException] on failure.
  Future<UserEntity> registerJobSeeker({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String city,
    required String zip,
    required List<String> languages,
    required List<String> certifications,
    required Map<String, dynamic>
    preferences, // categories, payRange, availability, startImmediately
  });

  /// Registers an employer with complete company information.
  ///
  /// Creates:
  /// - Firebase Auth user
  /// - User document in `users` collection with role='employer'
  /// - Employer document in `employers` collection
  ///
  /// Returns the created [UserEntity] on success.
  /// Throws [AuthException] on failure.
  Future<UserEntity> registerEmployer({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String companyName,
    required String ein,
    required String industry,
    required String companySize,
    required Map<String, String> address, // city, state, zip
    String? website,
  });

  /// Signs out the current user.
  ///
  /// Throws [AuthException] on failure.
  Future<void> signOut();

  /// Gets the currently authenticated user.
  ///
  /// Returns [UserEntity] if user is authenticated, null otherwise.
  /// Throws [AuthException] on failure.
  Future<UserEntity?> getCurrentUser();

  /// Gets user data by user ID from Firestore.
  ///
  /// Returns [UserEntity] if found, null otherwise.
  /// Throws [AuthException] on failure.
  Future<UserEntity?> getUserById(String userId);

  /// Updates the current user's profile information.
  ///
  /// Updates the user document in `users` collection.
  /// Returns the updated [UserEntity] on success.
  /// Throws [AuthException] on failure.
  Future<UserEntity> updateUserProfile({
    String? name,
    String? phone,
    String? email,
  });

  /// Sends a password reset email to the specified email address.
  ///
  /// Throws [AuthException] on failure.
  Future<void> sendPasswordResetEmail(String email);

  /// Checks if a user is currently authenticated.
  ///
  /// Returns true if user is authenticated, false otherwise.
  Future<bool> isAuthenticated();

  /// Stream of authentication state changes.
  ///
  /// Emits [UserEntity] when user signs in, null when user signs out.
  Stream<UserEntity?> authStateChanges();

  /// Stream of current user data from Firestore.
  ///
  /// Emits [UserEntity] when user data changes in Firestore.
  /// Returns null if user is not authenticated.
  Stream<UserEntity?> userDataChanges();

  /// Deletes the current user account.
  ///
  /// Deletes:
  /// - Firebase Auth user
  /// - User document from `users` collection
  /// - Role-specific document (job_seekers or employers)
  ///
  /// Throws [AuthException] on failure.
  Future<void> deleteAccount();

  /// Refreshes the current user's authentication token.
  ///
  /// Throws [AuthException] on failure.
  Future<void> refreshAuthToken();
}

/// Base exception class for authentication errors.
class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException(this.message, [this.code]);

  @override
  String toString() =>
      'AuthException: $message${code != null ? ' (code: $code)' : ''}';
}

/// Exception thrown when email is already in use.
class EmailAlreadyInUseException extends AuthException {
  const EmailAlreadyInUseException([super.message = 'Email is already in use']);
}

/// Exception thrown when user is not found.
class UserNotFoundException extends AuthException {
  const UserNotFoundException([super.message = 'User not found']);
}

/// Exception thrown when wrong password is provided.
class WrongPasswordException extends AuthException {
  const WrongPasswordException([super.message = 'Wrong password']);
}

/// Exception thrown when user account is disabled.
class UserDisabledException extends AuthException {
  const UserDisabledException([super.message = 'User account is disabled']);
}

/// Exception thrown when too many requests are made.
class TooManyRequestsException extends AuthException {
  const TooManyRequestsException([
    super.message = 'Too many requests. Please try again later',
  ]);
}

/// Exception thrown when network error occurs.
class NetworkException extends AuthException {
  const NetworkException([
    super.message = 'Network error. Please check your connection',
  ]);
}

/// Exception thrown when operation is not allowed.
class OperationNotAllowedException extends AuthException {
  const OperationNotAllowedException([super.message = 'Operation not allowed']);
}

/// Exception thrown when invalid credentials are provided.
class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException([
    super.message = 'Invalid email or password',
  ]);
}

/// Exception thrown when weak password is provided.
class WeakPasswordException extends AuthException {
  const WeakPasswordException([super.message = 'Password is too weak']);
}

/// Exception thrown when invalid email format is provided.
class InvalidEmailException extends AuthException {
  const InvalidEmailException([super.message = 'Invalid email format']);
}
