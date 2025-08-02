import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class JobDetailsPage extends HookConsumerWidget {
  final String jobId;

  const JobDetailsPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobService = ref.watch(firestoreJobServiceProvider);
    final job = useState<JobPosting?>(null);
    final hasApplied = useState<bool>(false);
    final isLoading = useState<bool>(true);
    final isApplying = useState<bool>(false);
    final coverLetterController = useTextEditingController();

    // Load job details
    useEffect(() {
      Future<void> loadJob() async {
        try {
          final jobData = await jobService.getJobById(jobId);
          job.value = jobData;

          if (jobData != null) {
            final currentUser = ref
                .read(firebaseAuthServiceProvider)
                .currentUser;
            if (currentUser != null) {
              final applied = await jobService.hasAppliedForJob(
                jobId,
                currentUser.uid,
              );
              hasApplied.value = applied;
            }
          }
        } catch (e) {
          debugPrint('Error loading job: $e');
        } finally {
          isLoading.value = false;
        }
      }

      loadJob();
      return null;
    }, [jobId]);

    if (isLoading.value) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (job.value == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Job Details')),
        body: const Center(child: Text('Job not found')),
      );
    }

    final jobData = job.value!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobData.title,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  if (jobData.employerCompany != null) ...[
                    SizedBox(height: 1.h),
                    Text(
                      jobData.employerCompany!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '\$${jobData.compensation.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      if (jobData.location != null) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          jobData.location!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 4.h),

            // Job description
            _SectionTitle('About this job'),
            SizedBox(height: 2.h),
            Text(
              jobData.description,
              style: TextStyle(
                fontSize: 16.sp,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            SizedBox(height: 4.h),

            // Required skills
            _SectionTitle('Required Skills'),
            SizedBox(height: 2.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: jobData.skillsRequired.map((skill) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    skill,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 4.h),

            // Job metadata
            _SectionTitle('Details'),
            SizedBox(height: 2.h),
            _InfoRow('Posted', _formatDate(jobData.createdAt)),
            if (jobData.applicationsCount != null)
              _InfoRow('Applicants', '${jobData.applicationsCount}'),
            if (jobData.deadline != null)
              _InfoRow('Deadline', _formatDate(jobData.deadline!)),

            SizedBox(height: 6.h),

            // Application section
            if (!hasApplied.value) ...[
              _SectionTitle('Apply for this job'),
              SizedBox(height: 2.h),
              TextField(
                controller: coverLetterController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write a cover letter (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
            ],
          ],
        ),
      ),
      bottomNavigationBar: hasApplied.value
          ? Container(
              padding: EdgeInsets.all(4.w),
              child: Container(
                width: double.infinity,
                height: 6.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Already Applied',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.all(4.w),
              child: SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: isApplying.value
                      ? null
                      : () async {
                          final currentUser = ref
                              .read(firebaseAuthServiceProvider)
                              .currentUser;
                          final profile = await ref.read(
                            currentHustlerProfileProvider.future,
                          );

                          if (currentUser == null || profile == null) return;

                          isApplying.value = true;
                          try {
                            await jobService.applyForJob(
                              jobId: jobId,
                              hustlerUid: currentUser.uid,
                              employerUid: jobData.employerUid,
                              coverLetter: coverLetterController.text.isEmpty
                                  ? null
                                  : coverLetterController.text,
                              hustlerName: profile.name,
                              jobTitle: jobData.title,
                            );
                            hasApplied.value = true;

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Application submitted successfully!',
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Failed to apply: $e'),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                ),
                              );
                            }
                          } finally {
                            isApplying.value = false;
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isApplying.value
                      ? const CircularProgressIndicator()
                      : Text(
                          'Apply Now',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(width: 2.w),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
