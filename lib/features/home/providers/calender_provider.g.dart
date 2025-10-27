// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calender_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$calenderPHash() => r'3fb2a083a46a330d02eb577f40b76087a951f45d';

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

abstract class _$CalenderP
    extends BuildlessAutoDisposeAsyncNotifier<Calender?> {
  late final CalenderBody cal;

  FutureOr<Calender?> build(
    CalenderBody cal,
  );
}

/// See also [CalenderP].
@ProviderFor(CalenderP)
const calenderPProvider = CalenderPFamily();

/// See also [CalenderP].
class CalenderPFamily extends Family<AsyncValue<Calender?>> {
  /// See also [CalenderP].
  const CalenderPFamily();

  /// See also [CalenderP].
  CalenderPProvider call(
    CalenderBody cal,
  ) {
    return CalenderPProvider(
      cal,
    );
  }

  @override
  CalenderPProvider getProviderOverride(
    covariant CalenderPProvider provider,
  ) {
    return call(
      provider.cal,
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
  String? get name => r'calenderPProvider';
}

/// See also [CalenderP].
class CalenderPProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CalenderP, Calender?> {
  /// See also [CalenderP].
  CalenderPProvider(
    CalenderBody cal,
  ) : this._internal(
          () => CalenderP()..cal = cal,
          from: calenderPProvider,
          name: r'calenderPProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$calenderPHash,
          dependencies: CalenderPFamily._dependencies,
          allTransitiveDependencies: CalenderPFamily._allTransitiveDependencies,
          cal: cal,
        );

  CalenderPProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cal,
  }) : super.internal();

  final CalenderBody cal;

  @override
  FutureOr<Calender?> runNotifierBuild(
    covariant CalenderP notifier,
  ) {
    return notifier.build(
      cal,
    );
  }

  @override
  Override overrideWith(CalenderP Function() create) {
    return ProviderOverride(
      origin: this,
      override: CalenderPProvider._internal(
        () => create()..cal = cal,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cal: cal,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CalenderP, Calender?>
      createElement() {
    return _CalenderPProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CalenderPProvider && other.cal == cal;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cal.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CalenderPRef on AutoDisposeAsyncNotifierProviderRef<Calender?> {
  /// The parameter `cal` of this provider.
  CalenderBody get cal;
}

class _CalenderPProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CalenderP, Calender?>
    with CalenderPRef {
  _CalenderPProviderElement(super.provider);

  @override
  CalenderBody get cal => (origin as CalenderPProvider).cal;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
