import 'package:bloc/bloc.dart';
import 'package:team2/features/auth/domain/repositories/auth_repository.dart';
import 'package:team2/features/auth/presentation/cubit/auth_state.dart';

/// Cubit for managing authentication state and operations.
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState.initial());

  /// Signs in a user with email and password.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthState.authenticated(user));
    } on AuthException catch (e) {
      emit(AuthState.error(e.message));
    } catch (e) {
      emit(AuthState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Signs up a new user with email, password, name, and phone.
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
        phone: phone,
        role: role,
      );
      emit(AuthState.authenticated(user));
    } on AuthException catch (e) {
      emit(AuthState.error(e.message));
    } catch (e) {
      emit(AuthState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    emit(const AuthState.loading());
    try {
      await _authRepository.signOut();
      emit(const AuthState.unauthenticated());
    } on AuthException catch (e) {
      emit(AuthState.error(e.message));
    } catch (e) {
      emit(AuthState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Completes job seeker registration with profile information.
  Future<void> completeJobSeekerRegistration({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String city,
    required String zip,
    required List<String> languages,
    required List<String> certifications,
    required Map<String, dynamic> preferences,
  }) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.registerJobSeeker(
        email: email,
        password: password,
        name: name,
        phone: phone,
        city: city,
        zip: zip,
        languages: languages,
        certifications: certifications,
        preferences: preferences,
      );
      emit(AuthState.authenticated(user));
    } on AuthException catch (e) {
      emit(AuthState.error(e.message));
    } catch (e) {
      emit(AuthState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Completes employer registration with company information.
  Future<void> completeEmployerRegistration({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String companyName,
    required String ein,
    required String industry,
    required String companySize,
    required Map<String, String> address,
    String? website,
  }) async {
    emit(const AuthState.loading());
    try {
      final user = await _authRepository.registerEmployer(
        email: email,
        password: password,
        name: name,
        phone: phone,
        companyName: companyName,
        ein: ein,
        industry: industry,
        companySize: companySize,
        address: address,
        website: website,
      );
      emit(AuthState.authenticated(user));
    } on AuthException catch (e) {
      emit(AuthState.error(e.message));
    } catch (e) {
      emit(AuthState.error('An unexpected error occurred: ${e.toString()}'));
    }
  }

  /// Checks the current authentication state.
  Future<void> checkAuthState() async {
    try {
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthState.authenticated(user));
      } else {
        emit(const AuthState.unauthenticated());
      }
    } on AuthException catch (e) {
      emit(AuthState.error(e.message));
    } catch (e) {
      emit(const AuthState.unauthenticated());
    }
  }
}
