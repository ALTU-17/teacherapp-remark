// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveState {
  List<Leave> get leaves;
  List<LeaveBalance> get leavesBalance;

  /// Create a copy of LeaveState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveStateCopyWith<LeaveState> get copyWith =>
      _$LeaveStateCopyWithImpl<LeaveState>(this as LeaveState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveState &&
            const DeepCollectionEquality().equals(other.leaves, leaves) &&
            const DeepCollectionEquality()
                .equals(other.leavesBalance, leavesBalance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(leaves),
      const DeepCollectionEquality().hash(leavesBalance));

  @override
  String toString() {
    return 'LeaveState(leaves: $leaves, leavesBalance: $leavesBalance)';
  }
}

/// @nodoc
abstract mixin class $LeaveStateCopyWith<$Res> {
  factory $LeaveStateCopyWith(
          LeaveState value, $Res Function(LeaveState) _then) =
      _$LeaveStateCopyWithImpl;
  @useResult
  $Res call({List<Leave> leaves, List<LeaveBalance> leavesBalance});
}

/// @nodoc
class _$LeaveStateCopyWithImpl<$Res> implements $LeaveStateCopyWith<$Res> {
  _$LeaveStateCopyWithImpl(this._self, this._then);

  final LeaveState _self;
  final $Res Function(LeaveState) _then;

  /// Create a copy of LeaveState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaves = null,
    Object? leavesBalance = null,
  }) {
    return _then(_self.copyWith(
      leaves: null == leaves
          ? _self.leaves
          : leaves // ignore: cast_nullable_to_non_nullable
              as List<Leave>,
      leavesBalance: null == leavesBalance
          ? _self.leavesBalance
          : leavesBalance // ignore: cast_nullable_to_non_nullable
              as List<LeaveBalance>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LeaveState].
extension LeaveStatePatterns on LeaveState {
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
    TResult Function(_LeaveState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveState() when $default != null:
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
    TResult Function(_LeaveState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveState():
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
    TResult? Function(_LeaveState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveState() when $default != null:
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
    TResult Function(List<Leave> leaves, List<LeaveBalance> leavesBalance)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LeaveState() when $default != null:
        return $default(_that.leaves, _that.leavesBalance);
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
    TResult Function(List<Leave> leaves, List<LeaveBalance> leavesBalance)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveState():
        return $default(_that.leaves, _that.leavesBalance);
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
    TResult? Function(List<Leave> leaves, List<LeaveBalance> leavesBalance)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LeaveState() when $default != null:
        return $default(_that.leaves, _that.leavesBalance);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LeaveState implements LeaveState {
  const _LeaveState(
      {final List<Leave> leaves = const [],
      final List<LeaveBalance> leavesBalance = const []})
      : _leaves = leaves,
        _leavesBalance = leavesBalance;

  final List<Leave> _leaves;
  @override
  @JsonKey()
  List<Leave> get leaves {
    if (_leaves is EqualUnmodifiableListView) return _leaves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leaves);
  }

  final List<LeaveBalance> _leavesBalance;
  @override
  @JsonKey()
  List<LeaveBalance> get leavesBalance {
    if (_leavesBalance is EqualUnmodifiableListView) return _leavesBalance;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_leavesBalance);
  }

  /// Create a copy of LeaveState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveStateCopyWith<_LeaveState> get copyWith =>
      __$LeaveStateCopyWithImpl<_LeaveState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveState &&
            const DeepCollectionEquality().equals(other._leaves, _leaves) &&
            const DeepCollectionEquality()
                .equals(other._leavesBalance, _leavesBalance));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_leaves),
      const DeepCollectionEquality().hash(_leavesBalance));

  @override
  String toString() {
    return 'LeaveState(leaves: $leaves, leavesBalance: $leavesBalance)';
  }
}

/// @nodoc
abstract mixin class _$LeaveStateCopyWith<$Res>
    implements $LeaveStateCopyWith<$Res> {
  factory _$LeaveStateCopyWith(
          _LeaveState value, $Res Function(_LeaveState) _then) =
      __$LeaveStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Leave> leaves, List<LeaveBalance> leavesBalance});
}

/// @nodoc
class __$LeaveStateCopyWithImpl<$Res> implements _$LeaveStateCopyWith<$Res> {
  __$LeaveStateCopyWithImpl(this._self, this._then);

  final _LeaveState _self;
  final $Res Function(_LeaveState) _then;

  /// Create a copy of LeaveState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? leaves = null,
    Object? leavesBalance = null,
  }) {
    return _then(_LeaveState(
      leaves: null == leaves
          ? _self._leaves
          : leaves // ignore: cast_nullable_to_non_nullable
              as List<Leave>,
      leavesBalance: null == leavesBalance
          ? _self._leavesBalance
          : leavesBalance // ignore: cast_nullable_to_non_nullable
              as List<LeaveBalance>,
    ));
  }
}

// dart format on
