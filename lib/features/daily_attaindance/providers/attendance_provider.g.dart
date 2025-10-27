// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendancePHash() => r'5914f2804f9a327ac0c1e2a41411b13a5711e886';

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

abstract class _$AttendanceP
    extends BuildlessAutoDisposeAsyncNotifier<AttendanceState> {
  late final StudentBody param;

  FutureOr<AttendanceState> build(
    StudentBody param,
  );
}

/// See also [AttendanceP].
@ProviderFor(AttendanceP)
const attendancePProvider = AttendancePFamily();

/// See also [AttendanceP].
class AttendancePFamily extends Family<AsyncValue<AttendanceState>> {
  /// See also [AttendanceP].
  const AttendancePFamily();

  /// See also [AttendanceP].
  AttendancePProvider call(
    StudentBody param,
  ) {
    return AttendancePProvider(
      param,
    );
  }

  @override
  AttendancePProvider getProviderOverride(
    covariant AttendancePProvider provider,
  ) {
    return call(
      provider.param,
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
  String? get name => r'attendancePProvider';
}

/// See also [AttendanceP].
class AttendancePProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AttendanceP, AttendanceState> {
  /// See also [AttendanceP].
  AttendancePProvider(
    StudentBody param,
  ) : this._internal(
          () => AttendanceP()..param = param,
          from: attendancePProvider,
          name: r'attendancePProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendancePHash,
          dependencies: AttendancePFamily._dependencies,
          allTransitiveDependencies:
              AttendancePFamily._allTransitiveDependencies,
          param: param,
        );

  AttendancePProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final StudentBody param;

  @override
  FutureOr<AttendanceState> runNotifierBuild(
    covariant AttendanceP notifier,
  ) {
    return notifier.build(
      param,
    );
  }

  @override
  Override overrideWith(AttendanceP Function() create) {
    return ProviderOverride(
      origin: this,
      override: AttendancePProvider._internal(
        () => create()..param = param,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AttendanceP, AttendanceState>
      createElement() {
    return _AttendancePProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AttendancePProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AttendancePRef on AutoDisposeAsyncNotifierProviderRef<AttendanceState> {
  /// The parameter `param` of this provider.
  StudentBody get param;
}

class _AttendancePProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AttendanceP,
        AttendanceState> with AttendancePRef {
  _AttendancePProviderElement(super.provider);

  @override
  StudentBody get param => (origin as AttendancePProvider).param;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
