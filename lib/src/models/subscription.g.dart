// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subscription _$SubscriptionFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_Subscription', json, ($checkedConvert) {
  final val = _Subscription(
    plan: $checkedConvert('plan', (v) => v as String),
    isActive: $checkedConvert('isActive', (v) => v as bool),
    startDate: $checkedConvert('startDate', (v) => DateTime.parse(v as String)),
    endDate: $checkedConvert('endDate', (v) => DateTime.parse(v as String)),
    priceInPula: $checkedConvert(
      'priceInPula',
      (v) => (v as num?)?.toDouble() ?? 0.0,
    ),
    paymentMethod: $checkedConvert(
      'paymentMethod',
      (v) => v as String? ?? 'orange_money',
    ),
    orangeMoneyReference: $checkedConvert(
      'orangeMoneyReference',
      (v) => v as String?,
    ),
    autoRenew: $checkedConvert('autoRenew', (v) => v as bool? ?? false),
    features: $checkedConvert(
      'features',
      (v) =>
          (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    ),
    cancellationReason: $checkedConvert(
      'cancellationReason',
      (v) => v as String?,
    ),
    lastPaymentDate: $checkedConvert(
      'lastPaymentDate',
      (v) => v == null ? null : DateTime.parse(v as String),
    ),
  );
  return val;
});

Map<String, dynamic> _$SubscriptionToJson(_Subscription instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'isActive': instance.isActive,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'priceInPula': instance.priceInPula,
      'paymentMethod': instance.paymentMethod,
      'orangeMoneyReference': instance.orangeMoneyReference,
      'autoRenew': instance.autoRenew,
      'features': instance.features,
      'cancellationReason': instance.cancellationReason,
      'lastPaymentDate': instance.lastPaymentDate?.toIso8601String(),
    };
