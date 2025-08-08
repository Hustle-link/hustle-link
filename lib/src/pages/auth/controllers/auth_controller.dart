import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

/// Exception type used to carry user-friendly messages to the UI.
class UserFriendlyException implements Exception {
  final String message;
  UserFriendlyException(this.message);
  @override
  String toString() => message;
}

/// An authentication controller that manages the user's authentication state.
///
/// This controller provides methods for user registration, sign-in, sign-out,
/// password reset, and profile creation. It uses the `riverpod_community_mutation`
/// package to handle asynchronous operations and state management.
// TODO(refactor): Consolidate the registration methods into a single, more robust method.
@riverpod
class AuthController extends _$AuthController {
  @override
  AsyncValue<void> build() {
    // Initialize the controller, if needed
    return const AsyncValue.data(null);
  }

  /// Registers a new user with email, password, name, and role.
  ///
  /// This method creates a Firebase Auth account and then creates a corresponding
  /// user profile in Firestore.
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required UserRole role,
  }) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    final firestoreUserService = ref.watch(firestoreUserServiceProvider);

    // Create Firebase Auth account
    final userCredential = await firebaseAuthService
        .registerWithEmailAndPassword(email: email, password: password);

    // Create user profile in Firestore
    if (userCredential.user != null) {
      await firestoreUserService.createUserProfile(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
        role: role,
      );
    }
  }

  /// Registers a new user with email and password.
  ///
  /// This is a legacy method and should be replaced with the more comprehensive
  /// `register` method.
  @Deprecated('Use register method with profile creation instead')
  Future<void> registerLegacy(String email, String password) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    await firebaseAuthService.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs in a user with their email and password.
  Future<void> signIn(String email, String password) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    await firebaseAuthService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// Signs out the currently authenticated user.
  Future<void> signOut() async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    await firebaseAuthService.signOut();
  }

  /// Sends a password reset email to the specified email address.
  Future<void> resetPassword(String email) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    await firebaseAuthService.sendPasswordResetEmail(email: email);
  }

  /// Creates a user profile in Firestore after a user has been authenticated.
  ///
  /// This method is typically called after a user has registered and needs their
  /// profile to be created.
  Future<void> createUserProfile({
    required String name,
    required UserRole role,
  }) async {
    final firebaseAuthService = ref.watch(firebaseAuthServiceProvider);
    final firestoreUserService = ref.watch(firestoreUserServiceProvider);

    final currentUser = firebaseAuthService.currentUser;
    if (currentUser == null) {
      throw UserFriendlyException('No authenticated user found');
    }

    await firestoreUserService.createUserProfile(
      uid: currentUser.uid,
      email: currentUser.email ?? '',
      name: name,
      role: role,
    );
  }
}
