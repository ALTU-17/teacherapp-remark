// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_delete_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeworkDeleteBody {
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "publish")
  String? get publish;
  @JsonKey(name: "operation")
  String? get operation;
  @JsonKey(name: "login_type")
  String? get loginType;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "section_id")
  String? get sectionId;
  @JsonKey(name: "sm_id")
  String? get smId;

  /// Create a copy of HomeworkDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeworkDeleteBodyCopyWith<HomeworkDeleteBody> get copyWith =>
      _$HomeworkDeleteBodyCopyWithImpl<HomeworkDeleteBody>(
          this as HomeworkDeleteBody, _$identity);

  /// Serializes this HomeworkDeleteBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeworkDeleteBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.smId, smId) || other.smId == smId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, publish, operation,
      loginType, academicYr, teacherId, classId, sectionId, smId);

  @override
  String toString() {
    return 'HomeworkDeleteBody(homeworkId: $homeworkId, publish: $publish, operation: $operation, loginType: $loginType, academicYr: $academicYr, teacherId: $teacherId, classId: $classId, sectionId: $sectionId, smId: $smId)';
  }
}

/// @nodoc
abstract mixin class $HomeworkDeleteBodyCopyWith<$Res> {
  factory $HomeworkDeleteBodyCopyWith(
          HomeworkDeleteBody value, $Res Function(HomeworkDeleteBody) _then) =
      _$HomeworkDeleteBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "sm_id") String? smId});
}

/// @nodoc
class _$HomeworkDeleteBodyCopyWithImpl<$Res>
    implements $HomeworkDeleteBodyCopyWith<$Res> {
  _$HomeworkDeleteBodyCopyWithImpl(this._self, this._then);

  final HomeworkDeleteBody _self;
  final $Res Function(HomeworkDeleteBody) _then;

  /// Create a copy of HomeworkDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeworkId = freezed,
    Object? publish = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? academicYr = freezed,
    Object? teacherId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? smId = freezed,
  }) {
    return _then(_self.copyWith(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
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
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeworkDeleteBody].
extension HomeworkDeleteBodyPatterns on HomeworkDeleteBody {
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
    TResult Function(_HomeworkDeleteBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkDeleteBody() when $default != null:
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
    TResult Function(_HomeworkDeleteBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkDeleteBody():
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
    TResult? Function(_HomeworkDeleteBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkDeleteBody() when $default != null:
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
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "sm_id") String? smId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkDeleteBody() when $default != null:
        return $default(
            _that.homeworkId,
            _that.publish,
            _that.operation,
            _that.loginType,
            _that.academicYr,
            _that.teacherId,
            _that.classId,
            _that.sectionId,
            _that.smId);
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
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "sm_id") String? smId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkDeleteBody():
        return $default(
            _that.homeworkId,
            _that.publish,
            _that.operation,
            _that.loginType,
            _that.academicYr,
            _that.teacherId,
            _that.classId,
            _that.sectionId,
            _that.smId);
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
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "sm_id") String? smId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkDeleteBody() when $default != null:
        return $default(
            _that.homeworkId,
            _that.publish,
            _that.operation,
            _that.loginType,
            _that.academicYr,
            _that.teacherId,
            _that.classId,
            _that.sectionId,
            _that.smId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeworkDeleteBody implements HomeworkDeleteBody {
  const _HomeworkDeleteBody(
      {@JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "publish") this.publish,
      @JsonKey(name: "operation") this.operation = 'delete',
      @JsonKey(name: "login_type") this.loginType,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "section_id") this.sectionId,
      @JsonKey(name: "sm_id") this.smId});
  factory _HomeworkDeleteBody.fromJson(Map<String, dynamic> json) =>
      _$HomeworkDeleteBodyFromJson(json);

  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "publish")
  final String? publish;
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
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "section_id")
  final String? sectionId;
  @override
  @JsonKey(name: "sm_id")
  final String? smId;

  /// Create a copy of HomeworkDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeworkDeleteBodyCopyWith<_HomeworkDeleteBody> get copyWith =>
      __$HomeworkDeleteBodyCopyWithImpl<_HomeworkDeleteBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeworkDeleteBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeworkDeleteBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.smId, smId) || other.smId == smId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, publish, operation,
      loginType, academicYr, teacherId, classId, sectionId, smId);

  @override
  String toString() {
    return 'HomeworkDeleteBody(homeworkId: $homeworkId, publish: $publish, operation: $operation, loginType: $loginType, academicYr: $academicYr, teacherId: $teacherId, classId: $classId, sectionId: $sectionId, smId: $smId)';
  }
}

/// @nodoc
abstract mixin class _$HomeworkDeleteBodyCopyWith<$Res>
    implements $HomeworkDeleteBodyCopyWith<$Res> {
  factory _$HomeworkDeleteBodyCopyWith(
          _HomeworkDeleteBody value, $Res Function(_HomeworkDeleteBody) _then) =
      __$HomeworkDeleteBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "sm_id") String? smId});
}

/// @nodoc
class __$HomeworkDeleteBodyCopyWithImpl<$Res>
    implements _$HomeworkDeleteBodyCopyWith<$Res> {
  __$HomeworkDeleteBodyCopyWithImpl(this._self, this._then);

  final _HomeworkDeleteBody _self;
  final $Res Function(_HomeworkDeleteBody) _then;

  /// Create a copy of HomeworkDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeworkId = freezed,
    Object? publish = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? academicYr = freezed,
    Object? teacherId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? smId = freezed,
  }) {
    return _then(_HomeworkDeleteBody(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
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
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
