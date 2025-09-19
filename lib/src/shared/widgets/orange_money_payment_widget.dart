import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hustle_link/src/src.dart';
import 'package:hustle_link/src/shared/l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';

/// Widget for collecting Orange Money payment details.
///
/// This widget provides a form for users to enter their Orange Money
/// phone number and confirm payment details for subscription purchases.
class OrangeMoneyPaymentWidget extends HookConsumerWidget {
  /// The subscription plan being purchased
  final SubscriptionPlan plan;

  /// Callback when payment is initiated successfully
  final Function(OrangeMoneyPayment) onPaymentInitiated;

  /// Callback when payment process is cancelled
  final VoidCallback? onCancel;

  /// Creates an [OrangeMoneyPaymentWidget].
  const OrangeMoneyPaymentWidget({
    super.key,
    required this.plan,
    required this.onPaymentInitiated,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final orangeMoneyService = ref.read(orangeMoneyServiceProvider);

    // Form controllers and state
    final phoneController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final isLoading = useState(false);
    final agreedToTerms = useState(false);

    /// Validates Botswana phone number format
    String? validatePhoneNumber(String? value) {
      if (value == null || value.isEmpty) {
        return l10n.pleaseEnterOrangeMoneyNumber;
      }

      // Remove spaces and format
      final cleanNumber = value.replaceAll(' ', '');

      // Check if it's a valid Botswana Orange Money number
      if (!cleanNumber.startsWith('+267') || cleanNumber.length != 12) {
        return l10n.pleaseEnterValidBotswanaPhone;
      }

      // Check if it's a valid mobile number (starts with 7 or 6 after +267)
      final mobilePrefix = cleanNumber.substring(4, 5);
      if (mobilePrefix != '7' && mobilePrefix != '6') {
        return l10n.pleaseEnterValidMobileNumber;
      }

      return null;
    }

    /// Handles payment initiation
    Future<void> handlePayment() async {
      if (!formKey.currentState!.validate() || !agreedToTerms.value) {
        return;
      }

      isLoading.value = true;

      try {
        final payment = await orangeMoneyService.initiatePayment(
          phoneNumber: phoneController.text.trim(),
          amount: plan.monthlyPriceInPula,
          plan: plan,
        );

        onPaymentInitiated(payment);
      } catch (e) {
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.failedToInitiatePayment),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(4.w),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Orange Money header
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.phone_android, color: Colors.white),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Orange Money',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          'Secure payment system for Botswana',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              // Subscription details
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subscription Plan',
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          plan.displayName,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          plan.formattedPrice,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 4.h),

              // Phone number input
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Orange Money Number',
                  hintText: '+267 7XXX XXXX',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  helperText: 'Enter your Orange Money registered phone number',
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s]')),
                  LengthLimitingTextInputFormatter(17), // +267 X XXX XXXX
                ],
                validator: validatePhoneNumber,
                onChanged: (value) {
                  // Auto-format as user types
                  if (value.length == 4 && !value.startsWith('+267')) {
                    phoneController.text = '+267 $value';
                    phoneController.selection = TextSelection.fromPosition(
                      TextPosition(offset: phoneController.text.length),
                    );
                  }
                },
              ),

              SizedBox(height: 3.h),

              // Terms and conditions checkbox
              CheckboxListTile(
                value: agreedToTerms.value,
                onChanged: (value) => agreedToTerms.value = value ?? false,
                title: Text(l10n.agreeToTermsAndConditions),
                subtitle: GestureDetector(
                  onTap: () {
                    // TODO(legal): Implement terms and conditions view
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(l10n.termsAndConditions),
                        content: Text(l10n.termsAndConditionsContent),
                        actions: [
                          TextButton(
                            onPressed:
                                null, // Will be fixed in real implementation
                            child: Text(AppLocalizations.of(context).close),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    l10n.viewTermsAndConditions,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),

              SizedBox(height: 4.h),

              // Action buttons
              Row(
                children: [
                  if (onCancel != null) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: isLoading.value ? null : onCancel,
                        child: Text(l10n.cancel),
                      ),
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: (isLoading.value || !agreedToTerms.value)
                          ? null
                          : handlePayment,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        backgroundColor: Colors.orange,
                      ),
                      child: isLoading.value
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.onPrimary,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.payment),
                                const SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  ).proceedWithPayment,
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Security note
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                    0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.security,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        'Your payment is processed securely through Orange Money Botswana.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
