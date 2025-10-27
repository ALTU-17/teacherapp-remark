// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_view_by_parent.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeworkViewByParent {
  @JsonKey(name: "roll_no")
  String? get rollNo;
  @JsonKey(name: "first_name")
  String? get firstName;
  @JsonKey(name: "mid_name")
  String? get midName;
  @JsonKey(name: "last_name")
  String? get lastName;
  @JsonKey(name: "read_status")
  String? get readStatus;
  @JsonKey(name: "student_id")
  String? get studentId;
  @JsonKey(name: "attachment")
  DocHomework? get attachment;

  /// Create a copy of HomeworkViewByParent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeworkViewByParentCopyWith<HomeworkViewByParent> get copyWith =>
      _$HomeworkViewByParentCopyWithImpl<HomeworkViewByParent>(
          this as HomeworkViewByParent, _$identity);

  /// Serializes this HomeworkViewByParent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeworkViewByParent &&
            (identical(other.rollNo, rollNo) || other.rollNo == rollNo) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.midName, midName) || other.midName == midName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.readStatus, readStatus) ||
                other.readStatus == readStatus) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.attachment, attachment) ||
                other.attachment == attachment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rollNo, firstName, midName,
      lastName, readStatus, studentId, attachment);

  @override
  String toString() {
    return 'HomeworkViewByParent(rollNo: $rollNo, firstName: $firstName, midName: $midName, lastName: $lastName, readStatus: $readStatus, studentId: $studentId, attachment: $attachment)';
  }
}

/// @nodoc
abstract mixin class $HomeworkViewByParentCopyWith<$Res> {
  factory $HomeworkViewByParentCopyWith(HomeworkViewByParent value,
          $Res Function(HomeworkViewByParent) _then) =
      _$HomeworkViewByParentCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "roll_no") String? rollNo,
      @JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "mid_name") String? midName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "read_status") String? readStatus,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "attachment") DocHomework? attachment});

  $DocHomeworkCopyWith<$Res>? get attachment;
}

/// @nodoc
class _$HomeworkViewByParentCopyWithImpl<$Res>
    implements $HomeworkViewByParentCopyWith<$Res> {
  _$HomeworkViewByParentCopyWithImpl(this._self, this._then);

  final HomeworkViewByParent _self;
  final $Res Function(HomeworkViewByParent) _then;

  /// Create a copy of HomeworkViewByParent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rollNo = freezed,
    Object? firstName = freezed,
    Object? midName = freezed,
    Object? lastName = freezed,
    Object? readStatus = freezed,
    Object? studentId = freezed,
    Object? attachment = freezed,
  }) {
    return _then(_self.copyWith(
      rollNo: freezed == rollNo
          ? _self.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      midName: freezed == midName
          ? _self.midName
          : midName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      readStatus: freezed == readStatus
          ? _self.readStatus
          : readStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _self.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as DocHomework?,
    ));
  }

  /// Create a copy of HomeworkViewByParent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocHomeworkCopyWith<$Res>? get attachment {
    if (_self.attachment == null) {
      return null;
    }

    return $DocHomeworkCopyWith<$Res>(_self.attachment!, (value) {
      return _then(_self.copyWith(attachment: value));
    });
  }
}

/// Adds pattern-matching-related methods to [HomeworkViewByParent].
extension HomeworkViewByParentPatterns on HomeworkViewByParent {
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
    TResult Function(_HomeworkViewByParent value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkViewByParent() when $default != null:
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
    TResult Function(_HomeworkViewByParent value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkViewByParent():
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
    TResult? Function(_HomeworkViewByParent value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkViewByParent() when $default != null:
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
            @JsonKey(name: "roll_no") String? rollNo,
            @JsonKey(name: "first_name") String? firstName,
            @JsonKey(name: "mid_name") String? midName,
            @JsonKey(name: "last_name") String? lastName,
            @JsonKey(name: "read_status") String? readStatus,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "attachment") DocHomework? attachment)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkViewByParent() when $default != null:
        return $default(
            _that.rollNo,
            _that.firstName,
            _that.midName,
            _that.lastName,
            _that.readStatus,
            _that.studentId,
            _that.attachment);
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
            @JsonKey(name: "roll_no") String? rollNo,
            @JsonKey(name: "first_name") String? firstName,
            @JsonKey(name: "mid_name") String? midName,
            @JsonKey(name: "last_name") String? lastName,
            @JsonKey(name: "read_status") String? readStatus,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "attachment") DocHomework? attachment)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkViewByParent():
        return $default(
            _that.rollNo,
            _that.firstName,
            _that.midName,
            _that.lastName,
            _that.readStatus,
            _that.studentId,
            _that.attachment);
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
            @JsonKey(name: "roll_no") String? rollNo,
            @JsonKey(name: "first_name") String? firstName,
            @JsonKey(name: "mid_name") String? midName,
            @JsonKey(name: "last_name") String? lastName,
            @JsonKey(name: "read_status") String? readStatus,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "attachment") DocHomework? attachment)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkViewByParent() when $default != null:
        return $default(
            _that.rollNo,
            _that.firstName,
            _that.midName,
            _that.lastName,
            _that.readStatus,
            _that.studentId,
            _that.attachment);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeworkViewByParent implements HomeworkViewByParent {
  const _HomeworkViewByParent(
      {@JsonKey(name: "roll_no") this.rollNo,
      @JsonKey(name: "first_name") this.firstName,
      @JsonKey(name: "mid_name") this.midName,
      @JsonKey(name: "last_name") this.lastName,
      @JsonKey(name: "read_status") this.readStatus,
      @JsonKey(name: "student_id") this.studentId,
      @JsonKey(name: "attachment") this.attachment});
  factory _HomeworkViewByParent.fromJson(Map<String, dynamic> json) =>
      _$HomeworkViewByParentFromJson(json);

  @override
  @JsonKey(name: "roll_no")
  final String? rollNo;
  @override
  @JsonKey(name: "first_name")
  final String? firstName;
  @override
  @JsonKey(name: "mid_name")
  final String? midName;
  @override
  @JsonKey(name: "last_name")
  final String? lastName;
  @override
  @JsonKey(name: "read_status")
  final String? readStatus;
  @override
  @JsonKey(name: "student_id")
  final String? studentId;
  @override
  @JsonKey(name: "attachment")
  final DocHomework? attachment;

  /// Create a copy of HomeworkViewByParent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeworkViewByParentCopyWith<_HomeworkViewByParent> get copyWith =>
      __$HomeworkViewByParentCopyWithImpl<_HomeworkViewByParent>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeworkViewByParentToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeworkViewByParent &&
            (identical(other.rollNo, rollNo) || other.rollNo == rollNo) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.midName, midName) || other.midName == midName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.readStatus, readStatus) ||
                other.readStatus == readStatus) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.attachment, attachment) ||
                other.attachment == attachment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rollNo, firstName, midName,
      lastName, readStatus, studentId, attachment);

  @override
  String toString() {
    return 'HomeworkViewByParent(rollNo: $rollNo, firstName: $firstName, midName: $midName, lastName: $lastName, readStatus: $readStatus, studentId: $studentId, attachment: $attachment)';
  }
}

/// @nodoc
abstract mixin class _$HomeworkViewByParentCopyWith<$Res>
    implements $HomeworkViewByParentCopyWith<$Res> {
  factory _$HomeworkViewByParentCopyWith(_HomeworkViewByParent value,
          $Res Function(_HomeworkViewByParent) _then) =
      __$HomeworkViewByParentCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "roll_no") String? rollNo,
      @JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "mid_name") String? midName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "read_status") String? readStatus,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "attachment") DocHomework? attachment});

  @override
  $DocHomeworkCopyWith<$Res>? get attachment;
}

/// @nodoc
class __$HomeworkViewByParentCopyWithImpl<$Res>
    implements _$HomeworkViewByParentCopyWith<$Res> {
  __$HomeworkViewByParentCopyWithImpl(this._self, this._then);

  final _HomeworkViewByParent _self;
  final $Res Function(_HomeworkViewByParent) _then;

  /// Create a copy of HomeworkViewByParent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? rollNo = freezed,
    Object? firstName = freezed,
    Object? midName = freezed,
    Object? lastName = freezed,
    Object? readStatus = freezed,
    Object? studentId = freezed,
    Object? attachment = freezed,
  }) {
    return _then(_HomeworkViewByParent(
      rollNo: freezed == rollNo
          ? _self.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      midName: freezed == midName
          ? _self.midName
          : midName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      readStatus: freezed == readStatus
          ? _self.readStatus
          : readStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      attachment: freezed == attachment
          ? _self.attachment
          : attachment // ignore: cast_nullable_to_non_nullable
              as DocHomework?,
    ));
  }

  /// Create a copy of HomeworkViewByParent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocHomeworkCopyWith<$Res>? get attachment {
    if (_self.attachment == null) {
      return null;
    }

    return $DocHomeworkCopyWith<$Res>(_self.attachment!, (value) {
      return _then(_self.copyWith(attachment: value));
    });
  }
}

// dart format on
