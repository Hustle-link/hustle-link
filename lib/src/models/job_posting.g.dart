// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_posting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobPosting _$JobPostingFromJson(Map<String, dynamic> json) => _JobPosting(
  id: json['id'] as String,
  employerUid: json['employerUid'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  skillsRequired: (json['skillsRequired'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  compensation: (json['compensation'] as num).toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: $enumDecode(_$JobStatusEnumMap, json['status']),
  location: json['location'] as String?,
  employerName: json['employerName'] as String?,
  employerCompany: json['employerCompany'] as String?,
  deadline: json['deadline'] == null
      ? null
      : DateTime.parse(json['deadline'] as String),
  applicationsCount: (json['applicationsCount'] as num?)?.toInt(),
);

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
