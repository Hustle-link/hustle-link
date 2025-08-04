import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';

/// Firestore service for user operations
class FirestoreUserService {
  final FirebaseFirestore _firestore;

  FirestoreUserService(this._firestore);

  /// Collection references
  CollectionReference get _usersCollection => _firestore.collection('users');
  CollectionReference get _hustlersCollection =>
      _firestore.collection('hustlers');
  CollectionReference get _employersCollection =>
      _firestore.collection('employers');

  /// Create user profile in Firestore
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

  /// Get user profile
  Future<AppUser?> getUserProfile(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (doc.exists) {
        return AppUser.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      throw Exception('Failed to get user profile: $e');
    }
  }

  /// Get hustler profile
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

  /// Get employer profile
  Future<Employer?> getEmployerProfile(String uid) async {
    try {
      final doc = await _employersCollection.doc(uid).get();
      if (doc.exists) {
        return Employer.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting employer profile: $e');
      throw Exception('Failed to get employer profile: $e');
    }
  }

  /// Update hustler skills
  Future<void> updateHustlerSkills(String uid, List<String> skills) async {
    try {
      await _hustlersCollection.doc(uid).update({'skills': skills});
      debugPrint('Hustler skills updated for $uid');
    } catch (e) {
      debugPrint('Error updating hustler skills: $e');
      throw Exception('Failed to update hustler skills: $e');
    }
  }

  /// Update hustler profile
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

  /// Update employer profile
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

/// Provider for FirebaseFirestore instance
final firestoreInstanceProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Provider for FirestoreUserService
final firestoreUserServiceProvider = Provider<FirestoreUserService>((ref) {
  final firestore = ref.watch(firestoreInstanceProvider);
  return FirestoreUserService(firestore);
});
