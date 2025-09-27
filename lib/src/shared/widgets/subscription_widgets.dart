import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hustle_link/src/src.dart';
import 'package:sizer/sizer.dart';

/// A widget that displays upgrade prompts when users hit subscription limits.
///
/// Shows contextual upgrade information based on the user's current plan
/// and the feature they're trying to access. Provides clear benefit messaging
/// and direct navigation to subscription plans.
class SubscriptionUpgradePrompt extends StatelessWidget {
  /// The access result that triggered this prompt
  final AccessResult accessResult;

  /// The feature being accessed (e.g., "job posting", "job viewing")
  final String featureName;

  /// Custom title override
  final String? title;

  /// Custom description override
  final String? description;

  /// Whether to show as a dialog or inline widget
  final bool isDialog;

  const SubscriptionUpgradePrompt({
    super.key,
    required this.accessResult,
    required this.featureName,
    this.title,
    this.description,
    this.isDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    if (isDialog) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: _buildContent(theme, l10n),
      );
    }

    return _buildContent(theme, l10n);
  }

  Widget _buildContent(ThemeData theme, AppLocalizations? l10n) {
    final upgradeColor = accessResult.upgradeRequired == SubscriptionPlan.pro
        ? Colors.orange
        : theme.colorScheme.primary;

    return Builder(
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: upgradeColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.workspace_premium,
                size: 48,
                color: upgradeColor,
              ),
            ),

            SizedBox(height: 3.h),

            // Title
            Text(
              title ?? _getDefaultTitle(context),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 2.h),

            // Description
            Text(
              description ??
                  accessResult.reason ??
                  _getDefaultDescription(context),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 3.h),

            // Current usage info
            if (accessResult.limit != null) ...[
              _buildUsageIndicator(context, theme),
              SizedBox(height: 3.h),
            ],

            // Benefits preview
            _buildBenefits(context, theme),

            SizedBox(height: 4.h),

            // Action buttons
            _buildActionButtons(context, theme, upgradeColor),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    ThemeData theme,
    Color upgradeColor,
  ) {
    return Column(
      children: [
        // Primary upgrade button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => _handleUpgrade(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: upgradeColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              AppLocalizations.of(context).upgrade,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        SizedBox(height: 1.h),

        // Secondary action (close/maybe later)
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            isDialog
                ? AppLocalizations.of(context).maybeLater
                : AppLocalizations.of(context).continueWithFree,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsageIndicator(BuildContext context, ThemeData theme) {
    final progress = accessResult.usagePercentage;
    if (progress == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).currentUsage,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${accessResult.currentUsage}/${accessResult.limit}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: theme.colorScheme.outline.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              progress > 90 ? Colors.red : theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefits(BuildContext context, ThemeData theme) {
    final benefits = _getBenefitsForUpgrade(context);
    if (benefits.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).whatYoullGet,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        ...benefits.map(
          (benefit) => Padding(
            padding: EdgeInsets.only(bottom: 0.5.h),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(benefit, style: theme.textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _handleUpgrade(BuildContext context) {
    Navigator.of(context).pop(); // Close dialog if open
    context.push(AppRoutes.subscription);
  }

  String _getDefaultTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (accessResult.upgradeRequired) {
      case SubscriptionPlan.starter:
        return l10n.upgradeToStarterPlan;
      case SubscriptionPlan.growth:
        return l10n.upgradeToGrowthPlan;
      case SubscriptionPlan.pro:
        return l10n.upgradeToProPlan;
      case SubscriptionPlan.businessPremium:
        return l10n.upgradeToBusinessPremium;
      default:
        return l10n.upgradeYourPlan;
    }
  }

  String _getDefaultDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return l10n.reachedLimitMessage(featureName);
  }

  List<String> _getBenefitsForUpgrade(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    switch (accessResult.upgradeRequired) {
      case SubscriptionPlan.starter:
        return [
          l10n.benefitJobListings15,
          l10n.benefitBasicAnalytics,
          l10n.benefitNoAdsOwnListings,
          l10n.benefitEmailSupport,
        ];
      case SubscriptionPlan.growth:
        return [
          l10n.benefitJobListings30,
          l10n.benefitPriorityVisibility,
          l10n.benefitFeatureOneListingPerMonth,
          l10n.benefitEnhancedAnalytics,
        ];
      case SubscriptionPlan.pro:
        return [
          l10n.benefitUnlimitedJobListings,
          l10n.benefitBoostedVisibility,
          l10n.benefitNoAdsAnywhere,
          l10n.benefitPremiumJobPostings,
          l10n.benefitPrioritySupport,
        ];
      case SubscriptionPlan.businessPremium:
        return [
          l10n.benefitAllProFeatures,
          l10n.benefitVerifiedBusinessProfile,
          l10n.benefitBusinessOpportunities,
          l10n.benefitTeamAccount,
          l10n.benefitAdvancedAnalytics,
          l10n.benefitBusinessBadge,
        ];
      default:
        return [];
    }
  }
}

/// A compact banner widget showing subscription status and usage
class SubscriptionStatusBanner extends StatelessWidget {
  /// Current usage summary
  final UsageSummary usageSummary;

  /// Whether to show detailed usage info
  final bool showDetails;

  const SubscriptionStatusBanner({
    super.key,
    required this.usageSummary,
    this.showDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    // Don't show banner for unlimited plans unless there are warnings
    if (!_shouldShowBanner()) {
      return const SizedBox.shrink();
    }

    final color = _getBannerColor();

    return Container(
      margin: EdgeInsets.all(2.w),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(_getStatusIcon(), color: color, size: 20),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  usageSummary.currentPlan.displayName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
              if (usageSummary.currentPlan != SubscriptionPlan.businessPremium)
                TextButton(
                  onPressed: () => context.push(AppRoutes.subscription),
                  style: TextButton.styleFrom(
                    foregroundColor: color,
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                  ),
                  child: Text(l10n.subscriptionUpgrade),
                ),
            ],
          ),

          // Usage details
          if (showDetails) ...[
            SizedBox(height: 1.h),
            _buildUsageDetails(theme, color, l10n),
          ],

          // Expiration warning
          if (usageSummary.daysUntilExpiration != null &&
              usageSummary.daysUntilExpiration! <= 7) ...[
            SizedBox(height: 1.h),
            Text(
              l10n.expiresInDays(usageSummary.daysUntilExpiration!),
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUsageDetails(
    ThemeData theme,
    Color color,
    AppLocalizations l10n,
  ) {
    return Column(
      children: [
        // Job views usage
        if (usageSummary.jobViewsLimit != null)
          _buildUsageRow(
            theme,
            color,
            l10n.jobViews,
            usageSummary.jobViewsUsed,
            usageSummary.jobViewsLimit!,
          ),

        // Job posts usage
        if (usageSummary.jobPostsLimit != null) ...[
          if (usageSummary.jobViewsLimit != null) SizedBox(height: 0.5.h),
          _buildUsageRow(
            theme,
            color,
            l10n.jobPosts,
            usageSummary.jobPostsUsed,
            usageSummary.jobPostsLimit!,
          ),
        ],
      ],
    );
  }

  Widget _buildUsageRow(
    ThemeData theme,
    Color color,
    String label,
    int used,
    int limit,
  ) {
    final percentage = (used / limit * 100).clamp(0.0, 100.0);

    return Row(
      children: [
        Expanded(flex: 2, child: Text(label, style: theme.textTheme.bodySmall)),
        Expanded(
          flex: 3,
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: theme.colorScheme.outline.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage > 90 ? Colors.red : color,
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Text(
          '$used/$limit',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: percentage > 90 ? Colors.red : color,
          ),
        ),
      ],
    );
  }

  bool _shouldShowBanner() {
    // Always show for free users
    if (usageSummary.currentPlan == SubscriptionPlan.free) return true;

    // Show if there are warnings (approaching limits or expiring soon)
    if (usageSummary.hasLimitWarnings) return true;

    // Show for Starter plan users if they have usage to display
    if (usageSummary.currentPlan == SubscriptionPlan.starter) {
      return usageSummary.jobViewsLimit != null ||
          usageSummary.jobPostsLimit != null;
    }

    return false;
  }

  Color _getBannerColor() {
    if (usageSummary.hasLimitWarnings) return Colors.orange;

    switch (usageSummary.currentPlan) {
      case SubscriptionPlan.free:
        return Colors.grey;
      case SubscriptionPlan.starter:
        return Colors.blue;
      case SubscriptionPlan.growth:
        return Colors.green;
      case SubscriptionPlan.pro:
        return Colors.orange;
      case SubscriptionPlan.businessPremium:
        return Colors.purple;
    }
  }

  IconData _getStatusIcon() {
    if (usageSummary.hasLimitWarnings) return Icons.warning;

    switch (usageSummary.currentPlan) {
      case SubscriptionPlan.free:
        return Icons.lock_outline;
      case SubscriptionPlan.starter:
        return Icons.star_border;
      case SubscriptionPlan.growth:
        return Icons.trending_up;
      case SubscriptionPlan.pro:
        return Icons.star;
      case SubscriptionPlan.businessPremium:
        return Icons.verified;
    }
  }
}

/// Shows an upgrade prompt as a modal dialog
void showUpgradeDialog(
  BuildContext context, {
  required AccessResult accessResult,
  required String featureName,
  String? title,
  String? description,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => SubscriptionUpgradePrompt(
      accessResult: accessResult,
      featureName: featureName,
      title: title,
      description: description,
      isDialog: true,
    ),
  );
}

/// Shows a bottom sheet with upgrade options
void showUpgradeBottomSheet(
  BuildContext context, {
  required AccessResult accessResult,
  required String featureName,
  String? title,
  String? description,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SubscriptionUpgradePrompt(
        accessResult: accessResult,
        featureName: featureName,
        title: title,
        description: description,
      ),
    ),
  );
}
