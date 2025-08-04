import 'package:freezed_annotation/freezed_annotation.dart';

part 'hustler.freezed.dart';
part 'hustler.g.dart';

/// Hustler profile model extending user information
@freezed
abstract class Hustler with _$Hustler {
  const factory Hustler({
    required String uid,
    required String email,
    required String name,
    required List<String> skills,
    required DateTime createdAt,
    String? bio,
    String? experience,
    String? location,
    String? phoneNumber,
    String? photoUrl,
    double? rating,
    int? completedJobs,
    @Default([]) List<String> certifications, // URLs to certification files
  }) = _Hustler;

  factory Hustler.fromJson(Map<String, dynamic> json) =>
      _$HustlerFromJson(json);
}
