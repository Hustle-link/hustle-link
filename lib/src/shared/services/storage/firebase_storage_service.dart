import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageService(this._storage);

  /// Upload profile image and return the download URL
  Future<String> uploadProfileImage(String uid, File imageFile) async {
    try {
      final ref = _storage.ref().child(
        'profile_images/$uid/${DateTime.now().millisecondsSinceEpoch}',
      );
      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('Profile image uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading profile image: $e');
      throw Exception('Failed to upload profile image: $e');
    }
  }

  /// Upload certification file and return the download URL
  Future<String> uploadCertification(
    String uid,
    File certificationFile,
    String fileName,
  ) async {
    try {
      final ref = _storage.ref().child(
        'certifications/$uid/${DateTime.now().millisecondsSinceEpoch}_$fileName',
      );
      final uploadTask = ref.putFile(certificationFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('Certification uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading certification: $e');
      throw Exception('Failed to upload certification: $e');
    }
  }

  /// Upload certification from bytes (for web)
  Future<String> uploadCertificationFromBytes(
    String uid,
    Uint8List fileBytes,
    String fileName,
  ) async {
    try {
      final ref = _storage.ref().child(
        'certifications/$uid/${DateTime.now().millisecondsSinceEpoch}_$fileName',
      );
      final uploadTask = ref.putData(fileBytes);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      debugPrint('Certification uploaded successfully: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      debugPrint('Error uploading certification: $e');
      throw Exception('Failed to upload certification: $e');
    }
  }

  /// Delete file from storage
  Future<void> deleteFile(String downloadUrl) async {
    try {
      final ref = _storage.refFromURL(downloadUrl);
      await ref.delete();
      debugPrint('File deleted successfully: $downloadUrl');
    } catch (e) {
      debugPrint('Error deleting file: $e');
      throw Exception('Failed to delete file: $e');
    }
  }
}

/// Provider for FirebaseStorage instance
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

/// Provider for FirebaseStorageService
final firebaseStorageServiceProvider = Provider<FirebaseStorageService>((ref) {
  final storage = ref.watch(firebaseStorageProvider);
  return FirebaseStorageService(storage);
});
