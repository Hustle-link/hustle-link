import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

class SubscriptionPage extends HookConsumerWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.subscriptions),
        backgroundColor: theme.colorScheme.surface,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.chooseYourPlan,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              l10n.unlockFullPotential,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            _SubscriptionCard(
              title: l10n.freePlan,
              price: '\$0/mo',
              features: [
                l10n.viewFiveJobs,
                l10n.postThreeJobs,
              ],
              isCurrentPlan: user.value?.subscription == null || !user.value!.subscription!.isActive,
            ),
            SizedBox(height: 3.h),
            _SubscriptionCard(
              title: l10n.premiumPlan,
              price: '\$10/mo',
              features: [
                l10n.unlimitedJobPostings,
                l10n.unlimitedJobViews,
                l10n.prioritySupport,
              ],
              isCurrentPlan: user.value?.subscription?.isActive ?? false,
              onTap: () async {
                // Simulate payment and subscription update
                final userService = ref.read(firestoreUserServiceProvider);
                if (user.value != null) {
                  final newSubscription = Subscription(
                    plan: 'premium',
                    isActive: true,
                    endDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  final updatedUser = user.value!.copyWith(subscription: newSubscription);
                  await userService.updateUser(updatedUser);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.subscriptionSuccessful),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isCurrentPlan;
  final VoidCallback? onTap;

  const _SubscriptionCard({
    required this.title,
    required this.price,
    required this.features,
    this.isCurrentPlan = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: isCurrentPlan ? 8 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCurrentPlan ? theme.colorScheme.primary : Colors.transparent,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isCurrentPlan ? theme.colorScheme.primary : null,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              price,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            ...features.map((feature) => _FeatureRow(text: feature)),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: isCurrentPlan ? null : onTap,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                backgroundColor: isCurrentPlan ? Colors.grey : theme.colorScheme.primary,
              ),
              child: Text(
                isCurrentPlan ? 'Current Plan' : 'Subscribe',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String text;
  const _FeatureRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
