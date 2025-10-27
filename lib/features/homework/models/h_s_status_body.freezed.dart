// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'h_s_status_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HSStatusBody {
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "operation")
  String? get operation;
  @JsonKey(name: "login_type")
  String? get loginType;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "short_name")
  String? get shortName;

  /// Create a copy of HSStatusBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HSStatusBodyCopyWith<HSStatusBody> get copyWith =>
      _$HSStatusBodyCopyWithImpl<HSStatusBody>(
          this as HSStatusBody, _$identity);

  /// Serializes this HSStatusBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HSStatusBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, operation, loginType,
      academicYr, teacherId, shortName);

  @override
  String toString() {
    return 'HSStatusBody(homeworkId: $homeworkId, operation: $operation, loginType: $loginType, academicYr: $academicYr, teacherId: $teacherId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $HSStatusBodyCopyWith<$Res> {
  factory $HSStatusBodyCopyWith(
          HSStatusBody value, $Res Function(HSStatusBody) _then) =
      _$HSStatusBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "short_name") String? shortName});
}

/// @nodoc
class _$HSStatusBodyCopyWithImpl<$Res> implements $HSStatusBodyCopyWith<$Res> {
  _$HSStatusBodyCopyWithImpl(this._self, this._then);

  final HSStatusBody _self;
  final $Res Function(HSStatusBody) _then;

  /// Create a copy of HSStatusBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeworkId = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? academicYr = freezed,
    Object? teacherId = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_self.copyWith(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HSStatusBody].
extension HSStatusBodyPatterns on HSStatusBody {
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
    TResult Function(_HSStatusBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HSStatusBody() when $default != null:
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
    TResult Function(_HSStatusBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HSStatusBody():
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
    TResult? Function(_HSStatusBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HSStatusBody() when $default != null:
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "short_name") String? shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HSStatusBody() when $default != null:
        return $default(_that.homeworkId, _that.operation, _that.loginType,
            _that.academicYr, _that.teacherId, _that.shortName);
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "short_name") String? shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HSStatusBody():
        return $default(_that.homeworkId, _that.operation, _that.loginType,
            _that.academicYr, _that.teacherId, _that.shortName);
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "short_name") String? shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HSStatusBody() when $default != null:
        return $default(_that.homeworkId, _that.operation, _that.loginType,
            _that.academicYr, _that.teacherId, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HSStatusBody implements HSStatusBody {
  const _HSStatusBody(
      {@JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "operation") this.operation = 'HWStatus',
      @JsonKey(name: "login_type") this.loginType = 'T',
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "short_name") this.shortName});
  factory _HSStatusBody.fromJson(Map<String, dynamic> json) =>
      _$HSStatusBodyFromJson(json);

  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "operation")
  final String? operation;
  @override
  @JsonKey(name: "login_type")
  final String? loginType;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "teacher_id")
  final String? teacherId;
  @override
  @JsonKey(name: "short_name")
  final String? shortName;

  /// Create a copy of HSStatusBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HSStatusBodyCopyWith<_HSStatusBody> get copyWith =>
      __$HSStatusBodyCopyWithImpl<_HSStatusBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HSStatusBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HSStatusBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, operation, loginType,
      academicYr, teacherId, shortName);

  @override
  String toString() {
    return 'HSStatusBody(homeworkId: $homeworkId, operation: $operation, loginType: $loginType, academicYr: $academicYr, teacherId: $teacherId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$HSStatusBodyCopyWith<$Res>
    implements $HSStatusBodyCopyWith<$Res> {
  factory _$HSStatusBodyCopyWith(
          _HSStatusBody value, $Res Function(_HSStatusBody) _then) =
      __$HSStatusBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "short_name") String? shortName});
}

/// @nodoc
class __$HSStatusBodyCopyWithImpl<$Res>
    implements _$HSStatusBodyCopyWith<$Res> {
  __$HSStatusBodyCopyWithImpl(this._self, this._then);

  final _HSStatusBody _self;
  final $Res Function(_HSStatusBody) _then;

  /// Create a copy of HSStatusBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeworkId = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? academicYr = freezed,
    Object? teacherId = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_HSStatusBody(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
