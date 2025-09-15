import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hustle_link/src/models/models.dart';
import 'package:flutter/foundation.dart';

part 'orange_money_service.g.dart';

/// Service for handling Orange Money payments in Botswana.
///
/// Orange Money is the leading mobile money service in Botswana, operated by
/// Orange Botswana. This service handles payment integration for subscription
/// management in the Hustle Link app.
class OrangeMoneyService {
  /// Creates an instance of [OrangeMoneyService].
  OrangeMoneyService();

  /// Initiates an Orange Money payment for a subscription.
  ///
  /// [phoneNumber] - The Orange Money phone number in +267 format
  /// [amount] - The amount to charge in Botswana Pula
  /// [plan] - The subscription plan being purchased
  ///
  /// Returns an [OrangeMoneyPayment] object with the transaction details.
  /// In a real implementation, this would integrate with Orange Money API.
  Future<OrangeMoneyPayment> initiatePayment({
    required String phoneNumber,
    required double amount,
    required SubscriptionPlan plan,
  }) async {
    // TODO(payment-integration): Integrate with actual Orange Money API
    // This is a mock implementation for demonstration purposes

    // Validate phone number format for Botswana (+267)
    if (!_isValidBotswanaPhoneNumber(phoneNumber)) {
      throw Exception('Invalid Botswana phone number. Please use +267 format.');
    }

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Generate a mock transaction ID
    final transactionId = 'OM${DateTime.now().millisecondsSinceEpoch}';

    // Create payment record
    final payment = OrangeMoneyPayment(
      transactionId: transactionId,
      phoneNumber: phoneNumber,
      amount: amount,
      status: PaymentStatus.pending,
      paymentDate: DateTime.now(),
      orangeMoneyReference: 'REF$transactionId',
    );

    debugPrint('Orange Money payment initiated: $transactionId for P$amount');

    return payment;
  }

  /// Checks the status of an Orange Money payment.
  ///
  /// [transactionId] - The transaction ID to check
  ///
  /// Returns the current [PaymentStatus] of the transaction.
  /// In a real implementation, this would query the Orange Money API.
  Future<PaymentStatus> checkPaymentStatus(String transactionId) async {
    // TODO(payment-integration): Implement actual Orange Money status check
    // This is a mock implementation

    await Future.delayed(const Duration(seconds: 1));

    // Simulate random payment completion for demo purposes
    // In production, this would query the actual Orange Money API
    final random = DateTime.now().millisecondsSinceEpoch % 3;
    switch (random) {
      case 0:
        return PaymentStatus.completed;
      case 1:
        return PaymentStatus.failed;
      default:
        return PaymentStatus.pending;
    }
  }

  /// Confirms a completed Orange Money payment.
  ///
  /// [payment] - The original payment record
  ///
  /// Returns an updated [OrangeMoneyPayment] with confirmed status.
  Future<OrangeMoneyPayment> confirmPayment(OrangeMoneyPayment payment) async {
    // TODO(payment-integration): Implement actual payment confirmation

    await Future.delayed(const Duration(seconds: 1));

    return payment.copyWith(
      status: PaymentStatus.completed,
      confirmationDate: DateTime.now(),
    );
  }

  /// Cancels a pending Orange Money payment.
  ///
  /// [transactionId] - The transaction ID to cancel
  /// [reason] - Reason for cancellation
  ///
  /// Returns an updated [OrangeMoneyPayment] with cancelled status.
  Future<OrangeMoneyPayment> cancelPayment(
    String transactionId,
    String reason,
  ) async {
    // TODO(payment-integration): Implement actual payment cancellation

    await Future.delayed(const Duration(seconds: 1));

    // In a real implementation, you would need to retrieve the original payment
    // and update it. For this mock, we'll create a cancelled payment record.
    return OrangeMoneyPayment(
      transactionId: transactionId,
      phoneNumber: '', // Would be retrieved from original payment
      amount: 0.0, // Would be retrieved from original payment
      status: PaymentStatus.cancelled,
      paymentDate: DateTime.now(),
      failureReason: reason,
    );
  }

  /// Validates if a phone number is a valid Botswana number.
  ///
  /// Botswana phone numbers start with +267 followed by 8 digits.
  /// Orange Money numbers typically start with +267 7X or +267 6X.
  bool _isValidBotswanaPhoneNumber(String phoneNumber) {
    // Remove any spaces or special characters except +
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    // Check for +267 prefix and 8 additional digits
    final botswanaPattern = RegExp(r'^\+267[6-7]\d{7}$');

    return botswanaPattern.hasMatch(cleanNumber);
  }

  /// Formats a phone number for display.
  ///
  /// Converts +26771234567 to +267 7123 4567 for better readability.
  String formatPhoneNumber(String phoneNumber) {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    if (cleanNumber.startsWith('+267') && cleanNumber.length == 12) {
      return '${cleanNumber.substring(0, 4)} ${cleanNumber.substring(4, 8)} ${cleanNumber.substring(8)}';
    }

    return phoneNumber; // Return as-is if not a standard Botswana number
  }
}

/// Provider for the Orange Money service.
///
/// This provider gives access to Orange Money payment functionality
/// throughout the app using Riverpod dependency injection.
@riverpod
OrangeMoneyService orangeMoneyService(OrangeMoneyServiceRef ref) {
  return OrangeMoneyService();
}

/// Provider for tracking the current payment status during subscription flow.
///
/// This helps manage the payment state across different UI components
/// during the subscription purchase process.
@riverpod
class CurrentPaymentNotifier extends _$CurrentPaymentNotifier {
  @override
  OrangeMoneyPayment? build() {
    return null;
  }

  /// Updates the current payment being processed.
  void setPayment(OrangeMoneyPayment payment) {
    state = payment;
  }

  /// Clears the current payment state.
  void clearPayment() {
    state = null;
  }

  /// Updates the payment status.
  void updatePaymentStatus(PaymentStatus status) {
    if (state != null) {
      state = state!.copyWith(status: status);
    }
  }
}
