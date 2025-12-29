// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certification_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$certificationServiceHash() =>
    r'c0ee1d533639fcee5d4cb8cb448ea05e9ec38372';

/// See also [certificationService].
@ProviderFor(certificationService)
final certificationServiceProvider = Provider<CertificationService>.internal(
  certificationService,
  name: r'certificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$certificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CertificationServiceRef = ProviderRef<CertificationService>;
String _$pendingCertificationsHash() =>
    r'89e5212d9a6fffb62afac2973ce67d3181efa686';

/// See also [pendingCertifications].
@ProviderFor(pendingCertifications)
final pendingCertificationsProvider =
    AutoDisposeFutureProvider<List<Certification>>.internal(
      pendingCertifications,
      name: r'pendingCertificationsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pendingCertificationsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingCertificationsRef =
    AutoDisposeFutureProviderRef<List<Certification>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
