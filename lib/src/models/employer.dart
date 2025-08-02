import 'package:freezed_annotation/freezed_annotation.dart';

part 'employer.freezed.dart';
part 'employer.g.dart';

/// Employer profile model extending user information
@freezed
abstract class Employer with _$Employer {
  const factory Employer({
    required String uid,
    required String email,
    required String name,
    required String companyName,
    required DateTime createdAt,
    String? companyDescription,
    String? website,
    String? location,
    String? phoneNumber,
    String? photoUrl,
    int? postedJobs,
    double? rating,
  }) = _Employer;

  factory Employer.fromJson(Map<String, dynamic> json) =>
      _$EmployerFromJson(json);
}
