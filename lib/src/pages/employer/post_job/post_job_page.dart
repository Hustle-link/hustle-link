import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';
import 'package:go_router/go_router.dart';

/// A page for employers to create a new job posting or edit an existing one.
///
/// This page contains a form with fields for job title, description, skills,
/// compensation, and location. It handles both creation and update logic
/// based on whether a `jobId` is provided as a route extra.
class PostJobPage extends HookConsumerWidget {
  /// Creates a [PostJobPage].
  const PostJobPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Form key to manage form state.
    final formKey = useMemoized(() => GlobalKey<FormState>());
    // Text editing controllers for form fields.
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final compensationController = useTextEditingController();
    final locationController = useTextEditingController();
    final skillsController = useTextEditingController();

    // Focus nodes for better UX, allowing programmatic focus shifts.
    final titleFocus = useFocusNode();
    final descriptionFocus = useFocusNode();
    final skillsFocus = useFocusNode();
    final compensationFocus = useFocusNode();
    final locationFocus = useFocusNode();

    // Access the controller and mutation state for posting/updating a job.
    final controller = ref.read(postJobControllerProvider.notifier);
    final mutation = ref.watch(postJobControllerProvider);
    ref.listen<AsyncValue<void>>(postJobControllerProvider, (prev, next) {
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
      }
    });
    final jobService = ref.watch(firestoreJobServiceProvider);

    // Check if the page is in "edit mode" by looking for a 'editJobId' in the route extras.
    final editJobId = GoRouterState.of(context).extra is Map<String, dynamic>
        ? (GoRouterState.of(context).extra as Map<String, dynamic>)['editJobId']
              as String?
        : null;

    // A ref to track if the form has been prefilled to avoid multiple fetches.
    final isPrefilled = useRef(false);
    // `useEffect` to fetch and prefill job data when in edit mode.
    useEffect(() {
      Future<void> prefill() async {
        if (editJobId == null || isPrefilled.value) return;
        final existing = await jobService.getJobById(editJobId);
        if (existing != null) {
          titleController.text = existing.title;
          descriptionController.text = existing.description;
          compensationController.text = existing.compensation.toStringAsFixed(
            0,
          );
          locationController.text = existing.location ?? '';
          skillsController.text = existing.skillsRequired.join(', ');
          isPrefilled.value = true;
        }
      }

      prefill();
      return null;
    }, [editJobId]);
    // Fetch the current employer's profile.
    final employerProfile = ref.watch(currentEmployerProfileProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editJobId == null
              ? PostJobStrings.postJobTitle
              : PostJobStrings.editJobTitle,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: employerProfile.when(
        data: (profile) {
          // TODO(validation): Add a more user-friendly UI for when the profile is not found.
          if (profile == null) {
            return const Center(child: Text(PostJobStrings.profileNotFound));
          }

          final isSubscribed = profile.subscription?.isActive ?? false;
          final canPostJob = isSubscribed || (profile.postedJobs ?? 0) < 3;

          if (editJobId == null && !canPostJob) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock, size: 48),
                  SizedBox(height: 2.h),
                  const Text('You have reached your free job posting limit.'),
                  SizedBox(height: 1.h),
                  const Text('Subscribe to post unlimited jobs.'),
                  SizedBox(height: 2.h),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.subscription),
                    child: const Text('View Subscriptions'),
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 4.w,
                  right: 4.w,
                  top: 2.h,
                  // Adjust bottom padding to avoid the on-screen keyboard.
                  bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Header
                    Text(
                      editJobId == null
                          ? PostJobStrings.createPostingTitle
                          : PostJobStrings.updatePostingTitle,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      editJobId == null
                          ? PostJobStrings.createPostingSubtitle
                          : PostJobStrings.updatePostingSubtitle,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Job Title Form Field
                    _FormSection(
                      title: PostJobStrings.jobTitle,
                      child: TextFormField(
                        controller: titleController,
                        focusNode: titleFocus,
                        decoration: InputDecoration(
                          hintText: PostJobStrings.jobTitleHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return PostJobStrings.jobTitleRequired;
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        // Move focus to the description field when done.
                        onEditingComplete: () =>
                            descriptionFocus.requestFocus(),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Job Description Form Field
                    _FormSection(
                      title: PostJobStrings.jobDescription,
                      subtitle: PostJobStrings.descriptionSubtitle,
                      child: TextFormField(
                        controller: descriptionController,
                        focusNode: descriptionFocus,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: PostJobStrings.jobDescriptionHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return PostJobStrings.jobDescriptionRequired;
                          }
                          if (value.length < 50) {
                            return PostJobStrings.jobDescriptionTooShort;
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        // Move focus to the skills field when done.
                        onEditingComplete: () => skillsFocus.requestFocus(),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Skills Required Form Field
                    _FormSection(
                      title: PostJobStrings.requiredSkills,
                      subtitle: PostJobStrings.skillsSubtitle,
                      child: TextFormField(
                        controller: skillsController,
                        focusNode: skillsFocus,
                        decoration: InputDecoration(
                          hintText: PostJobStrings.skillsHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return PostJobStrings.skillsRequired;
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        // Move focus to the compensation field when done.
                        onEditingComplete: () =>
                            compensationFocus.requestFocus(),
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Compensation and Location Row
                    Row(
                      children: [
                        Expanded(
                          child: _FormSection(
                            title: PostJobStrings.compensation,
                            child: TextFormField(
                              controller: compensationController,
                              focusNode: compensationFocus,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: PostJobStrings.compensationHint,
                                prefixText: '\$ ',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return PostJobStrings.compensationRequired;
                                }
                                final compensation = double.tryParse(value);
                                if (compensation == null || compensation <= 0) {
                                  return PostJobStrings.invalidAmount;
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              // Move focus to the location field when done.
                              onEditingComplete: () =>
                                  locationFocus.requestFocus(),
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: _FormSection(
                            title: PostJobStrings.location,
                            child: TextFormField(
                              controller: locationController,
                              focusNode: locationFocus,
                              decoration: InputDecoration(
                                hintText: PostJobStrings.locationHint,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              textInputAction: TextInputAction.done,
                              // Unfocus when done to dismiss the keyboard.
                              onEditingComplete: () =>
                                  FocusScope.of(context).unfocus(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton(
                        // Disable button while loading.
                        onPressed: mutation.isLoading
                            ? null
                            : () async {
                                // Validate the form before proceeding.
                                if (!formKey.currentState!.validate()) return;
                                FocusScope.of(context).unfocus();
                                try {
                                  // Differentiate between creating a new job and updating an existing one.
                                  if (editJobId == null) {
                                    await controller.postJob(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      skillsCsv: skillsController.text,
                                      compensationText:
                                          compensationController.text,
                                      location: locationController.text,
                                    );
                                  } else {
                                    await controller.updateJob(
                                      jobId: editJobId,
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      skillsCsv: skillsController.text,
                                      compensationText:
                                          compensationController.text,
                                      location: locationController.text,
                                    );
                                  }
                                  // On success, show a confirmation and navigate back.
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          PostJobStrings.savedMessage,
                                        ),
                                      ),
                                    );
                                    context.go(AppRoutes.employerDashboard);
                                  }
                                } catch (e) {
                                  // On failure, show an error message.
                                  // TODO(error-handling): Provide more specific error messages.
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e.toString().replaceFirst(
                                            'Exception: ',
                                            '',
                                          ),
                                        ),
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.error,
                                      ),
                                    );
                                  }
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        // Show a loading indicator or the appropriate text on the button.
                        child: mutation.isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                editJobId == null
                                    ? PostJobStrings.postJobButton
                                    : PostJobStrings.saveChangesButton,
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
            ),
          );
        },
        // Show a loading indicator while the profile is being fetched.
        loading: () => const Center(child: CircularProgressIndicator()),
        // Show an error message if profile loading fails.
        error: (error, stack) =>
            Center(child: Text('${PostJobStrings.errorLoadingProfile}$error')),
      ),
    );
  }
}

/// A reusable widget to structure form sections with a title, an optional subtitle,
/// and the form field widget itself.
class _FormSection extends StatelessWidget {
  /// The main title of the form section.
  final String title;

  /// An optional subtitle for additional guidance.
  final String? subtitle;

  /// The form field widget (e.g., TextFormField).
  final Widget child;

  /// Creates a [_FormSection].
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
