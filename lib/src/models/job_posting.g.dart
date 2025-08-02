// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_posting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobPosting _$JobPostingFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_JobPosting', json, ($checkedConvert) {
  final val = _JobPosting(
    id: $checkedConvert('id', (v) => v as String),
    employerUid: $checkedConvert('employerUid', (v) => v as String),
    title: $checkedConvert('title', (v) => v as String),
    description: $checkedConvert('description', (v) => v as String),
    skillsRequired: $checkedConvert(
      'skillsRequired',
      (v) => (v as List<dynamic>).map((e) => e as String).toList(),
    ),
    compensation: $checkedConvert('compensation', (v) => (v as num).toDouble()),
    createdAt: $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
    status: $checkedConvert(
      'status',
      (v) => $enumDecode(_$JobStatusEnumMap, v),
    ),
    location: $checkedConvert('location', (v) => v as String?),
    employerName: $checkedConvert('employerName', (v) => v as String?),
    employerCompany: $checkedConvert('employerCompany', (v) => v as String?),
    deadline: $checkedConvert(
      'deadline',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    applicationsCount: $checkedConvert(
      'applicationsCount',
      (v) => (v as num?)?.toInt(),
    ),
  );
  return val;
});

Map<String, dynamic> _$JobPostingToJson(_JobPosting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employerUid': instance.employerUid,
      'title': instance.title,
      'description': instance.description,
      'skillsRequired': instance.skillsRequired,
      'compensation': instance.compensation,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$JobStatusEnumMap[instance.status]!,
      'location': instance.location,
      'employerName': instance.employerName,
      'employerCompany': instance.employerCompany,
      'deadline': instance.deadline?.toIso8601String(),
      'applicationsCount': instance.applicationsCount,
    };

const _$JobStatusEnumMap = {
  JobStatus.active: 'active',
  JobStatus.closed: 'closed',
  JobStatus.draft: 'draft',
};
