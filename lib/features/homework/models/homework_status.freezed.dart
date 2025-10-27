// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeworkStatus {
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "student_id")
  String? get studentId;
  @JsonKey(name: "homework_status")
  String? get homeworkStatus;
  @JsonKey(name: "teachercomment")
  String? get teachercomment;
  @JsonKey(name: "short_name")
  String? get shortName;

  /// Create a copy of HomeworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeworkStatusCopyWith<HomeworkStatus> get copyWith =>
      _$HomeworkStatusCopyWithImpl<HomeworkStatus>(
          this as HomeworkStatus, _$identity);

  /// Serializes this HomeworkStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeworkStatus &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.homeworkStatus, homeworkStatus) ||
                other.homeworkStatus == homeworkStatus) &&
            (identical(other.teachercomment, teachercomment) ||
                other.teachercomment == teachercomment) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, studentId,
      homeworkStatus, teachercomment, shortName);

  @override
  String toString() {
    return 'HomeworkStatus(homeworkId: $homeworkId, studentId: $studentId, homeworkStatus: $homeworkStatus, teachercomment: $teachercomment, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $HomeworkStatusCopyWith<$Res> {
  factory $HomeworkStatusCopyWith(
          HomeworkStatus value, $Res Function(HomeworkStatus) _then) =
      _$HomeworkStatusCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "homework_status") String? homeworkStatus,
      @JsonKey(name: "teachercomment") String? teachercomment,
      @JsonKey(name: "short_name") String? shortName});
}

/// @nodoc
class _$HomeworkStatusCopyWithImpl<$Res>
    implements $HomeworkStatusCopyWith<$Res> {
  _$HomeworkStatusCopyWithImpl(this._self, this._then);

  final HomeworkStatus _self;
  final $Res Function(HomeworkStatus) _then;

  /// Create a copy of HomeworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeworkId = freezed,
    Object? studentId = freezed,
    Object? homeworkStatus = freezed,
    Object? teachercomment = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_self.copyWith(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkStatus: freezed == homeworkStatus
          ? _self.homeworkStatus
          : homeworkStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      teachercomment: freezed == teachercomment
          ? _self.teachercomment
          : teachercomment // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeworkStatus].
extension HomeworkStatusPatterns on HomeworkStatus {
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
    TResult Function(_HomeworkStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkStatus() when $default != null:
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
    TResult Function(_HomeworkStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStatus():
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
    TResult? Function(_HomeworkStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStatus() when $default != null:
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
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "homework_status") String? homeworkStatus,
            @JsonKey(name: "teachercomment") String? teachercomment,
            @JsonKey(name: "short_name") String? shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkStatus() when $default != null:
        return $default(_that.homeworkId, _that.studentId, _that.homeworkStatus,
            _that.teachercomment, _that.shortName);
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
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "homework_status") String? homeworkStatus,
            @JsonKey(name: "teachercomment") String? teachercomment,
            @JsonKey(name: "short_name") String? shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStatus():
        return $default(_that.homeworkId, _that.studentId, _that.homeworkStatus,
            _that.teachercomment, _that.shortName);
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
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "homework_status") String? homeworkStatus,
            @JsonKey(name: "teachercomment") String? teachercomment,
            @JsonKey(name: "short_name") String? shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStatus() when $default != null:
        return $default(_that.homeworkId, _that.studentId, _that.homeworkStatus,
            _that.teachercomment, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeworkStatus implements HomeworkStatus {
  const _HomeworkStatus(
      {@JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "student_id") this.studentId,
      @JsonKey(name: "homework_status") this.homeworkStatus,
      @JsonKey(name: "teachercomment") this.teachercomment,
      @JsonKey(name: "short_name") this.shortName});
  factory _HomeworkStatus.fromJson(Map<String, dynamic> json) =>
      _$HomeworkStatusFromJson(json);

  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "student_id")
  final String? studentId;
  @override
  @JsonKey(name: "homework_status")
  final String? homeworkStatus;
  @override
  @JsonKey(name: "teachercomment")
  final String? teachercomment;
  @override
  @JsonKey(name: "short_name")
  final String? shortName;

  /// Create a copy of HomeworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeworkStatusCopyWith<_HomeworkStatus> get copyWith =>
      __$HomeworkStatusCopyWithImpl<_HomeworkStatus>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeworkStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeworkStatus &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.homeworkStatus, homeworkStatus) ||
                other.homeworkStatus == homeworkStatus) &&
            (identical(other.teachercomment, teachercomment) ||
                other.teachercomment == teachercomment) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, studentId,
      homeworkStatus, teachercomment, shortName);

  @override
  String toString() {
    return 'HomeworkStatus(homeworkId: $homeworkId, studentId: $studentId, homeworkStatus: $homeworkStatus, teachercomment: $teachercomment, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$HomeworkStatusCopyWith<$Res>
    implements $HomeworkStatusCopyWith<$Res> {
  factory _$HomeworkStatusCopyWith(
          _HomeworkStatus value, $Res Function(_HomeworkStatus) _then) =
      __$HomeworkStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "homework_status") String? homeworkStatus,
      @JsonKey(name: "teachercomment") String? teachercomment,
      @JsonKey(name: "short_name") String? shortName});
}

/// @nodoc
class __$HomeworkStatusCopyWithImpl<$Res>
    implements _$HomeworkStatusCopyWith<$Res> {
  __$HomeworkStatusCopyWithImpl(this._self, this._then);

  final _HomeworkStatus _self;
  final $Res Function(_HomeworkStatus) _then;

  /// Create a copy of HomeworkStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeworkId = freezed,
    Object? studentId = freezed,
    Object? homeworkStatus = freezed,
    Object? teachercomment = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_HomeworkStatus(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkStatus: freezed == homeworkStatus
          ? _self.homeworkStatus
          : homeworkStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      teachercomment: freezed == teachercomment
          ? _self.teachercomment
          : teachercomment // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
