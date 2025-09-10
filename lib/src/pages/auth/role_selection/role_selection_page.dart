import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class RoleSelectionPage extends HookConsumerWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = useState<UserRole?>(null);
    final nameController = useTextEditingController();
    final authController = ref.read(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(RoleSelectionStrings.pageTitle),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 2.h),

            // Title
            Text(
              RoleSelectionStrings.nameQuestion,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 2.h),

            // Name input
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: RoleSelectionStrings.nameLabel,
                hintText: RoleSelectionStrings.nameHint,
              ),
            ),
            SizedBox(height: 4.h),

            // Role selection title
            Text(
              RoleSelectionStrings.roleQuestion,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              RoleSelectionStrings.roleSubtitle,
              style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 4.h),

            // Role Cards
            _RoleCard(
              title: RoleSelectionStrings.hustlerTitle,
              subtitle: RoleSelectionStrings.hustlerSubtitle,
              icon: Icons.person_search,
              isSelected: selectedRole.value == UserRole.hustler,
              onTap: () => selectedRole.value = UserRole.hustler,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 3.h),
            _RoleCard(
              title: RoleSelectionStrings.employerTitle,
              subtitle: RoleSelectionStrings.employerSubtitle,
              icon: Icons.business_center,
              isSelected: selectedRole.value == UserRole.employer,
              onTap: () => selectedRole.value = UserRole.employer,
              color: Theme.of(context).colorScheme.secondary,
            ),

            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                onPressed:
                    (selectedRole.value != null &&
                        nameController.text.trim().isNotEmpty &&
                        !authState.isLoading)
                    ? () async {
                        await authController.createUserProfile(
                          name: nameController.text.trim(),
                          role: selectedRole.value!,
                          onSuccess: (_) async {
                            // Navigate to appropriate dashboard
                            if (context.mounted) {
                              context.go('/'); // Will redirect based on role
                            }
                          },
                          onError: (error) async {
                            if (context.mounted) {
                              final errorMsg = error.toString().replaceFirst(
                                'Exception: ',
                                '',
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(
                                        Icons.error_outline,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'Failed to create profile: $errorMsg',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                  duration: const Duration(seconds: 4),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                            debugPrint(
                              '${RoleSelectionStrings.profileCreationFailure}$error',
                            );
                          },
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: authState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        RoleSelectionStrings.getStartedButton,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? color : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24.sp),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: color, size: 24.sp),
          ],
        ),
      ),
    );
  }
}
