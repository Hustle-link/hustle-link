// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_details_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$jobByIdHash() => r'6be6e114a5d154ee8fa3f0237dc8da85d66bc650';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [jobById].
@ProviderFor(jobById)
const jobByIdProvider = JobByIdFamily();

/// See also [jobById].
class JobByIdFamily extends Family<AsyncValue<JobPosting?>> {
  /// See also [jobById].
  const JobByIdFamily();

  /// See also [jobById].
  JobByIdProvider call(String jobId) {
    return JobByIdProvider(jobId);
  }

  @override
  JobByIdProvider getProviderOverride(covariant JobByIdProvider provider) {
    return call(provider.jobId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'jobByIdProvider';
}

/// See also [jobById].
class JobByIdProvider extends AutoDisposeFutureProvider<JobPosting?> {
  /// See also [jobById].
  JobByIdProvider(String jobId)
    : this._internal(
        (ref) => jobById(ref as JobByIdRef, jobId),
        from: jobByIdProvider,
        name: r'jobByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$jobByIdHash,
        dependencies: JobByIdFamily._dependencies,
        allTransitiveDependencies: JobByIdFamily._allTransitiveDependencies,
        jobId: jobId,
      );

  JobByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String jobId;

  @override
  Override overrideWith(
    FutureOr<JobPosting?> Function(JobByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JobByIdProvider._internal(
        (ref) => create(ref as JobByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        jobId: jobId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<JobPosting?> createElement() {
    return _JobByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JobByIdProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JobByIdRef on AutoDisposeFutureProviderRef<JobPosting?> {
  /// The parameter `jobId` of this provider.
  String get jobId;
}

class _JobByIdProviderElement
    extends AutoDisposeFutureProviderElement<JobPosting?>
    with JobByIdRef {
  _JobByIdProviderElement(super.provider);

  @override
  String get jobId => (origin as JobByIdProvider).jobId;
}

String _$hasAppliedHash() => r'53126ef95b12f8ca803d3b8ffbbb13280fa8c0ac';

/// See also [hasApplied].
@ProviderFor(hasApplied)
const hasAppliedProvider = HasAppliedFamily();

/// See also [hasApplied].
class HasAppliedFamily extends Family<AsyncValue<bool>> {
  /// See also [hasApplied].
  const HasAppliedFamily();

  /// See also [hasApplied].
  HasAppliedProvider call(String jobId) {
    return HasAppliedProvider(jobId);
  }

  @override
  HasAppliedProvider getProviderOverride(
    covariant HasAppliedProvider provider,
  ) {
    return call(provider.jobId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hasAppliedProvider';
}

/// See also [hasApplied].
class HasAppliedProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [hasApplied].
  HasAppliedProvider(String jobId)
    : this._internal(
        (ref) => hasApplied(ref as HasAppliedRef, jobId),
        from: hasAppliedProvider,
        name: r'hasAppliedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$hasAppliedHash,
        dependencies: HasAppliedFamily._dependencies,
        allTransitiveDependencies: HasAppliedFamily._allTransitiveDependencies,
        jobId: jobId,
      );

  HasAppliedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.jobId,
  }) : super.internal();

  final String jobId;

  @override
  Override overrideWith(
    FutureOr<bool> Function(HasAppliedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HasAppliedProvider._internal(
        (ref) => create(ref as HasAppliedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        jobId: jobId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _HasAppliedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HasAppliedProvider && other.jobId == jobId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, jobId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HasAppliedRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `jobId` of this provider.
  String get jobId;
}

class _HasAppliedProviderElement extends AutoDisposeFutureProviderElement<bool>
    with HasAppliedRef {
  _HasAppliedProviderElement(super.provider);

  @override
  String get jobId => (origin as HasAppliedProvider).jobId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
