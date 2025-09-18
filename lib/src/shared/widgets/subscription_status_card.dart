import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

/// A reusable widget that displays the user's subscription status and provides
/// navigation to the subscription management page.
///
/// This widget shows:
/// - Current subscription plan (Free, Basic, Premium, Professional)
/// - Subscription status (Active/Inactive)
/// - Expiration or renewal date
/// - Action button to manage subscription or upgrade
class SubscriptionStatusCard extends StatelessWidget {
  /// Creates a [SubscriptionStatusCard] widget.
  ///
  /// [subscription] - The user's current subscription, null if on free plan
  const SubscriptionStatusCard({super.key, required this.subscription});

  /// The user's current subscription details, null if on free plan
  final Subscription? subscription;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    // Determine current plan and status
    final currentPlan = _getCurrentPlan();
    final isActive = _isSubscriptionActive();
    final statusText = _getStatusText(l10n);
    final actionText = _getActionText(l10n);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? theme.colorScheme.primary.withOpacity(0.3)
              : theme.colorScheme.outline.withOpacity(0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with subscription icon and title
          Row(
            children: [
              Icon(
                isActive ? Icons.workspace_premium : Icons.account_box_outlined,
                color: isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.7),
                size: 24.sp,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  l10n.subscriptionStatus,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              // Status badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.withOpacity(0.1)
                      : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive ? Colors.green : theme.colorScheme.outline,
                    width: 1,
                  ),
                ),
                child: Text(
                  isActive ? l10n.subscriptionActive : l10n.freeAccount,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? Colors.green.shade700
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Current plan information
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.currentSubscription,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      currentPlan.displayName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (subscription != null && isActive) ...[
                      SizedBox(height: 1.h),
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Plan price display
              if (currentPlan != SubscriptionPlan.free)
                Text(
                  currentPlan.formattedPrice,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
            ],
          ),

          SizedBox(height: 3.h),

          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.pushNamed(AppRoutes.subscriptionRoute),
              icon: Icon(
                isActive ? Icons.settings : Icons.upgrade,
                size: 18.sp,
              ),
              label: Text(
                actionText,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive
                    ? theme.colorScheme.surfaceContainerHighest
                    : theme.colorScheme.primary,
                foregroundColor: isActive
                    ? theme.colorScheme.onSurfaceVariant
                    : theme.colorScheme.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Determines the current subscription plan
  SubscriptionPlan _getCurrentPlan() {
    if (subscription == null || !subscription!.isActive) {
      return SubscriptionPlan.free;
    }
    return SubscriptionPlan.fromString(subscription!.plan);
  }

  /// Checks if the subscription is currently active
  bool _isSubscriptionActive() {
    if (subscription == null) return false;

    // Check if subscription is marked as active and hasn't expired
    return subscription!.isActive &&
        DateTime.now().isBefore(subscription!.endDate);
  }

  /// Gets the status text to display (expiration or renewal date)
  String _getStatusText(AppLocalizations l10n) {
    if (subscription == null || !_isSubscriptionActive()) {
      return '';
    }

    final endDate = subscription!.endDate;
    final formattedDate = '${endDate.day}/${endDate.month}/${endDate.year}';

    if (subscription!.autoRenew) {
      return '${l10n.subscriptionRenews}: $formattedDate';
    } else {
      return '${l10n.subscriptionExpires}: $formattedDate';
    }
  }

  /// Gets the action button text based on subscription status
  String _getActionText(AppLocalizations l10n) {
    if (_isSubscriptionActive()) {
      return l10n.manageSubscription;
    } else {
      return l10n.upgradeNow;
    }
  }
}
