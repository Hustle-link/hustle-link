// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Employer _$EmployerFromJson(Map<String, dynamic> json) => _Employer(
  uid: json['uid'] as String,
  email: json['email'] as String,
  name: json['name'] as String,
  companyName: json['companyName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  companyDescription: json['companyDescription'] as String?,
  website: json['website'] as String?,
  location: json['location'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  photoUrl: json['photoUrl'] as String?,
  postedJobs: (json['postedJobs'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
);

Map<String, dynamic> _$EmployerToJson(_Employer instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'name': instance.name,
  'companyName': instance.companyName,
  'createdAt': instance.createdAt.toIso8601String(),
  'companyDescription': instance.companyDescription,
  'website': instance.website,
  'location': instance.location,
  'phoneNumber': instance.phoneNumber,
  'photoUrl': instance.photoUrl,
  'postedJobs': instance.postedJobs,
  'rating': instance.rating,
};
