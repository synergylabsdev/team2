import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:team2/features/auth/domain/entities/user_entity.dart';
import 'package:team2/features/auth/domain/repositories/auth_repository.dart';
import 'package:team2/shared/models/user_role.dart';

/// Generic authentication exception for unmapped errors.
class _GenericAuthException extends AuthException {
  const _GenericAuthException(super.message, [super.code]);
}

/// Implementation of [AuthRepository] using Firebase Auth and Cloud Firestore.
class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl({
    firebase_auth.FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  }) : _auth = auth ?? firebase_auth.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  /// Maps Firebase Auth exceptions to domain exceptions.
  AuthException _mapException(dynamic e) {
    if (e is firebase_auth.FirebaseAuthException) {
      final message = e.message ?? 'An error occurred';
      switch (e.code) {
        case 'email-already-in-use':
          return EmailAlreadyInUseException(message);
        case 'user-not-found':
          return UserNotFoundException(message);
        case 'wrong-password':
          return WrongPasswordException(message);
        case 'user-disabled':
          return UserDisabledException(message);
        case 'too-many-requests':
          return TooManyRequestsException(message);
        case 'operation-not-allowed':
          return OperationNotAllowedException(message);
        case 'invalid-email':
          return InvalidEmailException(message);
        case 'weak-password':
          return WeakPasswordException(message);
        case 'invalid-credential':
        case 'invalid-verification-code':
        case 'invalid-verification-id':
          return InvalidCredentialsException(message);
        case 'network-request-failed':
          return NetworkException(message);
        default:
          return _GenericAuthException(message, e.code);
      }
    }
    if (e is FirebaseException) {
      final message = e.message ?? 'Firestore error occurred';
      if (e.code == 'unavailable' || e.code == 'deadline-exceeded') {
        return NetworkException(message);
      }
      return _GenericAuthException(message, e.code);
    }
    if (e is AuthException) {
      return e;
    }
    return _GenericAuthException(e.toString());
  }

  /// Converts Firestore document snapshot to [UserEntity].
  UserEntity? _documentToEntity(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (!doc.exists || doc.data() == null) return null;

    final data = doc.data()!;
    return UserEntity(
      id: doc.id,
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      role: UserRole.fromString(data['role'] as String? ?? 'seeker'),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Converts [UserEntity] to Firestore document data.
  Map<String, dynamic> _entityToMap(UserEntity entity) {
    return {
      'name': entity.name,
      'email': entity.email,
      'phone': entity.phone,
      'role': entity.role.value,
      'createdAt': Timestamp.fromDate(entity.createdAt),
    };
  }

  @override
  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const UserNotFoundException('User not found after sign in');
      }

      final userDoc = await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      final userEntity = _documentToEntity(userDoc);
      if (userEntity == null) {
        throw const UserNotFoundException('User document not found');
      }

      return userEntity;
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AuthException('Failed to create user');
      }

      final userEntity = UserEntity(
        id: credential.user!.uid,
        name: name,
        email: email,
        phone: phone,
        role: UserRole.fromString(role),
        createdAt: DateTime.now(),
      );

      await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .set(_entityToMap(userEntity));

      return userEntity;
    } catch (e) {
      // If user creation succeeded but Firestore write failed, delete the auth user
      if (e is! firebase_auth.FirebaseAuthException) {
        try {
          await _auth.currentUser?.delete();
        } catch (_) {
          // Ignore deletion errors
        }
      }
      throw _mapException(e);
    }
  }

  @override
  Future<UserEntity> registerJobSeeker({
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
    try {
      // Create Firebase Auth user
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const _GenericAuthException('Failed to create user');
      }

      final userId = credential.user!.uid;
      final now = DateTime.now();

      // Create user document
      final userEntity = UserEntity(
        id: userId,
        name: name,
        email: email,
        phone: phone,
        role: UserRole.seeker,
        createdAt: now,
      );

      // Create job seeker document
      final jobSeekerData = {
        'userId': userId,
        'city': city,
        'zip': zip,
        'languages': languages,
        'certifications': certifications,
        'preferences': preferences,
        'createdAt': Timestamp.fromDate(now),
      };

      // Use batch write for atomicity
      final batch = _firestore.batch();
      batch.set(
        _firestore.collection('users').doc(userId),
        _entityToMap(userEntity),
      );
      batch.set(
        _firestore.collection('job_seekers').doc(userId),
        jobSeekerData,
      );
      await batch.commit();

      return userEntity;
    } catch (e) {
      // If user creation succeeded but Firestore write failed, delete the auth user
      if (e is! firebase_auth.FirebaseAuthException) {
        try {
          await _auth.currentUser?.delete();
        } catch (_) {
          // Ignore deletion errors
        }
      }
      throw _mapException(e);
    }
  }

  @override
  Future<UserEntity> registerEmployer({
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
    try {
      // Create Firebase Auth user
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const _GenericAuthException('Failed to create user');
      }

      final userId = credential.user!.uid;
      final now = DateTime.now();

      // Create user document
      final userEntity = UserEntity(
        id: userId,
        name: name,
        email: email,
        phone: phone,
        role: UserRole.employer,
        createdAt: now,
      );

      // Create employer document
      final employerData = {
        'userId': userId,
        'companyName': companyName,
        'ein': ein,
        'industry': industry,
        'companySize': companySize,
        'address': address,
        if (website != null) 'website': website,
        'createdAt': Timestamp.fromDate(now),
      };

      // Use batch write for atomicity
      final batch = _firestore.batch();
      batch.set(
        _firestore.collection('users').doc(userId),
        _entityToMap(userEntity),
      );
      batch.set(_firestore.collection('employers').doc(userId), employerData);
      await batch.commit();

      return userEntity;
    } catch (e) {
      // If user creation succeeded but Firestore write failed, delete the auth user
      if (e is! firebase_auth.FirebaseAuthException) {
        try {
          await _auth.currentUser?.delete();
        } catch (_) {
          // Ignore deletion errors
        }
      }
      throw _mapException(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) return null;

      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      return _documentToEntity(userDoc);
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<UserEntity?> getUserById(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      return _documentToEntity(userDoc);
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<UserEntity> updateUserProfile({
    String? name,
    String? phone,
    String? email,
  }) async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        throw const UserNotFoundException('No user is currently signed in');
      }

      // Update user document in Firestore
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (phone != null) updates['phone'] = phone;
      if (email != null) updates['email'] = email;

      if (updates.isNotEmpty) {
        await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .update(updates);
      }

      // Fetch updated user document
      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      final userEntity = _documentToEntity(userDoc);
      if (userEntity == null) {
        throw const UserNotFoundException('User document not found');
      }

      return userEntity;
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return _auth.currentUser != null;
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      try {
        final userDoc = await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .get();
        return _documentToEntity(userDoc);
      } catch (e) {
        // Return null on error to avoid breaking the stream
        return null;
      }
    });
  }

  @override
  Stream<UserEntity?> userDataChanges() {
    final firebaseUser = _auth.currentUser;
    if (firebaseUser == null) {
      return Stream.value(null);
    }

    return _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .snapshots()
        .map((snapshot) => _documentToEntity(snapshot));
  }

  @override
  Future<void> deleteAccount() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        throw const UserNotFoundException('No user is currently signed in');
      }

      final userId = firebaseUser.uid;
      final userDoc = await _firestore.collection('users').doc(userId).get();
      final userData = userDoc.data();
      final role = userData?['role'] as String?;

      // Delete role-specific document
      if (role == 'seeker') {
        await _firestore.collection('job_seekers').doc(userId).delete();
      } else if (role == 'employer') {
        await _firestore.collection('employers').doc(userId).delete();
      }

      // Delete user document
      await _firestore.collection('users').doc(userId).delete();

      // Delete Firebase Auth user
      await firebaseUser.delete();
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<void> refreshAuthToken() async {
    try {
      final firebaseUser = _auth.currentUser;
      if (firebaseUser == null) {
        throw const UserNotFoundException('No user is currently signed in');
      }

      await firebaseUser.getIdToken(true);
    } catch (e) {
      throw _mapException(e);
    }
  }
}
