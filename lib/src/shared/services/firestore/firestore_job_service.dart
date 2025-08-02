import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';

/// Firestore service for job operations
class FirestoreJobService {
  final FirebaseFirestore _firestore;

  FirestoreJobService(this._firestore);

  /// Collection references
  CollectionReference get _jobsCollection => _firestore.collection('jobs');
  CollectionReference get _applicationsCollection =>
      _firestore.collection('applications');

  /// Create a new job posting
  Future<String> createJobPosting({
    required String employerUid,
    required String title,
    required String description,
    required List<String> skillsRequired,
    required double compensation,
    String? location,
    String? employerName,
    String? employerCompany,
    DateTime? deadline,
  }) async {
    try {
      final docRef = _jobsCollection.doc();
      final jobPosting = JobPosting(
        id: docRef.id,
        employerUid: employerUid,
        title: title,
        description: description,
        skillsRequired: skillsRequired,
        compensation: compensation,
        createdAt: DateTime.now(),
        status: JobStatus.active,
        location: location,
        employerName: employerName,
        employerCompany: employerCompany,
        deadline: deadline,
        applicationsCount: 0,
      );

      await docRef.set(jobPosting.toJson());
      debugPrint('Job posting created with ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating job posting: $e');
      throw Exception('Failed to create job posting: $e');
    }
  }

  /// Get jobs filtered by hustler skills (sorted by creation date, most recent first)
  Stream<List<JobPosting>> getJobsForHustler(List<String> hustlerSkills) {
    try {
      return _jobsCollection
          .where('status', isEqualTo: JobStatus.active.value)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map(
                  (doc) =>
                      JobPosting.fromJson(doc.data() as Map<String, dynamic>),
                )
                .where((job) {
                  // Filter jobs that require at least one skill the hustler has
                  return job.skillsRequired.any(
                    (skill) => hustlerSkills.contains(skill),
                  );
                })
                .toList();
          });
    } catch (e) {
      debugPrint('Error getting jobs for hustler: $e');
      throw Exception('Failed to get jobs: $e');
    }
  }

  /// Get all active jobs (for testing/admin purposes)
  Stream<List<JobPosting>> getAllActiveJobs() {
    try {
      return _jobsCollection
          .where('status', isEqualTo: JobStatus.active.value)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map(
                  (doc) =>
                      JobPosting.fromJson(doc.data() as Map<String, dynamic>),
                )
                .toList();
          });
    } catch (e) {
      debugPrint('Error getting all active jobs: $e');
      throw Exception('Failed to get jobs: $e');
    }
  }

  /// Get jobs posted by employer
  Stream<List<JobPosting>> getJobsByEmployer(String employerUid) {
    try {
      return _jobsCollection
          .where('employerUid', isEqualTo: employerUid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map(
                  (doc) =>
                      JobPosting.fromJson(doc.data() as Map<String, dynamic>),
                )
                .toList();
          });
    } catch (e) {
      debugPrint('Error getting jobs by employer: $e');
      throw Exception('Failed to get employer jobs: $e');
    }
  }

  /// Get single job by ID
  Future<JobPosting?> getJobById(String jobId) async {
    try {
      final doc = await _jobsCollection.doc(jobId).get();
      if (doc.exists) {
        return JobPosting.fromJson(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting job by ID: $e');
      throw Exception('Failed to get job: $e');
    }
  }

  /// Apply for a job
  Future<String> applyForJob({
    required String jobId,
    required String hustlerUid,
    required String employerUid,
    String? coverLetter,
    String? hustlerName,
    String? jobTitle,
  }) async {
    try {
      final docRef = _applicationsCollection.doc();
      final application = JobApplication(
        id: docRef.id,
        jobId: jobId,
        hustlerUid: hustlerUid,
        employerUid: employerUid,
        appliedAt: DateTime.now(),
        status: ApplicationStatus.pending,
        coverLetter: coverLetter,
        hustlerName: hustlerName,
        jobTitle: jobTitle,
      );

      await docRef.set(application.toJson());

      // Update job applications count
      await _jobsCollection.doc(jobId).update({
        'applicationsCount': FieldValue.increment(1),
      });

      debugPrint('Application created with ID: ${docRef.id}');
      return docRef.id;
    } catch (e) {
      debugPrint('Error applying for job: $e');
      throw Exception('Failed to apply for job: $e');
    }
  }

  /// Check if hustler has already applied for a job
  Future<bool> hasAppliedForJob(String jobId, String hustlerUid) async {
    try {
      final querySnapshot = await _applicationsCollection
          .where('jobId', isEqualTo: jobId)
          .where('hustlerUid', isEqualTo: hustlerUid)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking job application: $e');
      return false;
    }
  }

  /// Get applications for a job (for employers)
  Stream<List<JobApplication>> getApplicationsForJob(String jobId) {
    try {
      return _applicationsCollection
          .where('jobId', isEqualTo: jobId)
          .orderBy('appliedAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map(
                  (doc) => JobApplication.fromJson(
                    doc.data() as Map<String, dynamic>,
                  ),
                )
                .toList();
          });
    } catch (e) {
      debugPrint('Error getting applications for job: $e');
      throw Exception('Failed to get applications: $e');
    }
  }

  /// Get applications by hustler
  Stream<List<JobApplication>> getApplicationsByHustler(String hustlerUid) {
    try {
      return _applicationsCollection
          .where('hustlerUid', isEqualTo: hustlerUid)
          .orderBy('appliedAt', descending: true)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map(
                  (doc) => JobApplication.fromJson(
                    doc.data() as Map<String, dynamic>,
                  ),
                )
                .toList();
          });
    } catch (e) {
      debugPrint('Error getting applications by hustler: $e');
      throw Exception('Failed to get applications: $e');
    }
  }

  /// Update job status
  Future<void> updateJobStatus(String jobId, JobStatus newStatus) async {
    try {
      await _jobsCollection.doc(jobId).update({'status': newStatus.value});
      debugPrint('Job status updated for ID: $jobId');
    } catch (e) {
      debugPrint('Error updating job status: $e');
      throw Exception('Failed to update job status: $e');
    }
  }

  /// Delete a job posting
  Future<void> deleteJobPosting(String jobId) async {
    try {
      // First, delete all applications for this job
      final applicationsQuery = await _applicationsCollection
          .where('jobId', isEqualTo: jobId)
          .get();

      final batch = _firestore.batch();

      // Add application deletions to batch
      for (final doc in applicationsQuery.docs) {
        batch.delete(doc.reference);
      }

      // Add job deletion to batch
      batch.delete(_jobsCollection.doc(jobId));

      // Execute batch
      await batch.commit();

      debugPrint('Job posting and related applications deleted for ID: $jobId');
    } catch (e) {
      debugPrint('Error deleting job posting: $e');
      throw Exception('Failed to delete job posting: $e');
    }
  }
}

/// Provider for FirestoreJobService
final firestoreJobServiceProvider = Provider<FirestoreJobService>((ref) {
  final firestore = ref.watch(firestoreInstanceProvider);
  return FirestoreJobService(firestore);
});
