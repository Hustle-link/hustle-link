import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';

/// A service class for managing user-related operations in Firestore.
///
/// This class provides methods for creating and retrieving user profiles,
/// including role-specific profiles for Hustlers and Employers.
/// TODO(refactor): Consider splitting this service into smaller, more focused services if it grows too large.
class FirestoreUserService {
  final FirebaseFirestore _firestore;

  /// Creates a new instance of [FirestoreUserService].
  FirestoreUserService(this._firestore);

  /// A reference to the 'users' collection in Firestore.
  CollectionReference get _usersCollection => _firestore.collection('users');

  /// A reference to the 'hustlers' collection in Firestore.
  CollectionReference get _hustlersCollection =>
      _firestore.collection('hustlers');

  /// A reference to the 'employers' collection in Firestore.
  CollectionReference get _employersCollection =>
      _firestore.collection('employers');

  /// Creates a user profile in Firestore, including a base user document
  /// and a role-specific profile.
  ///
  /// [uid] The user's unique ID.
  /// [email] The user's email address.
  /// [name] The user's name.
  /// [role] The user's selected [UserRole].
  Future<void> createUserProfile({
    required String uid,
    required String email,
    required String name,
    required UserRole role,
  }) async {
    try {
      // Create base user document
      final appUser = AppUser(
        uid: uid,
        email: email,
        role: role.value,
        name: name,
        createdAt: DateTime.now(),
      );

      await _usersCollection.doc(uid).set(appUser.toJson());

      // Create role-specific profile
      if (role == UserRole.hustler) {
        final hustler = Hustler(
          uid: uid,
          email: email,
          name: name,
          skills: [], // Empty skills initially
          createdAt: DateTime.now(),
        );
        await _hustlersCollection.doc(uid).set(hustler.toJson());
      } else {
        // Default company name to user name initially
        final employer = Employer(
          uid: uid,
          email: email,
          name: name,
          companyName: name, // Default to user name
          createdAt: DateTime.now(),
        );
        await _employersCollection.doc(uid).set(employer.toJson());
      }

      debugPrint('User profile created for $uid with role: ${role.value}');
    } catch (e) {
      debugPrint('Error creating user profile: $e');
      throw Exception('Failed to create user profile: $e');
    }
  }

  /// Retrieves a user's profile from Firestore.
  ///
  /// [uid] The user's unique ID.
  /// Returns an [AppUser] object if the profile exists, otherwise `null`.
  Future<AppUser?> getUserProfile(String uid) async {
    try {
      debugPrint('Getting user profile for UID: $uid');
      final doc = await _usersCollection.doc(uid).get();
      debugPrint('User document exists: ${doc.exists}');

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        debugPrint('User document data: $data');
        return AppUser.fromJson(data);
      } else {
        debugPrint('No user profile found for UID: $uid');
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Retrieves a hustler's profile from Firestore.
  ///
  /// [uid] The user's unique ID.
  /// Returns a [Hustler] object if the profile exists, otherwise `null`.
  Future<Hustler?> getHustlerProfile(String uid) async {
    try {
      debugPrint('Attempting to get hustler profile for UID: $uid');
      final doc = await _hustlersCollection.doc(uid).get();
      debugPrint('Document exists: ${doc.exists}');

      if (doc.exists) {
        debugPrint(
          'Hustler profile found for $uid and returning it as Hustler ${doc.data()}',
        );
        return Hustler.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        debugPrint('No hustler profile found for UID: $uid');
      }
      return null;
    } catch (e) {
      debugPrint('Error getting hustler profile for UID $uid: $e');
      throw Exception('Failed to get hustler profile: $e');
    }
  }

  /// Retrieves an employer's profile from Firestore.
  ///
  /// [uid] The user's unique ID.
  /// Returns an [Employer] object if the profile exists, otherwise `null`.
  Future<Employer?> getEmployerProfile(String uid) async {
    try {
      debugPrint('Getting employer profile for UID: $uid');
      final doc = await _employersCollection.doc(uid).get();
      debugPrint('Employer document exists: ${doc.exists}');

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        debugPrint('Employer document data: $data');
        return Employer.fromJson(data);
      } else {
        debugPrint('No employer profile found for UID: $uid');
        // Try to create missing employer profile if user exists and has employer role
        await _createMissingEmployerProfile(uid);

        // Try to fetch again after creation
        final newDoc = await _employersCollection.doc(uid).get();
        if (newDoc.exists) {
          final data = newDoc.data() as Map<String, dynamic>;
          debugPrint('Created and retrieved employer profile: $data');
          return Employer.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error getting employer profile: $e');
      throw Exception('Failed to get employer profile: $e');
    }
  }

  /// Creates a missing employer profile if the user exists and has employer role.
  /// This is a helper method to fix missing employer profiles for existing users.
  Future<void> _createMissingEmployerProfile(String uid) async {
    try {
      debugPrint('Attempting to create missing employer profile for: $uid');

      // Check if user exists and has employer role
      final userDoc = await _usersCollection.doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final userRole = userData['role'] as String?;

        debugPrint('User exists with role: $userRole');

        if (userRole == UserRole.employer.value) {
          // Create the missing employer profile
          final employer = Employer(
            uid: uid,
            email: userData['email'] as String,
            name: userData['name'] as String,
            companyName: userData['name'] as String, // Default to user name
            createdAt: DateTime.parse(userData['createdAt'] as String),
          );

          await _employersCollection.doc(uid).set(employer.toJson());
          debugPrint('Successfully created missing employer profile for: $uid');
        } else {
          debugPrint(
            'User role is not employer, cannot create employer profile',
          );
        }
      } else {
        debugPrint('User document not found, cannot create employer profile');
      }
    } catch (e) {
      debugPrint('Error creating missing employer profile: $e');
      // Don't throw, just log the error to avoid breaking the main flow
    }
  }

  /// Updates the base [AppUser] document in Firestore.
  ///
  /// Use this to update fields like [Subscription] or name/email when needed.
  Future<void> updateUser(AppUser user) async {
    try {
      await _usersCollection.doc(user.uid).update(user.toJson());
      debugPrint('User updated for ${user.uid}');
    } catch (e) {
      debugPrint('Error updating user: $e');
      throw Exception('Failed to update user: $e');
    }
  }

  /// Updates the skills of a hustler in Firestore.
  ///
  /// [uid] The hustler's unique ID.
  /// [skills] The new list of skills.
  Future<void> updateHustlerSkills(String uid, List<String> skills) async {
    try {
      await _hustlersCollection.doc(uid).update({'skills': skills});
      debugPrint('Hustler skills updated for $uid');
    } catch (e) {
      debugPrint('Error updating hustler skills: $e');
      throw Exception('Failed to update hustler skills: $e');
    }
  }

  /// Updates a hustler's profile in Firestore.
  ///
  /// [uid] The hustler's unique ID.
  /// [updatedProfile] The updated [Hustler] object.
  Future<void> updateHustlerProfile(String uid, Hustler updatedProfile) async {
    try {
      final profileData = updatedProfile.toJson();
      await _hustlersCollection.doc(uid).update(profileData);
      debugPrint('Hustler profile updated for $uid');
    } catch (e) {
      debugPrint('Error updating hustler profile: $e');
      throw Exception('Failed to update hustler profile: $e');
    }
  }

  /// Updates an employer's profile in Firestore.
  ///
  /// [uid] The employer's unique ID.
  /// [updatedProfile] The updated [Employer] object.
  Future<void> updateEmployerProfile(
    String uid,
    Employer updatedProfile,
  ) async {
    try {
      final profileData = updatedProfile.toJson();
      await _employersCollection.doc(uid).update(profileData);
      debugPrint('Employer profile updated for $uid');
    } catch (e) {
      debugPrint('Error updating employer profile: $e');
      throw Exception('Failed to update employer profile: $e');
    }
  }
}

/// Provider for the [FirebaseFirestore] instance.
final firestoreInstanceProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Provider for the [FirestoreUserService].
///
/// This provider creates an instance of [FirestoreUserService] and makes it
/// available to the rest of the application.
final firestoreUserServiceProvider = Provider<FirestoreUserService>((ref) {
  final firestore = ref.watch(firestoreInstanceProvider);
  return FirestoreUserService(firestore);
});
