// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Certification _$CertificationFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Certification', json, ($checkedConvert) {
  final val = _Certification(
    id: $checkedConvert('id', (v) => v as String),
    userId: $checkedConvert('userId', (v) => v as String),
    fileName: $checkedConvert('fileName', (v) => v as String),
    downloadUrl: $checkedConvert('downloadUrl', (v) => v as String),
    uploadedAt: $checkedConvert(
      'uploadedAt',
      (v) => DateTime.parse(v as String),
    ),
    status: $checkedConvert(
      'status',
      (v) =>
          $enumDecodeNullable(_$CertificationStatusEnumMap, v) ??
          CertificationStatus.pending,
    ),
    verifiedBy: $checkedConvert('verifiedBy', (v) => v as String?),
    verifiedAt: $checkedConvert(
      'verifiedAt',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    rejectionReason: $checkedConvert('rejectionReason', (v) => v as String?),
    expiryDate: $checkedConvert(
      'expiryDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
    certificationType: $checkedConvert(
      'certificationType',
      (v) => v as String?,
    ),
    issuingOrganization: $checkedConvert(
      'issuingOrganization',
      (v) => v as String?,
    ),
    metadata: $checkedConvert('metadata', (v) => v as Map<String, dynamic>?),
  );
  return val;
});

Map<String, dynamic> _$CertificationToJson(_Certification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'fileName': instance.fileName,
      'downloadUrl': instance.downloadUrl,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'status': _$CertificationStatusEnumMap[instance.status]!,
      'verifiedBy': instance.verifiedBy,
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'expiryDate': instance.expiryDate?.toIso8601String(),
      'certificationType': instance.certificationType,
      'issuingOrganization': instance.issuingOrganization,
      'metadata': instance.metadata,
    };

const _$CertificationStatusEnumMap = {
  CertificationStatus.pending: 'pending',
  CertificationStatus.verified: 'verified',
  CertificationStatus.rejected: 'rejected',
  CertificationStatus.expired: 'expired',
};
