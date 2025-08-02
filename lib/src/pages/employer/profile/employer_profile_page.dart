import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class EmployerProfilePage extends HookConsumerWidget {
  const EmployerProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employerProfile = ref.watch(currentEmployerProfileProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () async {
              await authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: employerProfile.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Profile not found'));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      // Profile Picture Placeholder
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

                // Contact Information
                _InfoSection(
                  title: 'Contact Information',
                  children: [
                    _InfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: profile.email,
                    ),
                    if (profile.phoneNumber != null)
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: profile.phoneNumber!,
                      ),
                    if (profile.location != null)
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        label: 'Location',
                        value: profile.location!,
                      ),
                    if (profile.website != null)
                      _InfoRow(
                        icon: Icons.language_outlined,
                        label: 'Website',
                        value: profile.website!,
                      ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Company Information
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
                ],

                // Statistics
                _InfoSection(
                  title: 'Statistics',
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: 'Jobs Posted',
                            value: '${profile.postedJobs ?? 0}',
                            icon: Icons.work_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: _StatCard(
                            title: 'Rating',
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

                // Account Information
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Error loading profile: $error')),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
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
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
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

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

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
