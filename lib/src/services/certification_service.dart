import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hustle_link/src/models/certification.dart';

/// Service for managing certifications and their verification status.
class CertificationService {
  final FirebaseFirestore _firestore;

  CertificationService(this._firestore);

  /// Collection reference for certifications
  CollectionReference<Map<String, dynamic>> get _certificationsRef =>
      _firestore.collection('certifications');

  /// Fetches all certifications with 'pending' status.
  Future<List<Certification>> getPendingCertifications() async {
    final snapshot = await _certificationsRef
        .where('status', isEqualTo: CertificationStatus.pending.value)
        .orderBy('uploadedAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => Certification.fromJson(doc.data()))
        .toList();
  }

  /// Verifies a certification.
  Future<void> verifyCertification({
    required String certificationId,
    required String adminId,
  }) async {
    await _certificationsRef.doc(certificationId).update({
      'status': CertificationStatus.verified.value,
      'verifiedBy': adminId,
      'verifiedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Rejects a certification.
  Future<void> rejectCertification({
    required String certificationId,
    required String reason,
    required String adminId,
  }) async {
    await _certificationsRef.doc(certificationId).update({
      'status': CertificationStatus.rejected.value,
      'rejectionReason': reason,
      'verifiedBy': adminId,
      'verifiedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Fetches a single certification by ID.
  Future<Certification?> getCertification(String id) async {
    final doc = await _certificationsRef.doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return Certification.fromJson(doc.data()!);
  }
}
