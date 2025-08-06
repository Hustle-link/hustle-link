import 'package:freezed_annotation/freezed_annotation.dart';

part 'certification.freezed.dart';
part 'certification.g.dart';

/// Enumeration for certification verification status
enum CertificationStatus {
  pending('pending'),
  verified('verified'),
  rejected('rejected'),
  expired('expired');

  const CertificationStatus(this.value);
  final String value;

  static CertificationStatus fromString(String value) {
    return values.firstWhere(
      (status) => status.value == value,
      orElse: () => pending,
    );
  }
}

/// Certification model with verification tracking
@freezed
abstract class Certification with _$Certification {
  const factory Certification({
    required String id,
    required String userId,
    required String fileName,
    required String downloadUrl,
    required DateTime uploadedAt,
    @Default(CertificationStatus.pending) CertificationStatus status,
    String? verifiedBy, // Admin/employer ID who verified
    DateTime? verifiedAt,
    String? rejectionReason,
    DateTime? expiryDate, // For time-sensitive certifications
    String? certificationType, // e.g., 'diploma', 'license', 'certificate'
    String? issuingOrganization,
    Map<String, dynamic>? metadata,
  }) = _Certification;

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);
}

/// Extensions for easier status checking
extension CertificationStatusExt on Certification {
  bool get isPending => status == CertificationStatus.pending;
  bool get isVerified => status == CertificationStatus.verified;
  bool get isRejected => status == CertificationStatus.rejected;
  bool get isExpired => status == CertificationStatus.expired;

  bool get needsVerification => isPending;
  bool get isValid => isVerified && !isExpiredByDate;

  bool get isExpiredByDate {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }
}
