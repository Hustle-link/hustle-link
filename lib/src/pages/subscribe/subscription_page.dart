import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

/// Enhanced subscription page with Orange Money payment integration.
///
/// This page displays subscription plans with Botswana Pula pricing and
/// integrates with Orange Money for secure payments. Designed specifically
/// for the Botswana market and Hustle Link's dual-role architecture.
class SubscriptionPage extends HookConsumerWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(currentUserProfileProvider);

    // Page state management
    final selectedPlan = useState<SubscriptionPlan?>(null);
    final showPaymentDialog = useState(false);

    /// Available subscription plans for Botswana market
    final availablePlans = [
      SubscriptionPlan.free,
      SubscriptionPlan.starter,
      SubscriptionPlan.growth,
      SubscriptionPlan.pro,
      SubscriptionPlan.businessPremium,
    ];

    /// Gets the current user's subscription plan
    SubscriptionPlan getCurrentPlan() {
      final subscription = user.asData?.value?.subscription;
      if (subscription == null || !subscription.isActive) {
        return SubscriptionPlan.free;
      }
      return SubscriptionPlan.fromString(subscription.plan);
    }

    /// Handles plan selection and payment initiation
    void handlePlanSelection(SubscriptionPlan plan) {
      if (plan == SubscriptionPlan.free) {
        // Handle downgrade to free plan
        _handleDowngradeToFree(context, ref, user.asData?.value, l10n);
        return;
      }

      selectedPlan.value = plan;
      showPaymentDialog.value = true;
    }

    /// Handles successful payment completion
    void handlePaymentSuccess(OrangeMoneyPayment payment) async {
      if (selectedPlan.value == null) return;

      try {
        // Update user subscription
        final userService = ref.read(firestoreUserServiceProvider);
        final currentUser = user.asData?.value;

        if (currentUser != null) {
          final newSubscription = Subscription(
            plan: selectedPlan.value!.id,
            isActive: true,
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 30)),
            priceInPula: selectedPlan.value!.monthlyPriceInPula,
            paymentMethod: 'orange_money',
            orangeMoneyReference: payment.orangeMoneyReference,
            autoRenew: true,
            features: selectedPlan.value!.features,
            lastPaymentDate: DateTime.now(),
          );

          final updatedUser = currentUser.copyWith(
            subscription: newSubscription,
          );

          await userService.updateUser(updatedUser);

          // Clear payment state and close dialog
          ref.read(currentPaymentNotifierProvider.notifier).clearPayment();
          showPaymentDialog.value = false;
          selectedPlan.value = null;

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Welcome to ${selectedPlan.value?.displayName}! Your subscription is now active.',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 4),
              ),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Failed to activate subscription. Please contact support.',
              ),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.subscriptions),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header section
                _buildHeader(theme, l10n),
                SizedBox(height: 4.h),

                // Current subscription status
                if (user.hasValue) ...[
                  _buildCurrentSubscriptionCard(theme, getCurrentPlan()),
                  SizedBox(height: 4.h),
                ],

                // Available plans
                Text(
                  'Choose Your Plan',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),

                // Plan cards
                ...availablePlans.map(
                  (plan) => Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: _SubscriptionPlanCard(
                      plan: plan,
                      isCurrentPlan: plan == getCurrentPlan(),
                      onSelect: () => handlePlanSelection(plan),
                      l10n: l10n,
                    ),
                  ),
                ),

                SizedBox(height: 6.h),

                // Features comparison note
                _buildFeaturesNote(theme),
              ],
            ),
          ),

          // Payment dialog overlay
          if (showPaymentDialog.value && selectedPlan.value != null)
            _buildPaymentOverlay(
              context,
              theme,
              selectedPlan.value!,
              handlePaymentSuccess,
              () {
                showPaymentDialog.value = false;
                selectedPlan.value = null;
                ref
                    .read(currentPaymentNotifierProvider.notifier)
                    .clearPayment();
              },
            ),
        ],
      ),
    );
  }

  /// Builds the header section with welcome message
  Widget _buildHeader(ThemeData theme, AppLocalizations? l10n) {
    return Column(
      children: [
        Text(
          l10n?.chooseYourPlan ?? 'Choose Your Plan',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.h),
        Text(
          'Unlock your full potential with our premium features designed for the Botswana market.',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Builds the current subscription status card
  Widget _buildCurrentSubscriptionCard(
    ThemeData theme,
    SubscriptionPlan currentPlan,
  ) {
    final isActive = currentPlan != SubscriptionPlan.free;

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isActive ? Icons.verified : Icons.info_outline,
                  color: isActive ? Colors.green : Colors.orange,
                ),
                SizedBox(width: 2.w),
                Text(
                  isActive ? 'Current Subscription' : 'Free Plan Active',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              currentPlan.displayName,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isActive) ...[
              SizedBox(height: 1.h),
              Text(
                'Next billing: ${_formatNextBillingDate()}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds the payment overlay dialog
  Widget _buildPaymentOverlay(
    BuildContext context,
    ThemeData theme,
    SubscriptionPlan plan,
    Function(OrangeMoneyPayment) onSuccess,
    VoidCallback onCancel,
  ) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          margin: EdgeInsets.all(4.w),
          constraints: BoxConstraints(maxHeight: 90.h),
          child: SingleChildScrollView(
            child: OrangeMoneyPaymentWidget(
              plan: plan,
              onPaymentInitiated: (payment) {
                // Simulate payment processing
                Future.delayed(const Duration(seconds: 3), () {
                  onSuccess(payment.copyWith(status: PaymentStatus.completed));
                });
              },
              onCancel: onCancel,
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the features comparison note
  Widget _buildFeaturesNote(ThemeData theme) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: theme.colorScheme.primary),
              SizedBox(width: 2.w),
              Text(
                'Why Upgrade?',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            'Hustle Link Premium plans are designed specifically for Botswana professionals and businesses. Get unlimited access to jobs, priority support, and features that help you succeed in the local market.',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  /// Formats the next billing date
  String _formatNextBillingDate() {
    final nextDate = DateTime.now().add(const Duration(days: 30));
    return '${nextDate.day}/${nextDate.month}/${nextDate.year}';
  }

  /// Handles downgrade to free plan
  void _handleDowngradeToFree(
    BuildContext context,
    WidgetRef ref,
    AppUser? user,
    AppLocalizations l10n,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.downgradeToFreePlan),
        content: Text(l10n.downgradeConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.subscriptionCancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              if (user != null) {
                final userService = ref.read(firestoreUserServiceProvider);
                final updatedUser = user.copyWith(subscription: null);
                await userService.updateUser(updatedUser);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.subscriptionCancelled)),
                  );
                }
              }
            },
            child: Text(l10n.subscriptionDowngrade),
          ),
        ],
      ),
    );
  }
}

/// Individual subscription plan card widget.
///
/// Displays plan details, features, and pricing in Botswana Pula with
/// appropriate styling for the current plan and call-to-action buttons.
class _SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  final bool isCurrentPlan;
  final VoidCallback onSelect;
  final AppLocalizations l10n;

  const _SubscriptionPlanCard({
    required this.plan,
    required this.isCurrentPlan,
    required this.onSelect,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Growth plan gets special styling as the "recommended" plan
    final isRecommendedPlan = plan == SubscriptionPlan.growth;

    return Card(
      elevation: isCurrentPlan ? 8 : (isRecommendedPlan ? 6 : 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCurrentPlan
              ? theme.colorScheme.primary
              : (isRecommendedPlan ? Colors.orange : Colors.transparent),
          width: isCurrentPlan ? 3 : (isRecommendedPlan ? 2 : 0),
        ),
      ),
      child: Stack(
        children: [
          // Recommended badge for growth plan
          if (isRecommendedPlan && !isCurrentPlan)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  'RECOMMENDED',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          Padding(
            padding: EdgeInsets.all(6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Plan name and price
                Text(
                  plan.displayName,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isCurrentPlan ? theme.colorScheme.primary : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  plan.formattedPrice,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: plan == SubscriptionPlan.free
                        ? Colors.green
                        : theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 3.h),

                // Features list
                ...plan.features.map((feature) => _FeatureRow(text: feature)),

                SizedBox(height: 4.h),

                // Action button
                ElevatedButton(
                  onPressed: isCurrentPlan ? null : onSelect,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    backgroundColor: isCurrentPlan
                        ? Colors.grey
                        : (plan == SubscriptionPlan.free
                              ? Colors.green
                              : theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _getButtonText(isCurrentPlan, plan),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Billing note for paid plans
                if (plan != SubscriptionPlan.free) ...[
                  SizedBox(height: 2.h),
                  Text(
                    l10n.billedMonthlyCancelAnytime,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getButtonText(bool isCurrentPlan, SubscriptionPlan plan) {
    if (isCurrentPlan) return 'Current Plan'; // TODO: Add to localization
    if (plan == SubscriptionPlan.free) return l10n.subscriptionDowngrade;
    return 'Upgrade to ${plan.displayName}'; // TODO: Add to localization
  }
}

/// Feature row widget for displaying plan features with checkmarks.
class _FeatureRow extends StatelessWidget {
  final String text;

  const _FeatureRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
