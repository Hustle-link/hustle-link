import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';

/// A service class for managing job-related operations in Firestore.
///
/// This class provides methods for creating, reading, updating, and deleting
/// job postings and applications.
// TODO(refactor): Separate job and application logic into distinct services for better organization.
class FirestoreJobService {
  final FirebaseFirestore _firestore;

  /// Creates a new instance of [FirestoreJobService].
  FirestoreJobService(this._firestore);

  /// A reference to the 'jobs' collection in Firestore.
  CollectionReference get _jobsCollection => _firestore.collection('jobs');

  /// A reference to the 'applications' collection in Firestore.
  CollectionReference get _applicationsCollection =>
      _firestore.collection('applications');

  /// Creates a new job posting in Firestore.
  ///
  /// Returns the ID of the newly created job posting.
  /// Throws an [Exception] if the operation fails.
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

  /// Retrieves a stream of job postings that match the skills of a hustler.
  ///
  /// [hustlerSkills] A list of skills the hustler possesses.
  ///
  /// The jobs are filtered to be active and are sorted by their creation date in descending order.
  /// Returns a stream of [JobPosting] lists.
  // TODO(optimization): Consider using a more efficient querying method, like array-contains-any, if Firestore supports it well for this use case.
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

  /// Retrieves a stream of all active job postings.
  ///
  /// This method is intended for administrative or testing purposes.
  /// Returns a stream of [JobPosting] lists.
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

  /// Retrieves a stream of job postings created by a specific employer.
  ///
  /// [employerUid] The unique ID of the employer.
  /// Returns a stream of [JobPosting] lists.
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

  /// Retrieves a single job posting by its ID.
  ///
  /// [jobId] The unique ID of the job posting.
  /// Returns a [JobPosting] object if found, otherwise `null`.
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

  /// Creates a job application for a hustler.
  ///
  /// This method also increments the `applicationsCount` on the corresponding job posting.
  /// Returns the ID of the newly created application.
  /// Throws an [Exception] if the operation fails.
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

  /// Checks if a hustler has already applied for a specific job.
  ///
  /// [jobId] The ID of the job.
  /// [hustlerUid] The ID of the hustler.
  /// Returns `true` if an application exists, otherwise `false`.
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

  /// Retrieves a stream of applications for a specific job.
  ///
  /// [jobId] The ID of the job.
  /// This is intended for use by employers.
  /// Returns a stream of [JobApplication] lists.
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

  /// Retrieves a stream of applications submitted by a specific hustler.
  ///
  /// [hustlerUid] The ID of the hustler.
  /// Returns a stream of [JobApplication] lists.
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

  /// Updates the status of a job posting.
  ///
  /// [jobId] The ID of the job to update.
  /// [newStatus] The new [JobStatus] to set.
  Future<void> updateJobStatus(String jobId, JobStatus newStatus) async {
    try {
      await _jobsCollection.doc(jobId).update({'status': newStatus.value});
      debugPrint('Job status updated for ID: $jobId');
    } catch (e) {
      debugPrint('Error updating job status: $e');
      throw Exception('Failed to update job status: $e');
    }
  }

  /// Updates an existing job posting with the provided data.
  ///
  /// Only non-null fields are updated.
  /// [jobId] The ID of the job to update.
  // TODO(validation): Add validation to ensure that the data being updated is valid.
  Future<void> updateJobPosting(
    String jobId, {
    String? title,
    String? description,
    List<String>? skillsRequired,
    double? compensation,
    String? location,
    JobStatus? status,
    DateTime? deadline,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (title != null) data['title'] = title;
      if (description != null) data['description'] = description;
      if (skillsRequired != null) data['skillsRequired'] = skillsRequired;
      if (compensation != null) data['compensation'] = compensation;
      if (location != null) data['location'] = location;
      if (status != null) data['status'] = status.value;
      if (deadline != null) data['deadline'] = deadline;
      // optional updated timestamp
      data['updatedAt'] = FieldValue.serverTimestamp();

      if (data.isEmpty) return; // nothing to update

      await _jobsCollection.doc(jobId).update(data);
      debugPrint('Job posting updated for ID: $jobId');
    } catch (e) {
      debugPrint('Error updating job posting: $e');
      throw Exception('Failed to update job posting: $e');
    }
  }

  /// Deletes a job posting and all its associated applications.
  ///
  /// [jobId] The ID of the job to delete.
  /// This operation is performed in a batch to ensure atomicity.
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

/// Provider for the [FirestoreJobService].
///
/// This provider creates an instance of [FirestoreJobService] and makes it
/// available to the rest of the application.
final firestoreJobServiceProvider = Provider<FirestoreJobService>((ref) {
  final firestore = ref.watch(firestoreInstanceProvider);
  return FirestoreJobService(firestore);
});
