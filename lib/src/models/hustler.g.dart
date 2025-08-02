// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hustler.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hustler _$HustlerFromJson(Map<String, dynamic> json) => _Hustler(
  uid: json['uid'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  skills: (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  bio: json['bio'] as String?,
  experience: json['experience'] as String?,
  location: json['location'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  photoUrl: json['photoUrl'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  completedJobs: (json['completedJobs'] as num?)?.toInt(),
);

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
};
