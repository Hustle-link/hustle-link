import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

class RoleSelectionPageNew extends HookConsumerWidget {
  const RoleSelectionPageNew({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final selectedRole = useState<UserRole?>(null);
    final nameController = useTextEditingController();
    // Rebuild when name changes to update button enabled state
    useListenable(nameController);
    final authController = ref.read(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(l10n.completeYourProfile),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 6.w,
            right: 6.w,
            top: 2.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                l10n.whatsYourName,
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
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: l10n.fullName,
                  hintText: l10n.enterYourFullName,
                ),
              ),
              SizedBox(height: 4.h),

              // Role selection title
              Text(
                l10n.whatBringsYouToHustleLink,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                l10n.chooseYourRole,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 4.h),

              // Role Cards
              _RoleCard(
                title: l10n.imAHustler,
                subtitle: l10n.lookingForFreelanceWork,
                icon: Icons.person_search,
                isSelected: selectedRole.value == UserRole.hustler,
                onTap: () => selectedRole.value = UserRole.hustler,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 3.h),
              _RoleCard(
                title: l10n.imAnEmployer,
                subtitle: l10n.lookingToHireTalent,
                icon: Icons.business_center,
                isSelected: selectedRole.value == UserRole.employer,
                onTap: () => selectedRole.value = UserRole.employer,
                color: Theme.of(context).colorScheme.secondary,
              ),

              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 6.w,
          right: 6.w,
          bottom: 4.w + MediaQuery.of(context).viewInsets.bottom,
          top: 8,
        ),
        child: SizedBox(
          height: 6.h,
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                (selectedRole.value != null &&
                    nameController.text.trim().isNotEmpty)
                ? () async {
                    try {
                      await authController.createUserProfile(
                        name: nameController.text.trim(),
                        role: selectedRole.value!,
                      );
                      if (context.mounted) {
                        context.go('/');
                      }
                    } catch (e) {
                      debugPrint('Profile creation failed: $e');
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: authState.when(
              idle: () => Text(
                l10n.getStarted,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text(l10n.tryAgain),
              data: (_) => Text(
                l10n.getStarted,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? color.withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
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
                      ).colorScheme.onSurface.withOpacity(0.7),
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
