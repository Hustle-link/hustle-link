// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionImpl _$$SubscriptionImplFromJson(Map<String, dynamic> json) =>
    _$SubscriptionImpl(
      plan: json['plan'] as String,
      isActive: json['isActive'] as bool,
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$SubscriptionImplToJson(_$SubscriptionImpl instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'isActive': instance.isActive,
      'endDate': instance.endDate.toIso8601String(),
    };
