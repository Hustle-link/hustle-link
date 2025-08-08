import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

// TODO(refactor): Break down this page into smaller, more manageable widgets.

/// A page that displays the employer's profile information.
///
/// It shows the employer's personal and company details, statistics, and a
/// profile completion indicator. It also provides actions to edit the profile
/// and sign out.
class EmployerProfilePage extends HookConsumerWidget {
  /// Creates an [EmployerProfilePage].
  const EmployerProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider that supplies the current employer's profile data.
    final employerProfile = ref.watch(currentEmployerProfileProvider);
    // Read the auth controller to handle sign-out actions.
    final authController = ref.read(authControllerProvider.notifier);

    return employerProfile.when(
      // When profile data is successfully loaded, build the UI.
      data: (profile) {
        // If the profile is null (e.g., not found), show a message.
        // TODO(ux): Provide a way for the user to create a profile if it's missing.
        if (profile == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            body: const Center(child: Text('Profile not found')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            actions: [
              // Button to navigate to the edit profile page.
              IconButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.employerEditProfileRoute,
                    extra: profile.toJson(),
                  );
                },
                icon: const Icon(Icons.edit),
                tooltip: 'Edit Profile',
              ),
              // Button to sign the user out.
              IconButton(
                onPressed: () async {
                  // TODO(ux): Show a confirmation dialog before signing out.
                  await authController.signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // A card that shows the profile completion percentage.
                _EmployerProfileCompletionCard(profile: profile),

                SizedBox(height: 4.h),

                // The main profile header with picture, name, and company.
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Profile Picture or initials.
                      CircleAvatar(
                        radius: 40.sp,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: profile.photoUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(40.sp),
                                child: Image.network(
                                  profile.photoUrl!,
                                  width: 80.sp,
                                  height: 80.sp,
                                  fit: BoxFit.cover,
                                  // TODO(ux): Add loading and error builders for the network image.
                                ),
                              )
                            : Text(
                                profile.name.isNotEmpty
                                    ? profile.name[0].toUpperCase()
                                    : 'E',
                                style: TextStyle(
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                              ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        profile.companyName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 4.h),

                // Section for contact information.
                _InfoSection(
                  title: 'Contact Information',
                  children: [
                    _InfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: profile.email,
                      isEditable: false, // Email is not editable.
                    ),
                    if (profile.phoneNumber != null)
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: profile.phoneNumber!,
                        isEditable: true,
                      ),
                    if (profile.location != null)
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        label: 'Location',
                        value: profile.location!,
                        isEditable: true,
                      ),
                    if (profile.website != null)
                      _InfoRow(
                        icon: Icons.language_outlined,
                        label: 'Website',
                        value: profile.website!,
                        isEditable: true,
                      ),
                    // Prompt to add missing information.
                    if (profile.phoneNumber == null ||
                        profile.location == null ||
                        profile.website == null)
                      _AddInfoPrompt(
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.employerEditProfileRoute,
                            extra: profile.toJson(),
                          );
                        },
                        // Dynamically generates the prompt message.
                        message:
                            'Add ${[if (profile.phoneNumber == null) 'phone number', if (profile.location == null) 'location', if (profile.website == null) 'website'].join(', ')}',
                      ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Section for company information.
                if (profile.companyDescription != null) ...[
                  _InfoSection(
                    title: 'About Company',
                    children: [
                      Text(
                        profile.companyDescription!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                ] else ...[
                  // Prompt to add company description if it's missing.
                  _AddInfoPrompt(
                    onTap: () {
                      context.pushNamed(
                        AppRoutes.employerEditProfileRoute,
                        extra: profile.toJson(),
                      );
                    },
                    message: 'Add a short description about your company',
                  ),
                  SizedBox(height: 4.h),
                ],

                // Section for statistics like jobs posted and rating.
                _InfoSection(
                  title: 'Statistics',
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: 'Jobs Posted',
                            // TODO(data): Ensure this value is kept up-to-date.
                            value: '${profile.postedJobs ?? 0}',
                            icon: Icons.work_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: _StatCard(
                            title: 'Rating',
                            // TODO(data): Implement a real rating system.
                            value: profile.rating != null
                                ? '${profile.rating!.toStringAsFixed(1)}⭐'
                                : 'N/A',
                            icon: Icons.star_outline,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Section for account information.
                _InfoSection(
                  title: 'Account Information',
                  children: [
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Member Since',
                      value:
                          '${profile.createdAt.day}/${profile.createdAt.month}/${profile.createdAt.year}',
                    ),
                    _InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Account Type',
                      value: 'Employer',
                    ),
                  ],
                ),

                SizedBox(height: 6.h),
              ],
            ),
          ),
          // Floating action button to quickly access the edit page.
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.pushNamed(
                AppRoutes.employerEditProfileRoute,
                extra: profile.toJson(),
              );
            },
            tooltip: 'Edit Profile',
            child: const Icon(Icons.edit),
          ),
        );
      },
      // Show a loading indicator while the profile is being fetched.
      loading: () => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      // Show an error message if fetching the profile fails.
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Center(child: Text('Error loading profile: $error')),
      ),
    );
  }
}

/// A reusable widget for displaying a section with a title and child widgets.
class _InfoSection extends StatelessWidget {
  /// The title of the section.
  final String title;

  /// The list of widgets to display within the section.
  final List<Widget> children;

  /// Creates an [_InfoSection].
  const _InfoSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),
        ...children,
      ],
    );
  }
}

/// A reusable widget for displaying a row of information with an icon, label, and value.
class _InfoRow extends StatelessWidget {
  /// The icon to display.
  final IconData icon;

  /// The label for the information.
  final String label;

  /// The value of the information.
  final String value;

  /// Whether to show an "edit" icon, indicating the field can be changed.
  final bool isEditable;

  /// Creates an [_InfoRow].
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isEditable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Icon(icon, size: 20.sp, color: Theme.of(context).colorScheme.primary),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    if (isEditable) ...[
                      SizedBox(width: 1.w),
                      Icon(
                        Icons.edit,
                        size: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.6),
                      ),
                    ],
                  ],
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A card widget for displaying a single statistic.
class _StatCard extends StatelessWidget {
  /// The title of the statistic (e.g., "Jobs Posted").
  final String title;

  /// The value of the statistic (e.g., "12").
  final String value;

  /// The icon representing the statistic.
  final IconData icon;

  /// The color used for the icon and card background.
  final Color color;

  /// Creates a [_StatCard].
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.sp, color: color),
          SizedBox(height: 1.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// A prompt widget that encourages the user to add missing information.
class _AddInfoPrompt extends StatelessWidget {
  /// The callback to execute when the prompt is tapped.
  final VoidCallback onTap;

  /// The message to display in the prompt.
  final String message;

  /// Creates an [_AddInfoPrompt].
  const _AddInfoPrompt({required this.onTap, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              style: BorderStyle.solid,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                size: 20.sp,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A card that displays the employer's profile completion status.
class _EmployerProfileCompletionCard extends StatelessWidget {
  /// The employer's profile data.
  final Employer profile;

  /// Creates an [_EmployerProfileCompletionCard].
  const _EmployerProfileCompletionCard({required this.profile});

  /// Calculates the profile completion percentage based on a few key fields.
  double _calculateCompletionPercentage() {
    int totalFields = 4; // description, phone, location, website
    int completed = 0;
    if (profile.companyDescription != null &&
        profile.companyDescription!.isNotEmpty) {
      completed++;
    }
    if (profile.phoneNumber != null && profile.phoneNumber!.isNotEmpty) {
      completed++;
    }
    if (profile.location != null && profile.location!.isNotEmpty) completed++;
    if (profile.website != null && profile.website!.isNotEmpty) completed++;
    return totalFields == 0 ? 1 : completed / totalFields;
  }

  /// Returns a message based on the completion percentage.
  String _message(double p) {
    if (p == 1.0) return 'Your company profile is complete!';
    if (p >= 0.75) return 'Almost there! Add the remaining details.';
    if (p >= 0.5) return 'Good progress! Add more company info.';
    return 'Complete your company profile to build trust with hustlers.';
  }

  @override
  Widget build(BuildContext context) {
    final p = _calculateCompletionPercentage();
    // If the profile is complete, show a simple success message.
    if (p >= 1.0) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
            SizedBox(width: 3.w),
            Expanded(
              child: Text(
                _message(p),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // If the profile is incomplete, show a detailed card with a progress bar.
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.apartment,
                color: Theme.of(context).colorScheme.primary,
                size: 24.sp,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'Profile Completion',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Text(
                '${(p * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          LinearProgressIndicator(
            value: p,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.outline.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            _message(p),
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 2.h),
          // A button to take the user directly to the edit page.
          InkWell(
            onTap: () {
              context.pushNamed(
                AppRoutes.employerEditProfileRoute,
                extra: profile.toJson(),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 16.sp,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Complete Profile',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
