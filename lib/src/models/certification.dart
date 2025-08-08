import 'package:freezed_annotation/freezed_annotation.dart';

part 'certification.freezed.dart';
part 'certification.g.dart';

/// An enumeration representing the verification status of a certification.
enum CertificationStatus {
  /// The certification has been uploaded but not yet reviewed.
  pending('pending'),

  /// The certification has been reviewed and approved.
  verified('verified'),

  /// The certification has been reviewed and rejected.
  rejected('rejected'),

  /// The certification has passed its expiry date.
  expired('expired');

  /// Creates a [CertificationStatus] with a string value.
  const CertificationStatus(this.value);

  /// The string representation of the status, used for storage in Firestore.
  final String value;

  /// Creates a [CertificationStatus] from a string value.
  ///
  /// Defaults to [pending] if the string does not match any known status.
  static CertificationStatus fromString(String value) {
    return values.firstWhere(
      (status) => status.value == value,
      orElse: () => pending,
    );
  }
}

/// A data model representing a certification uploaded by a user.
///
/// This class includes details about the certification file, its verification
/// status, and other relevant metadata. It uses the `freezed` package for
/// immutability and serialization.
@freezed
abstract class Certification with _$Certification {
  /// Creates a [Certification].
  const factory Certification({
    /// The unique identifier for the certification document.
    required String id,

    /// The UID of the user who uploaded the certification.
    required String userId,

    /// The name of the uploaded file.
    required String fileName,

    /// The public URL to download the certification file from storage.
    required String downloadUrl,

    /// The timestamp when the certification was uploaded.
    required DateTime uploadedAt,

    /// The current verification status of the certification.
    @Default(CertificationStatus.pending) CertificationStatus status,

    /// The ID of the admin or employer who verified the certification.
    String? verifiedBy,

    /// The timestamp when the certification was verified.
    DateTime? verifiedAt,

    /// The reason for rejection, if the status is [rejected].
    String? rejectionReason,

    /// The date when the certification expires, if applicable.
    DateTime? expiryDate,

    /// The type of certification (e.g., 'diploma', 'license').
    String? certificationType,

    /// The name of the organization that issued the certification.
    String? issuingOrganization,

    /// Additional metadata that can be stored as a map.
    Map<String, dynamic>? metadata,
  }) = _Certification;

  /// Creates a [Certification] from a JSON object.
  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);
}

/// Extension methods for the [Certification] class to provide convenient
/// status-checking properties.
extension CertificationStatusExt on Certification {
  /// Returns `true` if the certification status is [pending].
  bool get isPending => status == CertificationStatus.pending;

  /// Returns `true` if the certification status is [verified].
  bool get isVerified => status == CertificationStatus.verified;

  /// Returns `true` if the certification status is [rejected].
  bool get isRejected => status == CertificationStatus.rejected;

  /// Returns `true` if the certification status is [expired].
  bool get isExpired => status == CertificationStatus.expired;

  /// Returns `true` if the certification is pending review.
  bool get needsVerification => isPending;

  /// Returns `true` if the certification is verified and not expired.
  bool get isValid => isVerified && !isExpiredByDate;

  /// Returns `true` if the certification has an expiry date that is in the past.
  bool get isExpiredByDate {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!);
  }
}
