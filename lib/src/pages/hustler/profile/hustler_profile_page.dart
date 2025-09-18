import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class HustlerProfilePage extends HookConsumerWidget {
  const HustlerProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final hustlerProfile = ref.watch(currentHustlerProfileProvider);
    // Watch the current user profile to get subscription information
    final userProfile = ref.watch(currentUserProfileProvider);
    final authController = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        backgroundColor: Theme.of(context).colorScheme.surface,
        actions: [
          IconButton(
            onPressed: () async {
              final profileData = await ref.read(
                currentHustlerProfileProvider.future,
              );
              if (profileData != null) {
                context.pushNamed(
                  AppRoutes.hustlerEditProfileRoute,
                  extra: profileData.toJson(),
                );
              }
            },
            icon: const Icon(Icons.edit),
            tooltip: l10n.editProfile,
          ),
          IconButton(
            onPressed: () async {
              await authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: hustlerProfile.when(
        data: (profile) {
          if (profile == null) {
            return Center(child: Text(l10n.profileNotFound));
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Completion Indicator
                _ProfileCompletionCard(profile: profile),

                SizedBox(height: 4.h),

                // Profile Header
                _ProfileHeader(profile: profile),

                SizedBox(height: 4.h),

                // Contact Information
                _InfoSection(
                  title: l10n.contactInformation,
                  children: [
                    _InfoRow(
                      icon: Icons.email_outlined,
                      label: l10n.emailLabel,
                      value: profile.email,
                      isEditable: false, // Email usually shouldn't be editable
                    ),
                    if (profile.phoneNumber != null)
                      _InfoRow(
                        icon: Icons.phone_outlined,
                        label: l10n.phone,
                        value: profile.phoneNumber!,
                        isEditable: true,
                      ),
                    if (profile.location != null)
                      _InfoRow(
                        icon: Icons.location_on_outlined,
                        label: l10n.location,
                        value: profile.location!,
                        isEditable: true,
                      ),
                    if (profile.phoneNumber == null || profile.location == null)
                      _AddInfoPrompt(
                        onTap: () async {
                          context.pushNamed(
                            AppRoutes.hustlerEditProfileRoute,
                            extra: profile.toJson(),
                          );
                        },
                        message:
                            '${l10n.addPhoneNumberAndLocation}${profile.phoneNumber == null && profile.location == null
                                ? ''
                                : profile.phoneNumber == null
                                ? l10n.addPhoneNumber
                                : l10n.addLocation}',
                      ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Skills
                _InfoSection(
                  title: l10n.skills,
                  children: [
                    if (profile.skills.isNotEmpty) ...[
                      Wrap(
                        spacing: 2.w,
                        runSpacing: 1.h,
                        children: profile.skills.map((skill) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 1.h,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary
                                    .withAlpha((0.3 * 255).toInt()),
                              ),
                            ),
                            child: Text(
                              skill,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ] else ...[
                      _AddInfoPrompt(
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.hustlerEditProfileRoute,
                            extra: profile.toJson(),
                          );
                        },
                        message: l10n.addYourSkills,
                      ),
                    ],
                  ],
                ),

                SizedBox(height: 4.h),

                // Statistics
                _InfoSection(
                  title: l10n.statistics,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _StatCard(
                            title: l10n.jobsCompleted,
                            value: '${profile.completedJobs ?? 0}',
                            icon: Icons.check_circle_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: _StatCard(
                            title: l10n.rating,
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

                // Experience
                _InfoSection(
                  title: l10n.experience,
                  children: [
                    if (profile.experience != null) ...[
                      Text(
                        profile.experience!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ] else ...[
                      _AddInfoPrompt(
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.hustlerEditProfileRoute,
                            extra: profile.toJson(),
                          );
                        },
                        message: l10n.addYourWorkExperience,
                      ),
                    ],
                  ],
                ),

                SizedBox(height: 4.h),

                // Account Information
                _InfoSection(
                  title: l10n.account,
                  children: [
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: l10n.memberSince,
                      value:
                          '${profile.createdAt.day}/${profile.createdAt.month}/${profile.createdAt.year}',
                    ),
                    _InfoRow(
                      icon: Icons.badge_outlined,
                      label: l10n.accountType,
                      value: l10n.hustler,
                    ),
                  ],
                ),

                SizedBox(height: 4.h),

                // Subscription Status
                userProfile.when(
                  data: (user) =>
                      SubscriptionStatusCard(subscription: user?.subscription),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),

                SizedBox(height: 4.h),

                // Support and Logout Section
                _buildSupportSection(context, ref),

                SizedBox(height: 6.h),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text(l10n.errorLoadingProfile(error.toString()))),
      ),
    );
  }

  Widget _buildSupportSection(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final currentLocale = ref.watch(localeNotifierProvider);
    final localeNotifier = ref.read(localeNotifierProvider.notifier);

    return _InfoSection(
      title: l10n.supportAndActions,
      children: [
        ListTile(
          leading: const Icon(Icons.subscriptions),
          title: Text(l10n.subscriptions),
          onTap: () => context.push(AppRoutes.subscription),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(l10n.language),
          trailing: DropdownButton<Locale>(
            value: currentLocale,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                localeNotifier.setLocale(newLocale);
              }
            },
            items: [
              DropdownMenuItem(
                value: const Locale('en'),
                child: Text(l10n.english),
              ),
              DropdownMenuItem(
                value: const Locale('tn'),
                child: Text(l10n.setswana),
              ),
            ],
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: Text(l10n.contactSupport),
          subtitle: Text(l10n.getHelpAndSendFeedback),
          onTap: () async {
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'hustlelink05@gmail.com',
              queryParameters: {'subject': 'Support Request - HustleLink App'},
            );

            if (await canLaunchUrl(emailLaunchUri)) {
              await launchUrl(emailLaunchUri);
            } else {
              // Fallback for web or if no email client is available
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Could not open email client. Please email hustlelink05@gmail.com',
                  ),
                ),
              );
            }
          },
        ),
        const Divider(),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(
            l10n.logout,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
          onTap: () async {
            await ref.read(authControllerProvider.notifier).signOut();
          },
        ),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final Hustler profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
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
                        : 'H',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
          ),
          SizedBox(height: 2.h),
          Text(
            profile.name,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          if (profile.bio != null) ...[
            SizedBox(height: 0.5.h),
            Text(
              profile.bio!,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(
                  context,
                ).colorScheme.onPrimaryContainer.withAlpha((0.8 * 255).toInt()),
              ),
              textAlign: TextAlign.center,
            ),
          ] else ...[
            SizedBox(height: 0.5.h),
            InkWell(
              onTap: () {
                context.pushNamed(
                  AppRoutes.hustlerEditProfileRoute,
                  extra: profile.toJson(),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha((0.1 * 255).toInt()),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withAlpha((0.3 * 255).toInt()),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      size: 16.sp,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      l10n.addBio,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
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
  final bool isEditable;

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
                        ).colorScheme.onSurface.withAlpha((0.6 * 255).toInt()),
                      ),
                    ),
                    if (isEditable) ...[
                      SizedBox(width: 1.w),
                      Icon(
                        Icons.edit,
                        size: 12.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withAlpha((0.6 * 255).toInt()),
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
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withAlpha((0.7 * 255).toInt()),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AddInfoPrompt extends StatelessWidget {
  final VoidCallback onTap;
  final String message;

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
              color: Theme.of(
                context,
              ).colorScheme.primary.withAlpha((0.3 * 255).toInt()),
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
                color: Theme.of(
                  context,
                ).colorScheme.primary.withAlpha((0.6 * 255).toInt()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCompletionCard extends StatelessWidget {
  final Hustler profile;

  const _ProfileCompletionCard({required this.profile});

  double _calculateCompletionPercentage(AppLocalizations l10n) {
    int totalFields = 6; // name, bio, phone, location, skills, experience
    int completedFields = 1; // name is always present

    if (profile.bio != null && profile.bio!.isNotEmpty) completedFields++;
    if (profile.phoneNumber != null && profile.phoneNumber!.isNotEmpty)
      completedFields++;
    if (profile.location != null && profile.location!.isNotEmpty)
      completedFields++;
    if (profile.skills.isNotEmpty) completedFields++;
    if (profile.experience != null && profile.experience!.isNotEmpty)
      completedFields++;

    return completedFields / totalFields;
  }

  String _getCompletionMessage(AppLocalizations l10n) {
    final percentage = _calculateCompletionPercentage(l10n);
    if (percentage == 1.0) return l10n.yourProfileIsComplete;
    if (percentage >= 0.8) return l10n.almostThere;
    if (percentage >= 0.5) return l10n.goodProgress;
    return l10n.completeYourProfileToAttractMoreOpportunities;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percentage = _calculateCompletionPercentage(l10n);

    if (percentage >= 1.0) {
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
                _getCompletionMessage(l10n),
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

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.primary.withAlpha((0.3 * 255).toInt()),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 24.sp,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  l10n.profileCompletion,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Text(
                '${(percentage * 100).toInt()}%',
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
            value: percentage,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.outline.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            _getCompletionMessage(l10n),
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withAlpha((0.8 * 255).toInt()),
            ),
          ),
          SizedBox(height: 2.h),
          InkWell(
            onTap: () {
              context.pushNamed(
                AppRoutes.hustlerEditProfileRoute,
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
                    l10n.completeProfile,
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
