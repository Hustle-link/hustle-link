import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_posting.freezed.dart';
part 'job_posting.g.dart';

/// Job posting model
@freezed
abstract class JobPosting with _$JobPosting {
  const factory JobPosting({
    required String id,
    required String employerUid,
    required String title,
    required String description,
    required List<String> skillsRequired,
    required double compensation,
    required DateTime createdAt,
    required JobStatus status,
    String? location,
    String? employerName,
    String? employerCompany,
    DateTime? deadline,
    int? applicationsCount,
  }) = _JobPosting;

  factory JobPosting.fromJson(Map<String, dynamic> json) =>
      _$JobPostingFromJson(json);
}

/// Job status enumeration
enum JobStatus {
  active,
  closed,
  draft;

  String get value => name;
}
