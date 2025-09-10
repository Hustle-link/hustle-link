// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subscription _$SubscriptionFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Subscription', json, ($checkedConvert) {
      final val = _Subscription(
        plan: $checkedConvert('plan', (v) => v as String),
        isActive: $checkedConvert('isActive', (v) => v as bool),
        endDate: $checkedConvert('endDate', (v) => DateTime.parse(v as String)),
      );
      return val;
    });

Map<String, dynamic> _$SubscriptionToJson(_Subscription instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'isActive': instance.isActive,
      'endDate': instance.endDate.toIso8601String(),
    };
