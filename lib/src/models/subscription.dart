import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required String plan,
    required bool isActive,
    required DateTime endDate,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}
