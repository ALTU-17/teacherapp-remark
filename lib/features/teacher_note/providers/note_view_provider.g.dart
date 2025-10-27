// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_view_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$noteViewPHash() => r'319e9a80259c08f655d804e89a8064d274b29f75';

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

abstract class _$NoteViewP extends BuildlessAsyncNotifier<List<NoteView>> {
  late final Note? note;

  FutureOr<List<NoteView>> build(
    Note? note,
  );
}

/// See also [NoteViewP].
@ProviderFor(NoteViewP)
const noteViewPProvider = NoteViewPFamily();

/// See also [NoteViewP].
class NoteViewPFamily extends Family<AsyncValue<List<NoteView>>> {
  /// See also [NoteViewP].
  const NoteViewPFamily();

  /// See also [NoteViewP].
  NoteViewPProvider call(
    Note? note,
  ) {
    return NoteViewPProvider(
      note,
    );
  }

  @override
  NoteViewPProvider getProviderOverride(
    covariant NoteViewPProvider provider,
  ) {
    return call(
      provider.note,
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
  String? get name => r'noteViewPProvider';
}

/// See also [NoteViewP].
class NoteViewPProvider
    extends AsyncNotifierProviderImpl<NoteViewP, List<NoteView>> {
  /// See also [NoteViewP].
  NoteViewPProvider(
    Note? note,
  ) : this._internal(
          () => NoteViewP()..note = note,
          from: noteViewPProvider,
          name: r'noteViewPProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$noteViewPHash,
          dependencies: NoteViewPFamily._dependencies,
          allTransitiveDependencies: NoteViewPFamily._allTransitiveDependencies,
          note: note,
        );

  NoteViewPProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.note,
  }) : super.internal();

  final Note? note;

  @override
  FutureOr<List<NoteView>> runNotifierBuild(
    covariant NoteViewP notifier,
  ) {
    return notifier.build(
      note,
    );
  }

  @override
  Override overrideWith(NoteViewP Function() create) {
    return ProviderOverride(
      origin: this,
      override: NoteViewPProvider._internal(
        () => create()..note = note,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        note: note,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<NoteViewP, List<NoteView>> createElement() {
    return _NoteViewPProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NoteViewPProvider && other.note == note;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, note.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NoteViewPRef on AsyncNotifierProviderRef<List<NoteView>> {
  /// The parameter `note` of this provider.
  Note? get note;
}

class _NoteViewPProviderElement
    extends AsyncNotifierProviderElement<NoteViewP, List<NoteView>>
    with NoteViewPRef {
  _NoteViewPProviderElement(super.provider);

  @override
  Note? get note => (origin as NoteViewPProvider).note;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
