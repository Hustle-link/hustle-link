import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_application.freezed.dart';
part 'job_application.g.dart';

// TODO(Kenan): Add a field for employer feedback or reason for rejection.
// TODO(Kenan): Implement notifications for status changes in the application.

/// A data model representing a job application submitted by a hustler.
///
/// This class links a hustler to a specific job posting and tracks the
/// status of their application.
@freezed
abstract class JobApplication with _$JobApplication {
  /// Creates an instance of the [JobApplication] model.
  const factory JobApplication({
    /// The unique identifier for the job application document in Firestore.
    required String id,

    /// The ID of the job being applied for.
    required String jobId,

    /// The unique identifier of the hustler who applied.
    required String hustlerUid,

    /// The unique identifier of the employer who posted the job.
    required String employerUid,

    /// The date and time when the application was submitted.
    required DateTime appliedAt,

    /// The current status of the application.
    required ApplicationStatus status,

    /// The cover letter or message submitted with the application.
    String? coverLetter,

    /// The name of the hustler (denormalized for easy display).
    String? hustlerName,

    /// The title of the job (denormalized for easy display).
    String? jobTitle,

    /// The date and time when the application was reviewed by the employer.
    DateTime? reviewedAt,
  }) = _JobApplication;

  /// Creates a [JobApplication] instance from a JSON object.
  ///
  /// This factory constructor is used for deserializing application data from Firestore.
  factory JobApplication.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationFromJson(json);
}

/// An enumeration representing the possible statuses of a job application.
enum ApplicationStatus {
  /// The application has been submitted but not yet reviewed by the employer.
  pending,

  /// The employer has viewed or opened the application.
  reviewed,

  /// The employer has accepted the application.
  accepted,

  /// The employer has rejected the application.
  rejected;

  /// Gets the string representation of the enum value.
  String get value => name;
}
