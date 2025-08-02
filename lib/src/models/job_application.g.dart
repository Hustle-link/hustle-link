// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobApplication _$JobApplicationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_JobApplication', json, ($checkedConvert) {
      final val = _JobApplication(
        id: $checkedConvert('id', (v) => v as String),
        jobId: $checkedConvert('jobId', (v) => v as String),
        hustlerUid: $checkedConvert('hustlerUid', (v) => v as String),
        employerUid: $checkedConvert('employerUid', (v) => v as String),
        appliedAt: $checkedConvert(
          'appliedAt',
          (v) => DateTime.parse(v as String),
        ),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$ApplicationStatusEnumMap, v),
        ),
        coverLetter: $checkedConvert('coverLetter', (v) => v as String?),
        hustlerName: $checkedConvert('hustlerName', (v) => v as String?),
        jobTitle: $checkedConvert('jobTitle', (v) => v as String?),
        reviewedAt: $checkedConvert(
          'reviewedAt',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
      );
      return val;
    });

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
