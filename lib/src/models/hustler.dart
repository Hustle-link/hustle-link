import 'package:freezed_annotation/freezed_annotation.dart';

part 'hustler.freezed.dart';
part 'hustler.g.dart';

// TODO(Kenan): Implement a more structured way to store and display experience (e.g., a list of job objects).
// TODO(Kenan): Add a portfolio section where hustlers can showcase their work.

/// A data model representing a "hustler" user (a job seeker or freelancer).
///
/// This class encapsulates all the information related to a hustler,
/// including their personal details, skills, experience, and job history.
@freezed
abstract class Hustler with _$Hustler {
  /// Creates an instance of the [Hustler] model.
  ///
  /// The [uid], [email], [name], [skills], and [createdAt] fields are required.
  const factory Hustler({
    /// The unique identifier for the hustler, typically from Firebase Auth.
    required String uid,

    /// The hustler's email address.
    required String email,

    /// The full name of the hustler.
    required String name,

    /// A list of skills the hustler possesses.
    required List<String> skills,

    /// The date and time when the hustler account was created.
    required DateTime createdAt,

    /// A short biography or summary about the hustler.
    String? bio,

    /// A description of the hustler's work experience.
    String? experience,

    /// The hustler's physical location or address.
    String? location,

    /// The contact phone number for the hustler.
    String? phoneNumber,

    /// The URL of the hustler's profile photo.
    String? photoUrl,

    /// The average rating of the hustler, based on feedback from employers.
    double? rating,

    /// The total number of jobs completed by this hustler.
    int? completedJobs,

    /// A list of URLs pointing to the hustler's certification documents or images.
    @Default([]) List<String> certifications,
  }) = _Hustler;

  /// Creates a [Hustler] instance from a JSON object.
  ///
  /// This factory constructor is used for deserializing hustler data from Firestore.
  factory Hustler.fromJson(Map<String, dynamic> json) =>
      _$HustlerFromJson(json);
}
