// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'h_s_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hSStatusHash() => r'41fcccf97b91b06aa13a4a086c52d41330b96c0a';

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

abstract class _$HSStatus
    extends BuildlessAsyncNotifier<List<HomeworkStudentStatus>> {
  late final Homework? homework;

  FutureOr<List<HomeworkStudentStatus>> build(
    Homework? homework,
  );
}

/// See also [HSStatus].
@ProviderFor(HSStatus)
const hSStatusProvider = HSStatusFamily();

/// See also [HSStatus].
class HSStatusFamily extends Family<AsyncValue<List<HomeworkStudentStatus>>> {
  /// See also [HSStatus].
  const HSStatusFamily();

  /// See also [HSStatus].
  HSStatusProvider call(
    Homework? homework,
  ) {
    return HSStatusProvider(
      homework,
    );
  }

  @override
  HSStatusProvider getProviderOverride(
    covariant HSStatusProvider provider,
  ) {
    return call(
      provider.homework,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'hSStatusProvider';
}

/// See also [HSStatus].
class HSStatusProvider
    extends AsyncNotifierProviderImpl<HSStatus, List<HomeworkStudentStatus>> {
  /// See also [HSStatus].
  HSStatusProvider(
    Homework? homework,
  ) : this._internal(
          () => HSStatus()..homework = homework,
          from: hSStatusProvider,
          name: r'hSStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hSStatusHash,
          dependencies: HSStatusFamily._dependencies,
          allTransitiveDependencies: HSStatusFamily._allTransitiveDependencies,
          homework: homework,
        );

  HSStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.homework,
  }) : super.internal();

  final Homework? homework;

  @override
  FutureOr<List<HomeworkStudentStatus>> runNotifierBuild(
    covariant HSStatus notifier,
  ) {
    return notifier.build(
      homework,
    );
  }

  @override
  Override overrideWith(HSStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: HSStatusProvider._internal(
        () => create()..homework = homework,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        homework: homework,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<HSStatus, List<HomeworkStudentStatus>>
      createElement() {
    return _HSStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HSStatusProvider && other.homework == homework;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, homework.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin HSStatusRef on AsyncNotifierProviderRef<List<HomeworkStudentStatus>> {
  /// The parameter `homework` of this provider.
  Homework? get homework;
}

class _HSStatusProviderElement
    extends AsyncNotifierProviderElement<HSStatus, List<HomeworkStudentStatus>>
    with HSStatusRef {
  _HSStatusProviderElement(super.provider);

  @override
  Homework? get homework => (origin as HSStatusProvider).homework;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
