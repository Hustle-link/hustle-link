import 'package:hustle_link/src/src.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'subscription_access_service.g.dart';

/// A comprehensive service for managing subscription-based access control throughout the app.
///
/// This service provides centralized logic for checking subscription limits,
/// determining feature access, and managing plan restrictions for both hustlers and employers.
/// Designed specifically for Hustle Link's dual-role architecture with Botswana market considerations.
class SubscriptionAccessService {
  /// Current user subscription, can be null for free users
  final Subscription? subscription;

  /// Current subscription plan derived from subscription data
  final SubscriptionPlan currentPlan;

  /// Number of jobs posted this month (for Basic plan monthly limits)
  final int jobsPostedThisMonth;

  /// Number of job views this month (for Basic plan monthly limits)
  final int jobViewsThisMonth;

  /// Creates a [SubscriptionAccessService] instance with current subscription state.
  const SubscriptionAccessService({
    this.subscription,
    required this.currentPlan,
    this.jobsPostedThisMonth = 0,
    this.jobViewsThisMonth = 0,
  });

  /// Factory constructor to create service from user profile data
  factory SubscriptionAccessService.fromUserProfile(
    AppUser? user, {
    int jobsPostedThisMonth = 0,
    int jobViewsThisMonth = 0,
  }) {
    final subscription = user?.subscription;
    final plan = _getPlanFromSubscription(subscription);

    return SubscriptionAccessService(
      subscription: subscription,
      currentPlan: plan,
      jobsPostedThisMonth: jobsPostedThisMonth,
      jobViewsThisMonth: jobViewsThisMonth,
    );
  }

  /// Determines the subscription plan from subscription data
  static SubscriptionPlan _getPlanFromSubscription(Subscription? subscription) {
    if (subscription == null || !subscription.isActive) {
      return SubscriptionPlan.free;
    }
    return SubscriptionPlan.fromString(subscription.plan);
  }

  // ========================================================================
  // JOB VIEWING ACCESS CONTROL
  // ========================================================================

  /// Checks if user can view job listings based on their subscription plan.
  ///
  /// Returns [AccessResult] with permission status and details about limits.
  AccessResult canViewJobs({int requestedJobCount = 1}) {
    switch (currentPlan) {
      case SubscriptionPlan.free:
        const limit = 5;
        if (jobViewsThisMonth + requestedJobCount > limit) {
          return AccessResult.denied(
            reason:
                'Free plan allows viewing up to $limit job postings. Upgrade to view more jobs.',
            currentUsage: jobViewsThisMonth,
            limit: limit,
            upgradeRequired: SubscriptionPlan.starter,
          );
        }
        return AccessResult.allowed(
          currentUsage: jobViewsThisMonth,
          limit: limit,
        );

      case SubscriptionPlan.starter:
        const limit = 15;
        if (jobViewsThisMonth + requestedJobCount > limit) {
          return AccessResult.denied(
            reason:
                'Starter plan allows viewing up to $limit job postings per month. Upgrade to Growth for more access.',
            currentUsage: jobViewsThisMonth,
            limit: limit,
            upgradeRequired: SubscriptionPlan.growth,
          );
        }
        return AccessResult.allowed(
          currentUsage: jobViewsThisMonth,
          limit: limit,
        );

      case SubscriptionPlan.growth:
        const limit = 30;
        if (jobViewsThisMonth + requestedJobCount > limit) {
          return AccessResult.denied(
            reason:
                'Growth plan allows viewing up to $limit job postings per month. Upgrade to Pro for unlimited access.',
            currentUsage: jobViewsThisMonth,
            limit: limit,
            upgradeRequired: SubscriptionPlan.pro,
          );
        }
        return AccessResult.allowed(
          currentUsage: jobViewsThisMonth,
          limit: limit,
        );

      case SubscriptionPlan.pro:
      case SubscriptionPlan.businessPremium:
        return AccessResult.allowed(
          currentUsage: jobViewsThisMonth,
          limit: null, // Unlimited
        );
    }
  }

  /// Gets the maximum number of jobs a user can view based on their plan
  int? getJobViewLimit() {
    switch (currentPlan) {
      case SubscriptionPlan.free:
        return 5;
      case SubscriptionPlan.starter:
        return 15;
      case SubscriptionPlan.growth:
        return 30;
      case SubscriptionPlan.pro:
      case SubscriptionPlan.businessPremium:
        return null; // Unlimited
    }
  }

  /// Calculates remaining job views for current month
  int? getRemainingJobViews() {
    final limit = getJobViewLimit();
    if (limit == null) return null; // Unlimited
    return (limit - jobViewsThisMonth).clamp(0, limit);
  }

  // ========================================================================
  // JOB POSTING ACCESS CONTROL
  // ========================================================================

  /// Checks if user can post jobs based on their subscription plan.
  ///
  /// Returns [AccessResult] with permission status and details about limits.
  AccessResult canPostJobs({int requestedJobCount = 1}) {
    switch (currentPlan) {
      case SubscriptionPlan.free:
        // Note: Free plan has 5 job listings per month, not 3 total
        const limit = 5;
        if (jobsPostedThisMonth + requestedJobCount > limit) {
          return AccessResult.denied(
            reason:
                'Free plan allows posting up to $limit jobs per month. Upgrade to Starter for more postings.',
            currentUsage: jobsPostedThisMonth,
            limit: limit,
            upgradeRequired: SubscriptionPlan.starter,
          );
        }
        return AccessResult.allowed(
          currentUsage: jobsPostedThisMonth,
          limit: limit,
        );

      case SubscriptionPlan.starter:
        const limit = 15;
        if (jobsPostedThisMonth + requestedJobCount > limit) {
          return AccessResult.denied(
            reason:
                'Starter plan allows posting up to $limit jobs per month. Upgrade to Growth for more postings.',
            currentUsage: jobsPostedThisMonth,
            limit: limit,
            upgradeRequired: SubscriptionPlan.growth,
          );
        }
        return AccessResult.allowed(
          currentUsage: jobsPostedThisMonth,
          limit: limit,
        );

      case SubscriptionPlan.growth:
        const limit = 30;
        if (jobsPostedThisMonth + requestedJobCount > limit) {
          return AccessResult.denied(
            reason:
                'Growth plan allows posting up to $limit jobs per month. Upgrade to Pro for unlimited posting.',
            currentUsage: jobsPostedThisMonth,
            limit: limit,
            upgradeRequired: SubscriptionPlan.pro,
          );
        }
        return AccessResult.allowed(
          currentUsage: jobsPostedThisMonth,
          limit: limit,
        );

      case SubscriptionPlan.pro:
      case SubscriptionPlan.businessPremium:
        return AccessResult.allowed(
          currentUsage: jobsPostedThisMonth,
          limit: null, // Unlimited
        );
    }
  }

  /// Gets the maximum number of jobs a user can post based on their plan
  int? getJobPostingLimit() {
    switch (currentPlan) {
      case SubscriptionPlan.free:
        return 5; // Updated to match the new plan structure
      case SubscriptionPlan.starter:
        return 15;
      case SubscriptionPlan.growth:
        return 30;
      case SubscriptionPlan.pro:
      case SubscriptionPlan.businessPremium:
        return null; // Unlimited
    }
  }

  /// Calculates remaining job posts for current month/total
  int? getRemainingJobPosts() {
    final limit = getJobPostingLimit();
    if (limit == null) return null; // Unlimited
    return (limit - jobsPostedThisMonth).clamp(0, limit);
  }

  // ========================================================================
  // FEATURE ACCESS CONTROL
  // ========================================================================

  /// Checks if user has access to priority job listing (shows at top of search results)
  bool canUsePriorityListing() {
    return currentPlan == SubscriptionPlan.growth ||
        currentPlan == SubscriptionPlan.pro ||
        currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if user has access to advanced profile customization
  bool canUseAdvancedProfile() {
    return currentPlan == SubscriptionPlan.pro ||
        currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if user has access to analytics dashboard
  bool canUseAnalytics() {
    return currentPlan == SubscriptionPlan.starter ||
        currentPlan == SubscriptionPlan.growth ||
        currentPlan == SubscriptionPlan.pro ||
        currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if user has access to company branding features
  bool canUseCompanyBranding() {
    return currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if user can feature listings (highlight/promote posts)
  bool canFeatureListings() {
    return currentPlan == SubscriptionPlan.growth ||
        currentPlan == SubscriptionPlan.pro ||
        currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if user has access to verified business profile
  bool canUseVerifiedProfile() {
    return currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if user can post business opportunities and tenders
  bool canPostBusinessOpportunities() {
    return currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if user has access to team accounts (multiple logins)
  bool canUseTeamAccounts() {
    return currentPlan == SubscriptionPlan.businessPremium;
  }

  /// Checks if ads are shown to the user
  bool hasAdsEnabled() {
    // Free plan shows ads, starter+ plans have no ads on own listings
    // Pro+ plans have no ads at all
    return currentPlan == SubscriptionPlan.free;
  }

  // ========================================================================
  // UTILITY METHODS
  // ========================================================================

  /// Returns true if user has an active paid subscription
  bool get hasActivePaidSubscription {
    return subscription?.isActive == true &&
        currentPlan != SubscriptionPlan.free;
  }

  /// Returns the number of days until subscription expires (null if free plan)
  int? get daysUntilExpiration {
    if (subscription == null || !subscription!.isActive) return null;
    final now = DateTime.now();
    final endDate = subscription!.endDate;
    return endDate.difference(now).inDays;
  }

  /// Returns true if subscription expires within the given number of days
  bool expiresWithinDays(int days) {
    final remaining = daysUntilExpiration;
    return remaining != null && remaining <= days;
  }

  /// Gets a user-friendly description of current plan limits
  String getPlanLimitDescription() {
    switch (currentPlan) {
      case SubscriptionPlan.free:
        return 'Free Plan: Up to 5 job listings per month, with ads';
      case SubscriptionPlan.starter:
        return 'Starter Plan: Up to 15 job listings per month, basic analytics, no ads on own listings';
      case SubscriptionPlan.growth:
        return 'Growth Plan: Up to 30 job listings per month, priority visibility, 1 featured listing/month';
      case SubscriptionPlan.pro:
        return 'Pro Plan: Unlimited listings, boosted visibility, no ads, premium access';
      case SubscriptionPlan.businessPremium:
        return 'Business Premium: Unlimited + verified profile, business opportunities, team accounts, advanced analytics';
    }
  }

  /// Gets usage summary for display in UI
  UsageSummary getUsageSummary() {
    return UsageSummary(
      currentPlan: currentPlan,
      jobViewsUsed: jobViewsThisMonth,
      jobViewsLimit: getJobViewLimit(),
      jobPostsUsed: jobsPostedThisMonth,
      jobPostsLimit: getJobPostingLimit(),
      daysUntilExpiration: daysUntilExpiration,
    );
  }
}

/// Represents the result of an access control check
class AccessResult {
  /// Whether access is granted
  final bool isAllowed;

  /// Human-readable reason for denial (if applicable)
  final String? reason;

  /// Current usage count
  final int currentUsage;

  /// Usage limit (null for unlimited)
  final int? limit;

  /// Suggested upgrade plan (if access denied)
  final SubscriptionPlan? upgradeRequired;

  const AccessResult._({
    required this.isAllowed,
    this.reason,
    required this.currentUsage,
    this.limit,
    this.upgradeRequired,
  });

  /// Creates an allowed access result
  factory AccessResult.allowed({required int currentUsage, int? limit}) {
    return AccessResult._(
      isAllowed: true,
      currentUsage: currentUsage,
      limit: limit,
    );
  }

  /// Creates a denied access result
  factory AccessResult.denied({
    required String reason,
    required int currentUsage,
    int? limit,
    SubscriptionPlan? upgradeRequired,
  }) {
    return AccessResult._(
      isAllowed: false,
      reason: reason,
      currentUsage: currentUsage,
      limit: limit,
      upgradeRequired: upgradeRequired,
    );
  }

  /// Returns true if user is at their usage limit
  bool get isAtLimit {
    if (limit == null) return false; // Unlimited
    return currentUsage >= limit!;
  }

  /// Returns percentage of limit used (0-100, null for unlimited)
  double? get usagePercentage {
    if (limit == null) return null; // Unlimited
    if (limit == 0) return 100.0;
    return (currentUsage / limit! * 100).clamp(0.0, 100.0);
  }
}

/// Summary of user's subscription usage for UI display
class UsageSummary {
  final SubscriptionPlan currentPlan;
  final int jobViewsUsed;
  final int? jobViewsLimit;
  final int jobPostsUsed;
  final int? jobPostsLimit;
  final int? daysUntilExpiration;

  const UsageSummary({
    required this.currentPlan,
    required this.jobViewsUsed,
    this.jobViewsLimit,
    required this.jobPostsUsed,
    this.jobPostsLimit,
    this.daysUntilExpiration,
  });

  /// Returns remaining job views (null for unlimited)
  int? get remainingJobViews {
    if (jobViewsLimit == null) return null;
    return (jobViewsLimit! - jobViewsUsed).clamp(0, jobViewsLimit!);
  }

  /// Returns remaining job posts (null for unlimited)
  int? get remainingJobPosts {
    if (jobPostsLimit == null) return null;
    return (jobPostsLimit! - jobPostsUsed).clamp(0, jobPostsLimit!);
  }

  /// Returns true if any limits are being approached (>80% usage)
  bool get hasLimitWarnings {
    if (jobViewsLimit != null && jobViewsUsed / jobViewsLimit! > 0.8) {
      return true;
    }
    if (jobPostsLimit != null && jobPostsUsed / jobPostsLimit! > 0.8) {
      return true;
    }
    if (daysUntilExpiration != null && daysUntilExpiration! <= 7) {
      return true;
    }
    return false;
  }
}

/// Riverpod provider for the subscription access service
@riverpod
SubscriptionAccessService subscriptionAccessService(Ref ref) {
  final user = ref.watch(currentUserProfileProvider).value;

  // TODO(optimization): Implement proper job counting from Firestore
  // For now, using placeholder values - should be replaced with actual monthly usage tracking
  const jobsPostedThisMonth = 0;
  const jobViewsThisMonth = 0;

  return SubscriptionAccessService.fromUserProfile(
    user,
    jobsPostedThisMonth: jobsPostedThisMonth,
    jobViewsThisMonth: jobViewsThisMonth,
  );
}

/// Provider for current user's usage summary
@riverpod
UsageSummary usageSummary(Ref ref) {
  final service = ref.watch(subscriptionAccessServiceProvider);
  return service.getUsageSummary();
}
