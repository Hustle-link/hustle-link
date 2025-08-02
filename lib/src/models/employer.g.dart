// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Employer _$EmployerFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Employer', json, ($checkedConvert) {
      final val = _Employer(
        uid: $checkedConvert('uid', (v) => v as String),
        email: $checkedConvert('email', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        companyName: $checkedConvert('companyName', (v) => v as String),
        createdAt: $checkedConvert(
          'createdAt',
          (v) => DateTime.parse(v as String),
        ),
        companyDescription: $checkedConvert(
          'companyDescription',
          (v) => v as String?,
        ),
        website: $checkedConvert('website', (v) => v as String?),
        location: $checkedConvert('location', (v) => v as String?),
        phoneNumber: $checkedConvert('phoneNumber', (v) => v as String?),
        photoUrl: $checkedConvert('photoUrl', (v) => v as String?),
        postedJobs: $checkedConvert('postedJobs', (v) => (v as num?)?.toInt()),
        rating: $checkedConvert('rating', (v) => (v as num?)?.toDouble()),
      );
      return val;
    });

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
