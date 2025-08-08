import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer.freezed.dart';
part 'employer.g.dart';

// TODO(Kenan): Add review and rating functionality for employers.
// TODO(Kenan): Implement a feature to verify company details.

/// A data model representing an employer user.
///
/// This class encapsulates all the information related to an employer,
/// including their personal details, company information, and job posting history.
@freezed
abstract class Employer with _$Employer {
  /// Creates an instance of the [Employer] model.
  ///
  /// The [uid], [email], [name], [companyName], and [createdAt] fields are required.
  const factory Employer({
    /// The unique identifier for the employer, typically from Firebase Auth.
    required String uid,

    /// The employer's email address.
    required String email,

    /// The full name of the employer or the contact person.
    required String name,

    /// The name of the company the employer represents.
    required String companyName,

    /// The date and time when the employer account was created.
    required DateTime createdAt,

    /// A description of the company.
    String? companyDescription,

    /// The URL of the company's website.
    String? website,

    /// The physical location or address of the company.
    String? location,

    /// The contact phone number for the company.
    String? phoneNumber,

    /// The URL of the company's logo or the employer's profile photo.
    String? photoUrl,

    /// The total number of jobs posted by this employer.
    int? postedJobs,

    /// The average rating of the employer, based on feedback from hustlers.
    double? rating,
  }) = _Employer;

  /// Creates an [Employer] instance from a JSON object.
  ///
  /// This factory constructor is used for deserializing employer data from Firestore.
  factory Employer.fromJson(Map<String, dynamic> json) =>
      _$EmployerFromJson(json);
}
