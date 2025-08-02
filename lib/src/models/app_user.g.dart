// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AppUser', json, ($checkedConvert) {
      final val = _AppUser(
        uid: $checkedConvert('uid', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        role: $checkedConvert('role', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        photoUrl: $checkedConvert('photoUrl', (v) => v as String?),
        phoneNumber: $checkedConvert('phoneNumber', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'role': instance.role,
  'name': instance.name,
  'createdAt': instance.createdAt.toIso8601String(),
  'photoUrl': instance.photoUrl,
  'phoneNumber': instance.phoneNumber,
};
