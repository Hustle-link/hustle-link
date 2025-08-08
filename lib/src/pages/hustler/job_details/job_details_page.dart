import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/pages/hustler/job_details/controllers/controllers.dart';
import 'package:sizer/sizer.dart';

class JobDetailsPage extends HookConsumerWidget {
  final String jobId;

  const JobDetailsPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobByIdProvider(jobId));
    final appliedAsync = ref.watch(hasAppliedProvider(jobId));
    final mutation = ref.watch(jobDetailsControllerProvider);

    // Cover letter input handling
    final coverLetterController = useTextEditingController();
    final coverFocus = useFocusNode();

    // Listen for async state side effects (success/error)
    ref.listen<AsyncValue<void>>(jobDetailsControllerProvider, (prev, next) {
      // Show error snack when entering error state
      if (next.hasError) {
        final msg = next.error.toString().replaceFirst('Exception: ', '');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
        return;
      }
      // On transition from loading -> data, treat as success
      final wasLoading = prev?.isLoading == true;
      if (wasLoading && next.hasValue) {
        ref.invalidate(hasAppliedProvider(jobId));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Application submitted successfully!'),
            ),
          );
        }
      }
    });

    // If data loaded but null, show not found state early
    if (jobAsync.hasValue && jobAsync.value == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Job Details')),
        body: const Center(child: Text('Job not found')),
      );
    }

    return jobAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(
        appBar: AppBar(title: const Text('Job Details')),
        body: Center(child: Text('Error: $e')),
      ),
      data: (jobData) {
        if (jobData == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Job Details')),
            body: const Center(child: Text('Job not found')),
          );
        }

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
                // Header
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
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
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
                _SectionTitle('Required Skills'),
                SizedBox(height: 2.h),
                Wrap(
                  spacing: 2.w,
                  runSpacing: 1.h,
                  children: jobData.skillsRequired.map((skill) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 1.h,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        skill,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 4.h),
                _SectionTitle('Details'),
                SizedBox(height: 2.h),
                _InfoRow('Posted', _formatDate(jobData.createdAt)),
                if (jobData.applicationsCount != null)
                  _InfoRow('Applicants', '${jobData.applicationsCount}'),
                if (jobData.deadline != null)
                  _InfoRow('Deadline', _formatDate(jobData.deadline!)),

                SizedBox(height: 6.h),

                // Apply section when not yet applied
                appliedAsync.maybeWhen(
                  data: (hasApplied) => hasApplied
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _SectionTitle('Apply for this job'),
                            SizedBox(height: 2.h),
                            TextField(
                              controller: coverLetterController,
                              focusNode: coverFocus,
                              maxLines: 4,
                              decoration: InputDecoration(
                                hintText: 'Write a cover letter (optional)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                            ),
                            SizedBox(height: 3.h),
                          ],
                        ),
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.w),
            child: appliedAsync.when(
              loading: () => SizedBox(
                height: 6.h,
                child: const Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SizedBox(
                height: 6.h,
                child: Center(child: Text('Error: $e')),
              ),
              data: (hasApplied) {
                if (hasApplied) {
                  return Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 6.h,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: mutation.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            await ref
                                .read(jobDetailsControllerProvider.notifier)
                                .apply(
                                  jobId: jobId,
                                  coverLetter:
                                      coverLetterController.text.trim().isEmpty
                                      ? null
                                      : coverLetterController.text.trim(),
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: mutation.isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Apply Now',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
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
