// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  role: json['role'] as String,
  name: json['name'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  photoUrl: json['photoUrl'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'role': instance.role,
  'name': instance.name,
  'createdAt': instance.createdAt.toIso8601String(),
  'photoUrl': instance.photoUrl,
  'phoneNumber': instance.phoneNumber,
};
