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
      // Validate image before upload
      await _validateProfileImage(imageFile);

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
      // Validate file before upload
      await _validateCertificationFile(certificationFile, fileName);

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
      // Validate file before upload
      await _validateCertificationFileBytes(fileBytes, fileName);

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

  /// Validate certification file before upload
  Future<void> _validateCertificationFile(File file, String fileName) async {
    // Check file size (max 10MB)
    const maxSizeBytes = 10 * 1024 * 1024; // 10MB
    final fileSize = await file.length();

    if (fileSize > maxSizeBytes) {
      throw Exception(
        'File size exceeds 10MB limit. Current size: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)}MB',
      );
    }

    // Check file extension
    final allowedExtensions = ['pdf', 'doc', 'docx'];
    final extension = fileName.toLowerCase().split('.').last;

    if (!allowedExtensions.contains(extension)) {
      throw Exception(
        'Invalid file type. Allowed types: ${allowedExtensions.join(', ')}',
      );
    }

    debugPrint(
      'File validation passed: $fileName (${(fileSize / (1024 * 1024)).toStringAsFixed(2)}MB)',
    );
  }

  /// Validate certification file bytes before upload (for web)
  Future<void> _validateCertificationFileBytes(
    Uint8List fileBytes,
    String fileName,
  ) async {
    // Check file size (max 10MB)
    const maxSizeBytes = 10 * 1024 * 1024; // 10MB
    final fileSize = fileBytes.length;

    if (fileSize > maxSizeBytes) {
      throw Exception(
        'File size exceeds 10MB limit. Current size: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)}MB',
      );
    }

    // Check file extension
    final allowedExtensions = ['pdf', 'doc', 'docx'];
    final extension = fileName.toLowerCase().split('.').last;

    if (!allowedExtensions.contains(extension)) {
      throw Exception(
        'Invalid file type. Allowed types: ${allowedExtensions.join(', ')}',
      );
    }

    debugPrint(
      'File validation passed: $fileName (${(fileSize / (1024 * 1024)).toStringAsFixed(2)}MB)',
    );
  }

  /// Validate profile image before upload
  Future<void> _validateProfileImage(File imageFile) async {
    // Check file size (max 5MB)
    const maxSizeBytes = 5 * 1024 * 1024; // 5MB
    final fileSize = await imageFile.length();

    if (fileSize > maxSizeBytes) {
      throw Exception(
        'Image size exceeds 5MB limit. Current size: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)}MB',
      );
    }

    debugPrint(
      'Image validation passed: ${(fileSize / (1024 * 1024)).toStringAsFixed(2)}MB',
    );
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
