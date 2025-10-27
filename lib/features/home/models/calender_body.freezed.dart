// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calender_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalenderBody {
  @JsonKey(name: "short_name")
  String? get shortName;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "reg_id")
  String? get regId;
  @JsonKey(name: "month")
  String? get month;
  @JsonKey(name: "section_name")
  String? get sectionName;
  @JsonKey(name: "year")
  String? get year;

  /// Create a copy of CalenderBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalenderBodyCopyWith<CalenderBody> get copyWith =>
      _$CalenderBodyCopyWithImpl<CalenderBody>(
          this as CalenderBody, _$identity);

  /// Serializes this CalenderBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalenderBody &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, shortName, academicYr, regId, month, sectionName, year);

  @override
  String toString() {
    return 'CalenderBody(shortName: $shortName, academicYr: $academicYr, regId: $regId, month: $month, sectionName: $sectionName, year: $year)';
  }
}

/// @nodoc
abstract mixin class $CalenderBodyCopyWith<$Res> {
  factory $CalenderBodyCopyWith(
          CalenderBody value, $Res Function(CalenderBody) _then) =
      _$CalenderBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "reg_id") String? regId,
      @JsonKey(name: "month") String? month,
      @JsonKey(name: "section_name") String? sectionName,
      @JsonKey(name: "year") String? year});
}

/// @nodoc
class _$CalenderBodyCopyWithImpl<$Res> implements $CalenderBodyCopyWith<$Res> {
  _$CalenderBodyCopyWithImpl(this._self, this._then);

  final CalenderBody _self;
  final $Res Function(CalenderBody) _then;

  /// Create a copy of CalenderBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = freezed,
    Object? academicYr = freezed,
    Object? regId = freezed,
    Object? month = freezed,
    Object? sectionName = freezed,
    Object? year = freezed,
  }) {
    return _then(_self.copyWith(
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionName: freezed == sectionName
          ? _self.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CalenderBody].
extension CalenderBodyPatterns on CalenderBody {
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
    TResult Function(_CalenderBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalenderBody() when $default != null:
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
    TResult Function(_CalenderBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalenderBody():
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
    TResult? Function(_CalenderBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalenderBody() when $default != null:
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
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "reg_id") String? regId,
            @JsonKey(name: "month") String? month,
            @JsonKey(name: "section_name") String? sectionName,
            @JsonKey(name: "year") String? year)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CalenderBody() when $default != null:
        return $default(_that.shortName, _that.academicYr, _that.regId,
            _that.month, _that.sectionName, _that.year);
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
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "reg_id") String? regId,
            @JsonKey(name: "month") String? month,
            @JsonKey(name: "section_name") String? sectionName,
            @JsonKey(name: "year") String? year)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalenderBody():
        return $default(_that.shortName, _that.academicYr, _that.regId,
            _that.month, _that.sectionName, _that.year);
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
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "reg_id") String? regId,
            @JsonKey(name: "month") String? month,
            @JsonKey(name: "section_name") String? sectionName,
            @JsonKey(name: "year") String? year)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CalenderBody() when $default != null:
        return $default(_that.shortName, _that.academicYr, _that.regId,
            _that.month, _that.sectionName, _that.year);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CalenderBody implements CalenderBody {
  const _CalenderBody(
      {@JsonKey(name: "short_name") this.shortName,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "reg_id") this.regId,
      @JsonKey(name: "month") this.month,
      @JsonKey(name: "section_name") this.sectionName,
      @JsonKey(name: "year") this.year});
  factory _CalenderBody.fromJson(Map<String, dynamic> json) =>
      _$CalenderBodyFromJson(json);

  @override
  @JsonKey(name: "short_name")
  final String? shortName;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "reg_id")
  final String? regId;
  @override
  @JsonKey(name: "month")
  final String? month;
  @override
  @JsonKey(name: "section_name")
  final String? sectionName;
  @override
  @JsonKey(name: "year")
  final String? year;

  /// Create a copy of CalenderBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalenderBodyCopyWith<_CalenderBody> get copyWith =>
      __$CalenderBodyCopyWithImpl<_CalenderBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CalenderBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalenderBody &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.sectionName, sectionName) ||
                other.sectionName == sectionName) &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, shortName, academicYr, regId, month, sectionName, year);

  @override
  String toString() {
    return 'CalenderBody(shortName: $shortName, academicYr: $academicYr, regId: $regId, month: $month, sectionName: $sectionName, year: $year)';
  }
}

/// @nodoc
abstract mixin class _$CalenderBodyCopyWith<$Res>
    implements $CalenderBodyCopyWith<$Res> {
  factory _$CalenderBodyCopyWith(
          _CalenderBody value, $Res Function(_CalenderBody) _then) =
      __$CalenderBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "reg_id") String? regId,
      @JsonKey(name: "month") String? month,
      @JsonKey(name: "section_name") String? sectionName,
      @JsonKey(name: "year") String? year});
}

/// @nodoc
class __$CalenderBodyCopyWithImpl<$Res>
    implements _$CalenderBodyCopyWith<$Res> {
  __$CalenderBodyCopyWithImpl(this._self, this._then);

  final _CalenderBody _self;
  final $Res Function(_CalenderBody) _then;

  /// Create a copy of CalenderBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shortName = freezed,
    Object? academicYr = freezed,
    Object? regId = freezed,
    Object? month = freezed,
    Object? sectionName = freezed,
    Object? year = freezed,
  }) {
    return _then(_CalenderBody(
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      month: freezed == month
          ? _self.month
          : month // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionName: freezed == sectionName
          ? _self.sectionName
          : sectionName // ignore: cast_nullable_to_non_nullable
              as String?,
      year: freezed == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
