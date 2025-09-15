import 'package:freezed_annotation/freezed_annotation.dart';

part 'orange_money_payment.freezed.dart';
part 'orange_money_payment.g.dart';

/// Model for tracking Orange Money payment transactions.
///
/// Used to integrate with Orange Money payment system in Botswana.
/// Orange Money is the leading mobile money service in Botswana.
@freezed
abstract class OrangeMoneyPayment with _$OrangeMoneyPayment {
  /// Creates an [OrangeMoneyPayment] instance.
  ///
  /// [transactionId] - Unique transaction ID from Orange Money
  /// [phoneNumber] - Orange Money phone number (+267 format)
  /// [amount] - Payment amount in Pula
  /// [status] - Payment status (pending, completed, failed, cancelled)
  /// [paymentDate] - When the payment was initiated
  /// [confirmationDate] - When the payment was confirmed (if completed)
  /// [failureReason] - Reason for failure (if failed)
  /// [orangeMoneyReference] - Orange Money system reference number
  const factory OrangeMoneyPayment({
    required String transactionId,
    required String phoneNumber,
    required double amount,
    required PaymentStatus status,
    required DateTime paymentDate,
    DateTime? confirmationDate,
    String? failureReason,
    String? orangeMoneyReference,
  }) = _OrangeMoneyPayment;

  /// Creates an [OrangeMoneyPayment] from JSON data.
  factory OrangeMoneyPayment.fromJson(Map<String, dynamic> json) =>
      _$OrangeMoneyPaymentFromJson(json);
}

/// Status of an Orange Money payment transaction.
///
/// Covers the typical lifecycle of mobile money payments in Botswana.
enum PaymentStatus {
  /// Payment initiated but not yet processed
  pending,

  /// Payment completed successfully
  completed,

  /// Payment failed due to insufficient funds or other issues
  failed,

  /// Payment cancelled by user or system
  cancelled,

  /// Payment is being processed by Orange Money
  processing;

  /// Returns the status as a string value
  String get value => name;

  /// Creates PaymentStatus from string
  static PaymentStatus fromString(String status) {
    return PaymentStatus.values.firstWhere(
      (s) => s.value == status,
      orElse: () => PaymentStatus.pending,
    );
  }

  /// Returns user-friendly display text for the status
  String get displayText {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending Payment';
      case PaymentStatus.completed:
        return 'Payment Successful';
      case PaymentStatus.failed:
        return 'Payment Failed';
      case PaymentStatus.cancelled:
        return 'Payment Cancelled';
      case PaymentStatus.processing:
        return 'Processing Payment';
    }
  }
}
