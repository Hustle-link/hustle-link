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
    'Basic profile',
    'Up to 5 job listings per month',
    'Access to hustle posts (with ads)',
  ]),

  /// Starter plan - For individual hustlers starting out
  starter('starter', 'Starter Plan', 10.0, [
    'Up to 15 job listings per month',
    'Basic analytics (views & applications)',
    'No ads on own listings',
  ]),

  /// Growth plan - For growing hustlers and small employers
  growth('growth', 'Growth Plan', 20.0, [
    'Up to 30 job listings per month',
    'Priority visibility in search results',
    'Ability to feature 1 listing per month',
  ]),

  /// Pro plan - For established professionals and businesses
  pro('pro', 'Pro Plan', 35.0, [
    'Unlimited job listings',
    'Boosted visibility across the platform',
    'No ads',
    'Access to premium job/hustle postings',
  ]),

  /// Business Premium plan - For verified businesses and enterprises
  businessPremium('business_premium', 'Business Premium', 50.0, [
    'Unlimited listings + verified business profile',
    'Ability to post business opportunities & tenders',
    'Team account (multiple logins)',
    'Advanced analytics/insights on engagement',
    'Business badge for credibility',
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

  /// Gets annual discount price (20% off)
  double get annualPriceInPula => monthlyPriceInPula * 12 * 0.8;

  /// Formats the annual price for display
  String get formattedAnnualPrice => monthlyPriceInPula == 0.0
      ? 'Free'
      : 'P${annualPriceInPula.toStringAsFixed(0)}/year (~20% off)';
}
