// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'att.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Att {
  @JsonKey(name: "attendance_status")
  String? get attendanceStatus;
  @JsonKey(name: "mark_attendance")
  String? get markAttendance;
  @JsonKey(name: "fName")
  String? get fName;
  @JsonKey(name: "lName")
  String? get lName;
  @JsonKey(name: "rollno")
  String? get rollNo;
  @JsonKey(name: "student_id")
  String? get studentId;
  @JsonKey(name: "classid")
  String? get classId;
  @JsonKey(name: "sectionid")
  String? get sectionId;
  @JsonKey(name: "date")
  String? get date;
  @JsonKey(name: "only_date")
  String? get onlyDate;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "academic_yr")
  String? get academicYr;

  /// Create a copy of Att
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttCopyWith<Att> get copyWith =>
      _$AttCopyWithImpl<Att>(this as Att, _$identity);

  /// Serializes this Att to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Att &&
            (identical(other.attendanceStatus, attendanceStatus) ||
                other.attendanceStatus == attendanceStatus) &&
            (identical(other.markAttendance, markAttendance) ||
                other.markAttendance == markAttendance) &&
            (identical(other.fName, fName) || other.fName == fName) &&
            (identical(other.lName, lName) || other.lName == lName) &&
            (identical(other.rollNo, rollNo) || other.rollNo == rollNo) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.onlyDate, onlyDate) ||
                other.onlyDate == onlyDate) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      attendanceStatus,
      markAttendance,
      fName,
      lName,
      rollNo,
      studentId,
      classId,
      sectionId,
      date,
      onlyDate,
      teacherId,
      academicYr);

  @override
  String toString() {
    return 'Att(attendanceStatus: $attendanceStatus, markAttendance: $markAttendance, fName: $fName, lName: $lName, rollNo: $rollNo, studentId: $studentId, classId: $classId, sectionId: $sectionId, date: $date, onlyDate: $onlyDate, teacherId: $teacherId, academicYr: $academicYr)';
  }
}

/// @nodoc
abstract mixin class $AttCopyWith<$Res> {
  factory $AttCopyWith(Att value, $Res Function(Att) _then) = _$AttCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "attendance_status") String? attendanceStatus,
      @JsonKey(name: "mark_attendance") String? markAttendance,
      @JsonKey(name: "fName") String? fName,
      @JsonKey(name: "lName") String? lName,
      @JsonKey(name: "rollno") String? rollNo,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "classid") String? classId,
      @JsonKey(name: "sectionid") String? sectionId,
      @JsonKey(name: "date") String? date,
      @JsonKey(name: "only_date") String? onlyDate,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "academic_yr") String? academicYr});
}

/// @nodoc
class _$AttCopyWithImpl<$Res> implements $AttCopyWith<$Res> {
  _$AttCopyWithImpl(this._self, this._then);

  final Att _self;
  final $Res Function(Att) _then;

  /// Create a copy of Att
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attendanceStatus = freezed,
    Object? markAttendance = freezed,
    Object? fName = freezed,
    Object? lName = freezed,
    Object? rollNo = freezed,
    Object? studentId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? date = freezed,
    Object? onlyDate = freezed,
    Object? teacherId = freezed,
    Object? academicYr = freezed,
  }) {
    return _then(_self.copyWith(
      attendanceStatus: freezed == attendanceStatus
          ? _self.attendanceStatus
          : attendanceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      markAttendance: freezed == markAttendance
          ? _self.markAttendance
          : markAttendance // ignore: cast_nullable_to_non_nullable
              as String?,
      fName: freezed == fName
          ? _self.fName
          : fName // ignore: cast_nullable_to_non_nullable
              as String?,
      lName: freezed == lName
          ? _self.lName
          : lName // ignore: cast_nullable_to_non_nullable
              as String?,
      rollNo: freezed == rollNo
          ? _self.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      onlyDate: freezed == onlyDate
          ? _self.onlyDate
          : onlyDate // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Att].
extension AttPatterns on Att {
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
    TResult Function(_Att value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Att() when $default != null:
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
    TResult Function(_Att value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Att():
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
    TResult? Function(_Att value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Att() when $default != null:
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
            @JsonKey(name: "attendance_status") String? attendanceStatus,
            @JsonKey(name: "mark_attendance") String? markAttendance,
            @JsonKey(name: "fName") String? fName,
            @JsonKey(name: "lName") String? lName,
            @JsonKey(name: "rollno") String? rollNo,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "classid") String? classId,
            @JsonKey(name: "sectionid") String? sectionId,
            @JsonKey(name: "date") String? date,
            @JsonKey(name: "only_date") String? onlyDate,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "academic_yr") String? academicYr)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Att() when $default != null:
        return $default(
            _that.attendanceStatus,
            _that.markAttendance,
            _that.fName,
            _that.lName,
            _that.rollNo,
            _that.studentId,
            _that.classId,
            _that.sectionId,
            _that.date,
            _that.onlyDate,
            _that.teacherId,
            _that.academicYr);
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
            @JsonKey(name: "attendance_status") String? attendanceStatus,
            @JsonKey(name: "mark_attendance") String? markAttendance,
            @JsonKey(name: "fName") String? fName,
            @JsonKey(name: "lName") String? lName,
            @JsonKey(name: "rollno") String? rollNo,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "classid") String? classId,
            @JsonKey(name: "sectionid") String? sectionId,
            @JsonKey(name: "date") String? date,
            @JsonKey(name: "only_date") String? onlyDate,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "academic_yr") String? academicYr)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Att():
        return $default(
            _that.attendanceStatus,
            _that.markAttendance,
            _that.fName,
            _that.lName,
            _that.rollNo,
            _that.studentId,
            _that.classId,
            _that.sectionId,
            _that.date,
            _that.onlyDate,
            _that.teacherId,
            _that.academicYr);
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
            @JsonKey(name: "attendance_status") String? attendanceStatus,
            @JsonKey(name: "mark_attendance") String? markAttendance,
            @JsonKey(name: "fName") String? fName,
            @JsonKey(name: "lName") String? lName,
            @JsonKey(name: "rollno") String? rollNo,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "classid") String? classId,
            @JsonKey(name: "sectionid") String? sectionId,
            @JsonKey(name: "date") String? date,
            @JsonKey(name: "only_date") String? onlyDate,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "academic_yr") String? academicYr)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Att() when $default != null:
        return $default(
            _that.attendanceStatus,
            _that.markAttendance,
            _that.fName,
            _that.lName,
            _that.rollNo,
            _that.studentId,
            _that.classId,
            _that.sectionId,
            _that.date,
            _that.onlyDate,
            _that.teacherId,
            _that.academicYr);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Att implements Att {
  const _Att(
      {@JsonKey(name: "attendance_status") this.attendanceStatus,
      @JsonKey(name: "mark_attendance") this.markAttendance,
      @JsonKey(name: "fName") this.fName,
      @JsonKey(name: "lName") this.lName,
      @JsonKey(name: "rollno") this.rollNo,
      @JsonKey(name: "student_id") this.studentId,
      @JsonKey(name: "classid") this.classId,
      @JsonKey(name: "sectionid") this.sectionId,
      @JsonKey(name: "date") this.date,
      @JsonKey(name: "only_date") this.onlyDate,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "academic_yr") this.academicYr});
  factory _Att.fromJson(Map<String, dynamic> json) => _$AttFromJson(json);

  @override
  @JsonKey(name: "attendance_status")
  final String? attendanceStatus;
  @override
  @JsonKey(name: "mark_attendance")
  final String? markAttendance;
  @override
  @JsonKey(name: "fName")
  final String? fName;
  @override
  @JsonKey(name: "lName")
  final String? lName;
  @override
  @JsonKey(name: "rollno")
  final String? rollNo;
  @override
  @JsonKey(name: "student_id")
  final String? studentId;
  @override
  @JsonKey(name: "classid")
  final String? classId;
  @override
  @JsonKey(name: "sectionid")
  final String? sectionId;
  @override
  @JsonKey(name: "date")
  final String? date;
  @override
  @JsonKey(name: "only_date")
  final String? onlyDate;
  @override
  @JsonKey(name: "teacher_id")
  final String? teacherId;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;

  /// Create a copy of Att
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttCopyWith<_Att> get copyWith =>
      __$AttCopyWithImpl<_Att>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AttToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Att &&
            (identical(other.attendanceStatus, attendanceStatus) ||
                other.attendanceStatus == attendanceStatus) &&
            (identical(other.markAttendance, markAttendance) ||
                other.markAttendance == markAttendance) &&
            (identical(other.fName, fName) || other.fName == fName) &&
            (identical(other.lName, lName) || other.lName == lName) &&
            (identical(other.rollNo, rollNo) || other.rollNo == rollNo) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.onlyDate, onlyDate) ||
                other.onlyDate == onlyDate) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      attendanceStatus,
      markAttendance,
      fName,
      lName,
      rollNo,
      studentId,
      classId,
      sectionId,
      date,
      onlyDate,
      teacherId,
      academicYr);

  @override
  String toString() {
    return 'Att(attendanceStatus: $attendanceStatus, markAttendance: $markAttendance, fName: $fName, lName: $lName, rollNo: $rollNo, studentId: $studentId, classId: $classId, sectionId: $sectionId, date: $date, onlyDate: $onlyDate, teacherId: $teacherId, academicYr: $academicYr)';
  }
}

/// @nodoc
abstract mixin class _$AttCopyWith<$Res> implements $AttCopyWith<$Res> {
  factory _$AttCopyWith(_Att value, $Res Function(_Att) _then) =
      __$AttCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "attendance_status") String? attendanceStatus,
      @JsonKey(name: "mark_attendance") String? markAttendance,
      @JsonKey(name: "fName") String? fName,
      @JsonKey(name: "lName") String? lName,
      @JsonKey(name: "rollno") String? rollNo,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "classid") String? classId,
      @JsonKey(name: "sectionid") String? sectionId,
      @JsonKey(name: "date") String? date,
      @JsonKey(name: "only_date") String? onlyDate,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "academic_yr") String? academicYr});
}

/// @nodoc
class __$AttCopyWithImpl<$Res> implements _$AttCopyWith<$Res> {
  __$AttCopyWithImpl(this._self, this._then);

  final _Att _self;
  final $Res Function(_Att) _then;

  /// Create a copy of Att
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? attendanceStatus = freezed,
    Object? markAttendance = freezed,
    Object? fName = freezed,
    Object? lName = freezed,
    Object? rollNo = freezed,
    Object? studentId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? date = freezed,
    Object? onlyDate = freezed,
    Object? teacherId = freezed,
    Object? academicYr = freezed,
  }) {
    return _then(_Att(
      attendanceStatus: freezed == attendanceStatus
          ? _self.attendanceStatus
          : attendanceStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      markAttendance: freezed == markAttendance
          ? _self.markAttendance
          : markAttendance // ignore: cast_nullable_to_non_nullable
              as String?,
      fName: freezed == fName
          ? _self.fName
          : fName // ignore: cast_nullable_to_non_nullable
              as String?,
      lName: freezed == lName
          ? _self.lName
          : lName // ignore: cast_nullable_to_non_nullable
              as String?,
      rollNo: freezed == rollNo
          ? _self.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      onlyDate: freezed == onlyDate
          ? _self.onlyDate
          : onlyDate // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
