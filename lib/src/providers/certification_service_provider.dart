import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hustle_link/src/models/certification.dart';
import 'package:hustle_link/src/services/certification_service.dart';

part 'certification_service_provider.g.dart';

@Riverpod(keepAlive: true)
CertificationService certificationService(Ref ref) {
  return CertificationService(FirebaseFirestore.instance);
}

@riverpod
Future<List<Certification>> pendingCertifications(Ref ref) {
  final service = ref.watch(certificationServiceProvider);
  return service.getPendingCertifications();
}
