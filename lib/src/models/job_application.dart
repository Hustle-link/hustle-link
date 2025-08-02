import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_application.freezed.dart';
part 'job_application.g.dart';

/// Job application model
@freezed
abstract class JobApplication with _$JobApplication {
  const factory JobApplication({
    required String id,
    required String jobId,
    required String hustlerUid,
    required String employerUid,
    required DateTime appliedAt,
    required ApplicationStatus status,
    String? coverLetter,
    String? hustlerName,
    String? jobTitle,
    DateTime? reviewedAt,
  }) = _JobApplication;

  factory JobApplication.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationFromJson(json);
}

/// Application status enumeration
enum ApplicationStatus {
  pending,
  reviewed,
  accepted,
  rejected;

  String get value => name;
}
