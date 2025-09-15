// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orange_money_payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrangeMoneyPayment _$OrangeMoneyPaymentFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OrangeMoneyPayment', json, ($checkedConvert) {
      final val = _OrangeMoneyPayment(
        transactionId: $checkedConvert('transactionId', (v) => v as String),
        phoneNumber: $checkedConvert('phoneNumber', (v) => v as String),
        amount: $checkedConvert('amount', (v) => (v as num).toDouble()),
        status: $checkedConvert(
          'status',
          (v) => $enumDecode(_$PaymentStatusEnumMap, v),
        ),
        paymentDate: $checkedConvert(
          'paymentDate',
          (v) => DateTime.parse(v as String),
        ),
        confirmationDate: $checkedConvert(
          'confirmationDate',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        failureReason: $checkedConvert('failureReason', (v) => v as String?),
        orangeMoneyReference: $checkedConvert(
          'orangeMoneyReference',
          (v) => v as String?,
        ),
      );
      return val;
    });

Map<String, dynamic> _$OrangeMoneyPaymentToJson(_OrangeMoneyPayment instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'phoneNumber': instance.phoneNumber,
      'amount': instance.amount,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'paymentDate': instance.paymentDate.toIso8601String(),
      'confirmationDate': instance.confirmationDate?.toIso8601String(),
      'failureReason': instance.failureReason,
      'orangeMoneyReference': instance.orangeMoneyReference,
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.cancelled: 'cancelled',
  PaymentStatus.processing: 'processing',
};
