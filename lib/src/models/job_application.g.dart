// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobApplication _$JobApplicationFromJson(Map<String, dynamic> json) =>
    _JobApplication(
      id: json['id'] as String,
      jobId: json['jobId'] as String,
      hustlerUid: json['hustlerUid'] as String,
      employerUid: json['employerUid'] as String,
      appliedAt: DateTime.parse(json['appliedAt'] as String),
      status: $enumDecode(_$ApplicationStatusEnumMap, json['status']),
      coverLetter: json['coverLetter'] as String?,
      hustlerName: json['hustlerName'] as String?,
      jobTitle: json['jobTitle'] as String?,
      reviewedAt: json['reviewedAt'] == null
          ? null
          : DateTime.parse(json['reviewedAt'] as String),
    );

Map<String, dynamic> _$JobApplicationToJson(_JobApplication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobId': instance.jobId,
      'hustlerUid': instance.hustlerUid,
      'employerUid': instance.employerUid,
      'appliedAt': instance.appliedAt.toIso8601String(),
      'status': _$ApplicationStatusEnumMap[instance.status]!,
      'coverLetter': instance.coverLetter,
      'hustlerName': instance.hustlerName,
      'jobTitle': instance.jobTitle,
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.pending: 'pending',
  ApplicationStatus.reviewed: 'reviewed',
  ApplicationStatus.accepted: 'accepted',
  ApplicationStatus.rejected: 'rejected',
};
