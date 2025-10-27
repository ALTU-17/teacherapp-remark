// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multi_sub_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MultiSubBody {
  @JsonKey(name: "academic_yr")
  String get academicYr;
  @JsonKey(name: "reg_id")
  String get regId;
  @JsonKey(name: "short_name")
  String get shortName;
  @JsonKey(name: "str_array")
  List<ClassInfo> get strArray;

  /// Create a copy of MultiSubBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MultiSubBodyCopyWith<MultiSubBody> get copyWith =>
      _$MultiSubBodyCopyWithImpl<MultiSubBody>(
          this as MultiSubBody, _$identity);

  /// Serializes this MultiSubBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MultiSubBody &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            const DeepCollectionEquality().equals(other.strArray, strArray));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, academicYr, regId, shortName,
      const DeepCollectionEquality().hash(strArray));

  @override
  String toString() {
    return 'MultiSubBody(academicYr: $academicYr, regId: $regId, shortName: $shortName, strArray: $strArray)';
  }
}

/// @nodoc
abstract mixin class $MultiSubBodyCopyWith<$Res> {
  factory $MultiSubBodyCopyWith(
          MultiSubBody value, $Res Function(MultiSubBody) _then) =
      _$MultiSubBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "academic_yr") String academicYr,
      @JsonKey(name: "reg_id") String regId,
      @JsonKey(name: "short_name") String shortName,
      @JsonKey(name: "str_array") List<ClassInfo> strArray});
}

/// @nodoc
class _$MultiSubBodyCopyWithImpl<$Res> implements $MultiSubBodyCopyWith<$Res> {
  _$MultiSubBodyCopyWithImpl(this._self, this._then);

  final MultiSubBody _self;
  final $Res Function(MultiSubBody) _then;

  /// Create a copy of MultiSubBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academicYr = null,
    Object? regId = null,
    Object? shortName = null,
    Object? strArray = null,
  }) {
    return _then(_self.copyWith(
      academicYr: null == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      strArray: null == strArray
          ? _self.strArray
          : strArray // ignore: cast_nullable_to_non_nullable
              as List<ClassInfo>,
    ));
  }
}

/// Adds pattern-matching-related methods to [MultiSubBody].
extension MultiSubBodyPatterns on MultiSubBody {
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
    TResult Function(_MultiSubBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MultiSubBody() when $default != null:
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
    TResult Function(_MultiSubBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSubBody():
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
    TResult? Function(_MultiSubBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSubBody() when $default != null:
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
            @JsonKey(name: "academic_yr") String academicYr,
            @JsonKey(name: "reg_id") String regId,
            @JsonKey(name: "short_name") String shortName,
            @JsonKey(name: "str_array") List<ClassInfo> strArray)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MultiSubBody() when $default != null:
        return $default(
            _that.academicYr, _that.regId, _that.shortName, _that.strArray);
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
            @JsonKey(name: "academic_yr") String academicYr,
            @JsonKey(name: "reg_id") String regId,
            @JsonKey(name: "short_name") String shortName,
            @JsonKey(name: "str_array") List<ClassInfo> strArray)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSubBody():
        return $default(
            _that.academicYr, _that.regId, _that.shortName, _that.strArray);
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
            @JsonKey(name: "academic_yr") String academicYr,
            @JsonKey(name: "reg_id") String regId,
            @JsonKey(name: "short_name") String shortName,
            @JsonKey(name: "str_array") List<ClassInfo> strArray)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSubBody() when $default != null:
        return $default(
            _that.academicYr, _that.regId, _that.shortName, _that.strArray);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MultiSubBody implements MultiSubBody {
  const _MultiSubBody(
      {@JsonKey(name: "academic_yr") required this.academicYr,
      @JsonKey(name: "reg_id") required this.regId,
      @JsonKey(name: "short_name") required this.shortName,
      @JsonKey(name: "str_array") required final List<ClassInfo> strArray})
      : _strArray = strArray;
  factory _MultiSubBody.fromJson(Map<String, dynamic> json) =>
      _$MultiSubBodyFromJson(json);

  @override
  @JsonKey(name: "academic_yr")
  final String academicYr;
  @override
  @JsonKey(name: "reg_id")
  final String regId;
  @override
  @JsonKey(name: "short_name")
  final String shortName;
  final List<ClassInfo> _strArray;
  @override
  @JsonKey(name: "str_array")
  List<ClassInfo> get strArray {
    if (_strArray is EqualUnmodifiableListView) return _strArray;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_strArray);
  }

  /// Create a copy of MultiSubBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MultiSubBodyCopyWith<_MultiSubBody> get copyWith =>
      __$MultiSubBodyCopyWithImpl<_MultiSubBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MultiSubBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiSubBody &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            const DeepCollectionEquality().equals(other._strArray, _strArray));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, academicYr, regId, shortName,
      const DeepCollectionEquality().hash(_strArray));

  @override
  String toString() {
    return 'MultiSubBody(academicYr: $academicYr, regId: $regId, shortName: $shortName, strArray: $strArray)';
  }
}

/// @nodoc
abstract mixin class _$MultiSubBodyCopyWith<$Res>
    implements $MultiSubBodyCopyWith<$Res> {
  factory _$MultiSubBodyCopyWith(
          _MultiSubBody value, $Res Function(_MultiSubBody) _then) =
      __$MultiSubBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "academic_yr") String academicYr,
      @JsonKey(name: "reg_id") String regId,
      @JsonKey(name: "short_name") String shortName,
      @JsonKey(name: "str_array") List<ClassInfo> strArray});
}

/// @nodoc
class __$MultiSubBodyCopyWithImpl<$Res>
    implements _$MultiSubBodyCopyWith<$Res> {
  __$MultiSubBodyCopyWithImpl(this._self, this._then);

  final _MultiSubBody _self;
  final $Res Function(_MultiSubBody) _then;

  /// Create a copy of MultiSubBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? academicYr = null,
    Object? regId = null,
    Object? shortName = null,
    Object? strArray = null,
  }) {
    return _then(_MultiSubBody(
      academicYr: null == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      strArray: null == strArray
          ? _self._strArray
          : strArray // ignore: cast_nullable_to_non_nullable
              as List<ClassInfo>,
    ));
  }
}

// dart format on
