// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeworkViewHash() => r'8559381e1ff244a2c33e33617ec7b1ac7dbff1ba';

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

abstract class _$HomeworkView
    extends BuildlessAsyncNotifier<List<HomeworkViewByParent>> {
  late final Homework? homework;

  FutureOr<List<HomeworkViewByParent>> build(
    Homework? homework,
  );
}

/// See also [HomeworkView].
@ProviderFor(HomeworkView)
const homeworkViewProvider = HomeworkViewFamily();

/// See also [HomeworkView].
class HomeworkViewFamily
    extends Family<AsyncValue<List<HomeworkViewByParent>>> {
  /// See also [HomeworkView].
  const HomeworkViewFamily();

  /// See also [HomeworkView].
  HomeworkViewProvider call(
    Homework? homework,
  ) {
    return HomeworkViewProvider(
      homework,
    );
  }

  @override
  HomeworkViewProvider getProviderOverride(
    covariant HomeworkViewProvider provider,
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
  String? get name => r'homeworkViewProvider';
}

/// See also [HomeworkView].
class HomeworkViewProvider extends AsyncNotifierProviderImpl<HomeworkView,
    List<HomeworkViewByParent>> {
  /// See also [HomeworkView].
  HomeworkViewProvider(
    Homework? homework,
  ) : this._internal(
          () => HomeworkView()..homework = homework,
          from: homeworkViewProvider,
          name: r'homeworkViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$homeworkViewHash,
          dependencies: HomeworkViewFamily._dependencies,
          allTransitiveDependencies:
              HomeworkViewFamily._allTransitiveDependencies,
          homework: homework,
        );

  HomeworkViewProvider._internal(
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
  FutureOr<List<HomeworkViewByParent>> runNotifierBuild(
    covariant HomeworkView notifier,
  ) {
    return notifier.build(
      homework,
    );
  }

  @override
  Override overrideWith(HomeworkView Function() create) {
    return ProviderOverride(
      origin: this,
      override: HomeworkViewProvider._internal(
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
  AsyncNotifierProviderElement<HomeworkView, List<HomeworkViewByParent>>
      createElement() {
    return _HomeworkViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HomeworkViewProvider && other.homework == homework;
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
mixin HomeworkViewRef on AsyncNotifierProviderRef<List<HomeworkViewByParent>> {
  /// The parameter `homework` of this provider.
  Homework? get homework;
}

class _HomeworkViewProviderElement extends AsyncNotifierProviderElement<
    HomeworkView, List<HomeworkViewByParent>> with HomeworkViewRef {
  _HomeworkViewProviderElement(super.provider);

  @override
  Homework? get homework => (origin as HomeworkViewProvider).homework;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
