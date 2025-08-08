import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_posting.freezed.dart';
part 'job_posting.g.dart';

// TODO(Kenan): Add a field for job type (e.g., full-time, part-time, contract).
// TODO(Kenan): Implement a feature for employers to feature or boost their job postings.

/// A data model representing a job posting created by an employer.
///
/// This class contains all the details about a specific job opportunity.
@freezed
abstract class JobPosting with _$JobPosting {
  /// Creates an instance of the [JobPosting] model.
  const factory JobPosting({
    /// The unique identifier for the job posting document in Firestore.
    required String id,

    /// The unique identifier of the employer who created the posting.
    required String employerUid,

    /// The title of the job.
    required String title,

    /// A detailed description of the job, including responsibilities and requirements.
    required String description,

    /// A list of skills required for the job.
    required List<String> skillsRequired,

    /// The compensation or salary for the job.
    required double compensation,

    /// The date and time when the job posting was created.
    required DateTime createdAt,

    /// The current status of the job posting.
    required JobStatus status,

    /// The location where the job is based.
    String? location,

    /// The name of the employer (denormalized for easy display).
    String? employerName,

    /// The company name of the employer (denormalized for easy display).
    String? employerCompany,

    /// The deadline for applying to the job.
    DateTime? deadline,

    /// The number of applications received for this job.
    int? applicationsCount,
  }) = _JobPosting;

  /// Creates a [JobPosting] instance from a JSON object.
  ///
  /// This factory constructor is used for deserializing job posting data from Firestore.
  factory JobPosting.fromJson(Map<String, dynamic> json) =>
      _$JobPostingFromJson(json);
}

/// An enumeration representing the possible statuses of a job posting.
enum JobStatus {
  /// The job is currently open and accepting applications.
  active,

  /// The job is no longer accepting applications.
  closed,

  /// The job posting has been saved as a draft and is not yet visible to hustlers.
  draft;

  /// Gets the string representation of the enum value.
  String get value => name;
}
