// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orange_money_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orangeMoneyServiceHash() =>
    r'0c7a74139623dc94b9c26e3ba9183c2dc6c3cdec';

/// Provider for the Orange Money service.
///
/// This provider gives access to Orange Money payment functionality
/// throughout the app using Riverpod dependency injection.
///
/// Copied from [orangeMoneyService].
@ProviderFor(orangeMoneyService)
final orangeMoneyServiceProvider =
    AutoDisposeProvider<OrangeMoneyService>.internal(
      orangeMoneyService,
      name: r'orangeMoneyServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$orangeMoneyServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrangeMoneyServiceRef = AutoDisposeProviderRef<OrangeMoneyService>;
String _$currentPaymentNotifierHash() =>
    r'13625d66f900b53fdd8723432e4b2df5f3712150';

/// Provider for tracking the current payment status during subscription flow.
///
/// This helps manage the payment state across different UI components
/// during the subscription purchase process.
///
/// Copied from [CurrentPaymentNotifier].
@ProviderFor(CurrentPaymentNotifier)
final currentPaymentNotifierProvider =
    AutoDisposeNotifierProvider<
      CurrentPaymentNotifier,
      OrangeMoneyPayment?
    >.internal(
      CurrentPaymentNotifier.new,
      name: r'currentPaymentNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentPaymentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentPaymentNotifier = AutoDisposeNotifier<OrangeMoneyPayment?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
