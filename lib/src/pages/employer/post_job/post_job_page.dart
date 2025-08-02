import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class PostJobPage extends HookConsumerWidget {
  const PostJobPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final compensationController = useTextEditingController();
    final locationController = useTextEditingController();
    final skillsController = useTextEditingController();

    final isPosting = useState<bool>(false);
    final jobService = ref.watch(firestoreJobServiceProvider);
    final employerProfile = ref.watch(currentEmployerProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post a Job'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: employerProfile.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Profile not found'));
          }

          return Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Text(
                    'Create a new job posting',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Fill in the details to attract the right talent',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Job Title
                  _FormSection(
                    title: 'Job Title',
                    child: TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'e.g. Senior Flutter Developer',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job title';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Job Description
                  _FormSection(
                    title: 'Job Description',
                    subtitle:
                        'Describe the role, responsibilities, and requirements',
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        hintText: 'Tell us about this job...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job description';
                        }
                        if (value.length < 50) {
                          return 'Description should be at least 50 characters';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Skills Required
                  _FormSection(
                    title: 'Required Skills',
                    subtitle:
                        'Enter skills separated by commas (e.g. Flutter, Dart, Firebase)',
                    child: TextFormField(
                      controller: skillsController,
                      decoration: InputDecoration(
                        hintText: 'Flutter, Dart, Firebase, REST APIs',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter required skills';
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Compensation and Location Row
                  Row(
                    children: [
                      Expanded(
                        child: _FormSection(
                          title: 'Compensation (\$)',
                          child: TextFormField(
                            controller: compensationController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '5000',
                              prefixText: '\$ ',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter compensation';
                              }
                              final compensation = double.tryParse(value);
                              if (compensation == null || compensation <= 0) {
                                return 'Enter a valid amount';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: _FormSection(
                          title: 'Location (Optional)',
                          child: TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                              hintText: 'Remote, New York, etc.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Post Job Button
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: ElevatedButton(
                      onPressed: isPosting.value
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                isPosting.value = true;
                                try {
                                  final currentUser = ref
                                      .read(firebaseAuthServiceProvider)
                                      .currentUser;
                                  if (currentUser == null) return;

                                  // Parse skills from comma-separated string
                                  final skills = skillsController.text
                                      .split(',')
                                      .map((skill) => skill.trim())
                                      .where((skill) => skill.isNotEmpty)
                                      .toList();

                                  await jobService.createJobPosting(
                                    employerUid: currentUser.uid,
                                    title: titleController.text.trim(),
                                    description: descriptionController.text
                                        .trim(),
                                    skillsRequired: skills,
                                    compensation: double.parse(
                                      compensationController.text,
                                    ),
                                    location: locationController.text.isEmpty
                                        ? null
                                        : locationController.text.trim(),
                                    employerName: profile.name,
                                    employerCompany: profile.companyName,
                                  );

                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Job posted successfully!',
                                        ),
                                      ),
                                    );
                                    Navigator.of(
                                      context,
                                    ).pop(); // Go back to dashboard
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Failed to post job: $e'),
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                      ),
                                    );
                                  }
                                } finally {
                                  isPosting.value = false;
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isPosting.value
                          ? const CircularProgressIndicator()
                          : Text(
                              'Post Job',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 4.h),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Error loading profile: $error')),
      ),
    );
  }
}

class _FormSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const _FormSection({required this.title, this.subtitle, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (subtitle != null) ...[
          SizedBox(height: 0.5.h),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
        SizedBox(height: 1.h),
        child,
      ],
    );
  }
}
