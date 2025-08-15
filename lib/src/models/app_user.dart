import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hustle_link/src/models/subscription.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// A data model representing a generic user in the application.
///
/// This class is immutable and uses the `freezed` package to generate
/// boilerplate code for equality, `toString`, and `copyWith` methods, as well
/// as for JSON serialization.
@freezed
abstract class AppUser with _$AppUser {
  /// Creates an [AppUser].
  ///
  /// All fields are required except for [photoUrl] and [phoneNumber].
  const factory AppUser({
    /// The unique identifier for the user, typically from Firebase Auth.
    required String uid,

    /// The user's email address.
    required String email,

    /// The role of the user in the app (e.g., 'hustler' or 'employer').
    required String role,

    /// The display name of the user.
    required String name,

    /// The timestamp when the user account was created.
    required DateTime createdAt,

    /// The URL for the user's profile photo.
    String? photoUrl,

    /// The user's phone number.
    String? phoneNumber,

    /// The user's subscription details.
    Subscription? subscription,
  }) = _AppUser;

  /// Creates an [AppUser] from a JSON object.
  ///
  /// This factory constructor is used for deserializing user data from Firestore.
  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

/// An enumeration of the possible roles a user can have in the application.
enum UserRole {
  /// A user who is looking for jobs.
  hustler,

  /// A user who is posting jobs.
  employer;

  /// Returns the string representation of the enum value.
  String get value => name;
}
