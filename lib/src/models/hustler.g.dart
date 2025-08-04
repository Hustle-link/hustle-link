// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hustler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hustler _$HustlerFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Hustler', json, ($checkedConvert) {
  final val = _Hustler(
    uid: $checkedConvert('uid', (v) => v as String),
    email: $checkedConvert('email', (v) => v as String),
    name: $checkedConvert('name', (v) => v as String),
    skills: $checkedConvert(
      'skills',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    bio: $checkedConvert('bio', (v) => v as String?),
    experience: $checkedConvert('experience', (v) => v as String?),
    location: $checkedConvert('location', (v) => v as String?),
    phoneNumber: $checkedConvert('phoneNumber', (v) => v as String?),
    photoUrl: $checkedConvert('photoUrl', (v) => v as String?),
    rating: $checkedConvert('rating', (v) => (v as num?)?.toDouble()),
    completedJobs: $checkedConvert(
      'completedJobs',
      (v) => (v as num?)?.toInt(),
    ),
    certifications: $checkedConvert(
      'certifications',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    ),
  );
  return val;
});

Map<String, dynamic> _$HustlerToJson(_Hustler instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'name': instance.name,
  'skills': instance.skills,
  'createdAt': instance.createdAt.toIso8601String(),
  'bio': instance.bio,
  'experience': instance.experience,
  'location': instance.location,
  'phoneNumber': instance.phoneNumber,
  'photoUrl': instance.photoUrl,
  'rating': instance.rating,
  'completedJobs': instance.completedJobs,
  'certifications': instance.certifications,
};
