// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'acd_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AcdState {
  List<AcdYear> get academicYrs;
  String get selectedYear;

  /// Create a copy of AcdState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AcdStateCopyWith<AcdState> get copyWith =>
      _$AcdStateCopyWithImpl<AcdState>(this as AcdState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AcdState &&
            const DeepCollectionEquality()
                .equals(other.academicYrs, academicYrs) &&
            (identical(other.selectedYear, selectedYear) ||
                other.selectedYear == selectedYear));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(academicYrs), selectedYear);

  @override
  String toString() {
    return 'AcdState(academicYrs: $academicYrs, selectedYear: $selectedYear)';
  }
}

/// @nodoc
abstract mixin class $AcdStateCopyWith<$Res> {
  factory $AcdStateCopyWith(AcdState value, $Res Function(AcdState) _then) =
      _$AcdStateCopyWithImpl;
  @useResult
  $Res call({List<AcdYear> academicYrs, String selectedYear});
}

/// @nodoc
class _$AcdStateCopyWithImpl<$Res> implements $AcdStateCopyWith<$Res> {
  _$AcdStateCopyWithImpl(this._self, this._then);

  final AcdState _self;
  final $Res Function(AcdState) _then;

  /// Create a copy of AcdState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academicYrs = null,
    Object? selectedYear = null,
  }) {
    return _then(_self.copyWith(
      academicYrs: null == academicYrs
          ? _self.academicYrs
          : academicYrs // ignore: cast_nullable_to_non_nullable
              as List<AcdYear>,
      selectedYear: null == selectedYear
          ? _self.selectedYear
          : selectedYear // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [AcdState].
extension AcdStatePatterns on AcdState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_AcdState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AcdState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_AcdState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdState():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_AcdState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<AcdYear> academicYrs, String selectedYear)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AcdState() when $default != null:
        return $default(_that.academicYrs, _that.selectedYear);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<AcdYear> academicYrs, String selectedYear) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdState():
        return $default(_that.academicYrs, _that.selectedYear);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(List<AcdYear> academicYrs, String selectedYear)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdState() when $default != null:
        return $default(_that.academicYrs, _that.selectedYear);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AcdState implements AcdState {
  const _AcdState(
      {final List<AcdYear> academicYrs = const [],
      this.selectedYear = '2025-2026'})
      : _academicYrs = academicYrs;

  final List<AcdYear> _academicYrs;
  @override
  @JsonKey()
  List<AcdYear> get academicYrs {
    if (_academicYrs is EqualUnmodifiableListView) return _academicYrs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_academicYrs);
  }

  @override
  @JsonKey()
  final String selectedYear;

  /// Create a copy of AcdState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AcdStateCopyWith<_AcdState> get copyWith =>
      __$AcdStateCopyWithImpl<_AcdState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AcdState &&
            const DeepCollectionEquality()
                .equals(other._academicYrs, _academicYrs) &&
            (identical(other.selectedYear, selectedYear) ||
                other.selectedYear == selectedYear));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_academicYrs), selectedYear);

  @override
  String toString() {
    return 'AcdState(academicYrs: $academicYrs, selectedYear: $selectedYear)';
  }
}

/// @nodoc
abstract mixin class _$AcdStateCopyWith<$Res>
    implements $AcdStateCopyWith<$Res> {
  factory _$AcdStateCopyWith(_AcdState value, $Res Function(_AcdState) _then) =
      __$AcdStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<AcdYear> academicYrs, String selectedYear});
}

/// @nodoc
class __$AcdStateCopyWithImpl<$Res> implements _$AcdStateCopyWith<$Res> {
  __$AcdStateCopyWithImpl(this._self, this._then);

  final _AcdState _self;
  final $Res Function(_AcdState) _then;

  /// Create a copy of AcdState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? academicYrs = null,
    Object? selectedYear = null,
  }) {
    return _then(_AcdState(
      academicYrs: null == academicYrs
          ? _self._academicYrs
          : academicYrs // ignore: cast_nullable_to_non_nullable
              as List<AcdYear>,
      selectedYear: null == selectedYear
          ? _self.selectedYear
          : selectedYear // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
