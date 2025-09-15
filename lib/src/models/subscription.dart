import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

/// Subscription model for managing user subscription plans in Hustle Link.
///
/// Supports different subscription tiers with Botswana Pula pricing and
/// Orange Money payment integration for the local market.
@freezed
abstract class Subscription with _$Subscription {
  /// Creates a [Subscription] instance.
  ///
  /// [plan] - The subscription plan type (free, basic, premium, professional)
  /// [isActive] - Whether the subscription is currently active
  /// [startDate] - When the subscription started
  /// [endDate] - When the subscription expires
  /// [priceInPula] - Price in Botswana Pula (BWP)
  /// [paymentMethod] - Payment method used (orange_money, cash, bank_transfer)
  /// [orangeMoneyReference] - Orange Money transaction reference
  /// [autoRenew] - Whether subscription auto-renews
  /// [features] - List of features included in this plan
  const factory Subscription({
    required String plan,
    required bool isActive,
    required DateTime startDate,
    required DateTime endDate,
    @Default(0.0) double priceInPula,
    @Default('orange_money') String paymentMethod,
    String? orangeMoneyReference,
    @Default(false) bool autoRenew,
    @Default([]) List<String> features,
    String? cancellationReason,
    DateTime? lastPaymentDate,
  }) = _Subscription;

  /// Creates a [Subscription] from JSON data.
  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}

/// Enumeration of available subscription plans in Hustle Link.
///
/// Designed for the Botswana market with appropriate pricing in Pula.
enum SubscriptionPlan {
  /// Free plan - Basic features with limitations
  free('free', 'Free Plan', 0.0, [
    'View up to 5 latest job postings',
    'Post up to 3 jobs for free',
    'Basic profile features',
    'Community support',
  ]),

  /// Basic plan - Suitable for individual hustlers
  basic('basic', 'Basic Plan', 49.99, [
    'View up to 20 job postings',
    'Post up to 10 jobs per month',
    'Enhanced profile with skills showcase',
    'Email support',
    'Application tracking',
  ]),

  /// Premium plan - For active job seekers and small employers
  premium('premium', 'Premium Plan', 99.99, [
    'Unlimited job views',
    'Unlimited job postings',
    'Priority listing in search results',
    'Advanced profile customization',
    'Priority email support',
    'Detailed analytics dashboard',
    'Orange Money payment integration',
  ]),

  /// Professional plan - For businesses and recruitment agencies
  professional('professional', 'Professional Plan', 199.99, [
    'All Premium features',
    'Company branding on job posts',
    'Bulk job posting tools',
    'Advanced candidate filtering',
    'Priority phone support',
    'Custom contract templates',
    'API access for integrations',
    'Dedicated account manager',
  ]);

  /// Creates a [SubscriptionPlan] with the specified parameters.
  const SubscriptionPlan(
    this.id,
    this.displayName,
    this.monthlyPriceInPula,
    this.features,
  );

  /// Unique identifier for the plan
  final String id;

  /// User-friendly display name for the plan
  final String displayName;

  /// Monthly price in Botswana Pula (BWP)
  final double monthlyPriceInPula;

  /// List of features included in this plan
  final List<String> features;

  /// Returns the plan ID as a string value
  String get value => id;

  /// Formats the price for display in Botswana Pula
  String get formattedPrice => monthlyPriceInPula == 0.0
      ? 'Free'
      : 'P${monthlyPriceInPula.toStringAsFixed(2)}/month';

  /// Creates a SubscriptionPlan from a string ID
  static SubscriptionPlan fromString(String id) {
    return SubscriptionPlan.values.firstWhere(
      (plan) => plan.id == id,
      orElse: () => SubscriptionPlan.free,
    );
  }
}
