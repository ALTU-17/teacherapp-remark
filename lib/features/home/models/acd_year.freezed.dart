// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'acd_year.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AcdYear {
  @JsonKey(name: "academic_yr")
  String? get academicYr;

  /// Create a copy of AcdYear
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AcdYearCopyWith<AcdYear> get copyWith =>
      _$AcdYearCopyWithImpl<AcdYear>(this as AcdYear, _$identity);

  /// Serializes this AcdYear to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AcdYear &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, academicYr);

  @override
  String toString() {
    return 'AcdYear(academicYr: $academicYr)';
  }
}

/// @nodoc
abstract mixin class $AcdYearCopyWith<$Res> {
  factory $AcdYearCopyWith(AcdYear value, $Res Function(AcdYear) _then) =
      _$AcdYearCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: "academic_yr") String? academicYr});
}

/// @nodoc
class _$AcdYearCopyWithImpl<$Res> implements $AcdYearCopyWith<$Res> {
  _$AcdYearCopyWithImpl(this._self, this._then);

  final AcdYear _self;
  final $Res Function(AcdYear) _then;

  /// Create a copy of AcdYear
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academicYr = freezed,
  }) {
    return _then(_self.copyWith(
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [AcdYear].
extension AcdYearPatterns on AcdYear {
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
    TResult Function(_AcdYear value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AcdYear() when $default != null:
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
    TResult Function(_AcdYear value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdYear():
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
    TResult? Function(_AcdYear value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdYear() when $default != null:
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
    TResult Function(@JsonKey(name: "academic_yr") String? academicYr)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AcdYear() when $default != null:
        return $default(_that.academicYr);
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
    TResult Function(@JsonKey(name: "academic_yr") String? academicYr) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdYear():
        return $default(_that.academicYr);
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
    TResult? Function(@JsonKey(name: "academic_yr") String? academicYr)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AcdYear() when $default != null:
        return $default(_that.academicYr);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _AcdYear implements AcdYear {
  const _AcdYear({@JsonKey(name: "academic_yr") this.academicYr});
  factory _AcdYear.fromJson(Map<String, dynamic> json) =>
      _$AcdYearFromJson(json);

  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;

  /// Create a copy of AcdYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AcdYearCopyWith<_AcdYear> get copyWith =>
      __$AcdYearCopyWithImpl<_AcdYear>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AcdYearToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AcdYear &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, academicYr);

  @override
  String toString() {
    return 'AcdYear(academicYr: $academicYr)';
  }
}

/// @nodoc
abstract mixin class _$AcdYearCopyWith<$Res> implements $AcdYearCopyWith<$Res> {
  factory _$AcdYearCopyWith(_AcdYear value, $Res Function(_AcdYear) _then) =
      __$AcdYearCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: "academic_yr") String? academicYr});
}

/// @nodoc
class __$AcdYearCopyWithImpl<$Res> implements _$AcdYearCopyWith<$Res> {
  __$AcdYearCopyWithImpl(this._self, this._then);

  final _AcdYear _self;
  final $Res Function(_AcdYear) _then;

  /// Create a copy of AcdYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? academicYr = freezed,
  }) {
    return _then(_AcdYear(
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
