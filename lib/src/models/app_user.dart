import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// AppUser model representing a user in the system
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String uid,
    required String email,
    required String role,
    required String name,
    required DateTime createdAt,
    String? photoUrl,
    String? phoneNumber,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}

/// User roles enumeration
enum UserRole {
  hustler,
  employer;

  String get value => name;
}
