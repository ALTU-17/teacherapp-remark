// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'balance_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BalanceBody {
  @JsonKey(name: 'acd_yr')
  String get acdYr;
  @JsonKey(name: 'reg_id')
  String get regId;
  @JsonKey(name: 'short_name')
  String get shortName;

  /// Create a copy of BalanceBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BalanceBodyCopyWith<BalanceBody> get copyWith =>
      _$BalanceBodyCopyWithImpl<BalanceBody>(this as BalanceBody, _$identity);

  /// Serializes this BalanceBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BalanceBody &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, acdYr, regId, shortName);

  @override
  String toString() {
    return 'BalanceBody(acdYr: $acdYr, regId: $regId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $BalanceBodyCopyWith<$Res> {
  factory $BalanceBodyCopyWith(
          BalanceBody value, $Res Function(BalanceBody) _then) =
      _$BalanceBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'acd_yr') String acdYr,
      @JsonKey(name: 'reg_id') String regId,
      @JsonKey(name: 'short_name') String shortName});
}

/// @nodoc
class _$BalanceBodyCopyWithImpl<$Res> implements $BalanceBodyCopyWith<$Res> {
  _$BalanceBodyCopyWithImpl(this._self, this._then);

  final BalanceBody _self;
  final $Res Function(BalanceBody) _then;

  /// Create a copy of BalanceBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acdYr = null,
    Object? regId = null,
    Object? shortName = null,
  }) {
    return _then(_self.copyWith(
      acdYr: null == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [BalanceBody].
extension BalanceBodyPatterns on BalanceBody {
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
    TResult Function(_BalanceBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BalanceBody() when $default != null:
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
    TResult Function(_BalanceBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BalanceBody():
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
    TResult? Function(_BalanceBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BalanceBody() when $default != null:
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
    TResult Function(
            @JsonKey(name: 'acd_yr') String acdYr,
            @JsonKey(name: 'reg_id') String regId,
            @JsonKey(name: 'short_name') String shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BalanceBody() when $default != null:
        return $default(_that.acdYr, _that.regId, _that.shortName);
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
    TResult Function(
            @JsonKey(name: 'acd_yr') String acdYr,
            @JsonKey(name: 'reg_id') String regId,
            @JsonKey(name: 'short_name') String shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BalanceBody():
        return $default(_that.acdYr, _that.regId, _that.shortName);
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
    TResult? Function(
            @JsonKey(name: 'acd_yr') String acdYr,
            @JsonKey(name: 'reg_id') String regId,
            @JsonKey(name: 'short_name') String shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BalanceBody() when $default != null:
        return $default(_that.acdYr, _that.regId, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _BalanceBody implements BalanceBody {
  const _BalanceBody(
      {@JsonKey(name: 'acd_yr') required this.acdYr,
      @JsonKey(name: 'reg_id') required this.regId,
      @JsonKey(name: 'short_name') required this.shortName});
  factory _BalanceBody.fromJson(Map<String, dynamic> json) =>
      _$BalanceBodyFromJson(json);

  @override
  @JsonKey(name: 'acd_yr')
  final String acdYr;
  @override
  @JsonKey(name: 'reg_id')
  final String regId;
  @override
  @JsonKey(name: 'short_name')
  final String shortName;

  /// Create a copy of BalanceBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BalanceBodyCopyWith<_BalanceBody> get copyWith =>
      __$BalanceBodyCopyWithImpl<_BalanceBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BalanceBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BalanceBody &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, acdYr, regId, shortName);

  @override
  String toString() {
    return 'BalanceBody(acdYr: $acdYr, regId: $regId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$BalanceBodyCopyWith<$Res>
    implements $BalanceBodyCopyWith<$Res> {
  factory _$BalanceBodyCopyWith(
          _BalanceBody value, $Res Function(_BalanceBody) _then) =
      __$BalanceBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'acd_yr') String acdYr,
      @JsonKey(name: 'reg_id') String regId,
      @JsonKey(name: 'short_name') String shortName});
}

/// @nodoc
class __$BalanceBodyCopyWithImpl<$Res> implements _$BalanceBodyCopyWith<$Res> {
  __$BalanceBodyCopyWithImpl(this._self, this._then);

  final _BalanceBody _self;
  final $Res Function(_BalanceBody) _then;

  /// Create a copy of BalanceBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? acdYr = null,
    Object? regId = null,
    Object? shortName = null,
  }) {
    return _then(_BalanceBody(
      acdYr: null == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
