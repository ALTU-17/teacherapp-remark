// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_student_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
HomeworkStudentStatus _$HomeworkStudentStatusFromJson(
    Map<String, dynamic> json) {
  return _HomeworkStudenStatus.fromJson(json);
}

/// @nodoc
mixin _$HomeworkStudentStatus {
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "section_id")
  String? get sectionId;
  @JsonKey(name: "sm_id")
  String? get smId;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "end_date")
  DateTime? get endDate;
  @JsonKey(name: "start_date")
  DateTime? get startDate;
  @JsonKey(name: "publish_date")
  DateTime? get publishDate;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "publish")
  String? get publish;
  @JsonKey(name: "comment_id")
  String? get commentId;
  @JsonKey(name: "student_id")
  String? get studentId;
  @JsonKey(name: "parent_id")
  String? get parentId;
  @JsonKey(name: "homework_status")
  String? get homeworkStatus;
  @JsonKey(name: "comment")
  String? get comment;
  @JsonKey(name: "parent_comment")
  String? get parentComment;
  @JsonKey(name: "first_name")
  String? get firstName;
  @JsonKey(name: "last_name")
  String? get lastName;
  @JsonKey(name: "roll_no")
  String? get rollNo;

  /// Create a copy of HomeworkStudentStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeworkStudentStatusCopyWith<HomeworkStudentStatus> get copyWith =>
      _$HomeworkStudentStatusCopyWithImpl<HomeworkStudentStatus>(
          this as HomeworkStudentStatus, _$identity);

  /// Serializes this HomeworkStudentStatus to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeworkStudentStatus &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.publishDate, publishDate) ||
                other.publishDate == publishDate) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.homeworkStatus, homeworkStatus) ||
                other.homeworkStatus == homeworkStatus) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.parentComment, parentComment) ||
                other.parentComment == parentComment) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.rollNo, rollNo) || other.rollNo == rollNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        homeworkId,
        description,
        teacherId,
        sectionId,
        smId,
        classId,
        endDate,
        startDate,
        publishDate,
        academicYr,
        publish,
        commentId,
        studentId,
        parentId,
        homeworkStatus,
        comment,
        parentComment,
        firstName,
        lastName,
        rollNo
      ]);

  @override
  String toString() {
    return 'HomeworkStudentStatus(homeworkId: $homeworkId, description: $description, teacherId: $teacherId, sectionId: $sectionId, smId: $smId, classId: $classId, endDate: $endDate, startDate: $startDate, publishDate: $publishDate, academicYr: $academicYr, publish: $publish, commentId: $commentId, studentId: $studentId, parentId: $parentId, homeworkStatus: $homeworkStatus, comment: $comment, parentComment: $parentComment, firstName: $firstName, lastName: $lastName, rollNo: $rollNo)';
  }
}

/// @nodoc
abstract mixin class $HomeworkStudentStatusCopyWith<$Res> {
  factory $HomeworkStudentStatusCopyWith(HomeworkStudentStatus value,
          $Res Function(HomeworkStudentStatus) _then) =
      _$HomeworkStudentStatusCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "end_date") DateTime? endDate,
      @JsonKey(name: "start_date") DateTime? startDate,
      @JsonKey(name: "publish_date") DateTime? publishDate,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "comment_id") String? commentId,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "parent_id") String? parentId,
      @JsonKey(name: "homework_status") String? homeworkStatus,
      @JsonKey(name: "comment") String? comment,
      @JsonKey(name: "parent_comment") String? parentComment,
      @JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "roll_no") String? rollNo});
}

/// @nodoc
class _$HomeworkStudentStatusCopyWithImpl<$Res>
    implements $HomeworkStudentStatusCopyWith<$Res> {
  _$HomeworkStudentStatusCopyWithImpl(this._self, this._then);

  final HomeworkStudentStatus _self;
  final $Res Function(HomeworkStudentStatus) _then;

  /// Create a copy of HomeworkStudentStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeworkId = freezed,
    Object? description = freezed,
    Object? teacherId = freezed,
    Object? sectionId = freezed,
    Object? smId = freezed,
    Object? classId = freezed,
    Object? endDate = freezed,
    Object? startDate = freezed,
    Object? publishDate = freezed,
    Object? academicYr = freezed,
    Object? publish = freezed,
    Object? commentId = freezed,
    Object? studentId = freezed,
    Object? parentId = freezed,
    Object? homeworkStatus = freezed,
    Object? comment = freezed,
    Object? parentComment = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? rollNo = freezed,
  }) {
    return _then(_self.copyWith(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      publishDate: freezed == publishDate
          ? _self.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      commentId: freezed == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkStatus: freezed == homeworkStatus
          ? _self.homeworkStatus
          : homeworkStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      parentComment: freezed == parentComment
          ? _self.parentComment
          : parentComment // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      rollNo: freezed == rollNo
          ? _self.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeworkStudentStatus].
extension HomeworkStudentStatusPatterns on HomeworkStudentStatus {
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
    TResult Function(_HomeworkStudenStatus value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkStudenStatus() when $default != null:
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
    TResult Function(_HomeworkStudenStatus value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStudenStatus():
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
    TResult? Function(_HomeworkStudenStatus value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStudenStatus() when $default != null:
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
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "end_date") DateTime? endDate,
            @JsonKey(name: "start_date") DateTime? startDate,
            @JsonKey(name: "publish_date") DateTime? publishDate,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "comment_id") String? commentId,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "parent_id") String? parentId,
            @JsonKey(name: "homework_status") String? homeworkStatus,
            @JsonKey(name: "comment") String? comment,
            @JsonKey(name: "parent_comment") String? parentComment,
            @JsonKey(name: "first_name") String? firstName,
            @JsonKey(name: "last_name") String? lastName,
            @JsonKey(name: "roll_no") String? rollNo)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkStudenStatus() when $default != null:
        return $default(
            _that.homeworkId,
            _that.description,
            _that.teacherId,
            _that.sectionId,
            _that.smId,
            _that.classId,
            _that.endDate,
            _that.startDate,
            _that.publishDate,
            _that.academicYr,
            _that.publish,
            _that.commentId,
            _that.studentId,
            _that.parentId,
            _that.homeworkStatus,
            _that.comment,
            _that.parentComment,
            _that.firstName,
            _that.lastName,
            _that.rollNo);
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
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "end_date") DateTime? endDate,
            @JsonKey(name: "start_date") DateTime? startDate,
            @JsonKey(name: "publish_date") DateTime? publishDate,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "comment_id") String? commentId,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "parent_id") String? parentId,
            @JsonKey(name: "homework_status") String? homeworkStatus,
            @JsonKey(name: "comment") String? comment,
            @JsonKey(name: "parent_comment") String? parentComment,
            @JsonKey(name: "first_name") String? firstName,
            @JsonKey(name: "last_name") String? lastName,
            @JsonKey(name: "roll_no") String? rollNo)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStudenStatus():
        return $default(
            _that.homeworkId,
            _that.description,
            _that.teacherId,
            _that.sectionId,
            _that.smId,
            _that.classId,
            _that.endDate,
            _that.startDate,
            _that.publishDate,
            _that.academicYr,
            _that.publish,
            _that.commentId,
            _that.studentId,
            _that.parentId,
            _that.homeworkStatus,
            _that.comment,
            _that.parentComment,
            _that.firstName,
            _that.lastName,
            _that.rollNo);
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
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "end_date") DateTime? endDate,
            @JsonKey(name: "start_date") DateTime? startDate,
            @JsonKey(name: "publish_date") DateTime? publishDate,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "comment_id") String? commentId,
            @JsonKey(name: "student_id") String? studentId,
            @JsonKey(name: "parent_id") String? parentId,
            @JsonKey(name: "homework_status") String? homeworkStatus,
            @JsonKey(name: "comment") String? comment,
            @JsonKey(name: "parent_comment") String? parentComment,
            @JsonKey(name: "first_name") String? firstName,
            @JsonKey(name: "last_name") String? lastName,
            @JsonKey(name: "roll_no") String? rollNo)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkStudenStatus() when $default != null:
        return $default(
            _that.homeworkId,
            _that.description,
            _that.teacherId,
            _that.sectionId,
            _that.smId,
            _that.classId,
            _that.endDate,
            _that.startDate,
            _that.publishDate,
            _that.academicYr,
            _that.publish,
            _that.commentId,
            _that.studentId,
            _that.parentId,
            _that.homeworkStatus,
            _that.comment,
            _that.parentComment,
            _that.firstName,
            _that.lastName,
            _that.rollNo);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeworkStudenStatus implements HomeworkStudentStatus {
  const _HomeworkStudenStatus(
      {@JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "section_id") this.sectionId,
      @JsonKey(name: "sm_id") this.smId,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "end_date") this.endDate,
      @JsonKey(name: "start_date") this.startDate,
      @JsonKey(name: "publish_date") this.publishDate,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "publish") this.publish,
      @JsonKey(name: "comment_id") this.commentId,
      @JsonKey(name: "student_id") this.studentId,
      @JsonKey(name: "parent_id") this.parentId,
      @JsonKey(name: "homework_status") this.homeworkStatus,
      @JsonKey(name: "comment") this.comment,
      @JsonKey(name: "parent_comment") this.parentComment,
      @JsonKey(name: "first_name") this.firstName,
      @JsonKey(name: "last_name") this.lastName,
      @JsonKey(name: "roll_no") this.rollNo});
  factory _HomeworkStudenStatus.fromJson(Map<String, dynamic> json) =>
      _$HomeworkStudenStatusFromJson(json);

  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "teacher_id")
  final String? teacherId;
  @override
  @JsonKey(name: "section_id")
  final String? sectionId;
  @override
  @JsonKey(name: "sm_id")
  final String? smId;
  @override
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "end_date")
  final DateTime? endDate;
  @override
  @JsonKey(name: "start_date")
  final DateTime? startDate;
  @override
  @JsonKey(name: "publish_date")
  final DateTime? publishDate;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "publish")
  final String? publish;
  @override
  @JsonKey(name: "comment_id")
  final String? commentId;
  @override
  @JsonKey(name: "student_id")
  final String? studentId;
  @override
  @JsonKey(name: "parent_id")
  final String? parentId;
  @override
  @JsonKey(name: "homework_status")
  final String? homeworkStatus;
  @override
  @JsonKey(name: "comment")
  final String? comment;
  @override
  @JsonKey(name: "parent_comment")
  final String? parentComment;
  @override
  @JsonKey(name: "first_name")
  final String? firstName;
  @override
  @JsonKey(name: "last_name")
  final String? lastName;
  @override
  @JsonKey(name: "roll_no")
  final String? rollNo;

  /// Create a copy of HomeworkStudentStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeworkStudenStatusCopyWith<_HomeworkStudenStatus> get copyWith =>
      __$HomeworkStudenStatusCopyWithImpl<_HomeworkStudenStatus>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeworkStudenStatusToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeworkStudenStatus &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.publishDate, publishDate) ||
                other.publishDate == publishDate) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.homeworkStatus, homeworkStatus) ||
                other.homeworkStatus == homeworkStatus) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.parentComment, parentComment) ||
                other.parentComment == parentComment) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.rollNo, rollNo) || other.rollNo == rollNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        homeworkId,
        description,
        teacherId,
        sectionId,
        smId,
        classId,
        endDate,
        startDate,
        publishDate,
        academicYr,
        publish,
        commentId,
        studentId,
        parentId,
        homeworkStatus,
        comment,
        parentComment,
        firstName,
        lastName,
        rollNo
      ]);

  @override
  String toString() {
    return 'HomeworkStudentStatus(homeworkId: $homeworkId, description: $description, teacherId: $teacherId, sectionId: $sectionId, smId: $smId, classId: $classId, endDate: $endDate, startDate: $startDate, publishDate: $publishDate, academicYr: $academicYr, publish: $publish, commentId: $commentId, studentId: $studentId, parentId: $parentId, homeworkStatus: $homeworkStatus, comment: $comment, parentComment: $parentComment, firstName: $firstName, lastName: $lastName, rollNo: $rollNo)';
  }
}

/// @nodoc
abstract mixin class _$HomeworkStudenStatusCopyWith<$Res>
    implements $HomeworkStudentStatusCopyWith<$Res> {
  factory _$HomeworkStudenStatusCopyWith(_HomeworkStudenStatus value,
          $Res Function(_HomeworkStudenStatus) _then) =
      __$HomeworkStudenStatusCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "end_date") DateTime? endDate,
      @JsonKey(name: "start_date") DateTime? startDate,
      @JsonKey(name: "publish_date") DateTime? publishDate,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "comment_id") String? commentId,
      @JsonKey(name: "student_id") String? studentId,
      @JsonKey(name: "parent_id") String? parentId,
      @JsonKey(name: "homework_status") String? homeworkStatus,
      @JsonKey(name: "comment") String? comment,
      @JsonKey(name: "parent_comment") String? parentComment,
      @JsonKey(name: "first_name") String? firstName,
      @JsonKey(name: "last_name") String? lastName,
      @JsonKey(name: "roll_no") String? rollNo});
}

/// @nodoc
class __$HomeworkStudenStatusCopyWithImpl<$Res>
    implements _$HomeworkStudenStatusCopyWith<$Res> {
  __$HomeworkStudenStatusCopyWithImpl(this._self, this._then);

  final _HomeworkStudenStatus _self;
  final $Res Function(_HomeworkStudenStatus) _then;

  /// Create a copy of HomeworkStudentStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeworkId = freezed,
    Object? description = freezed,
    Object? teacherId = freezed,
    Object? sectionId = freezed,
    Object? smId = freezed,
    Object? classId = freezed,
    Object? endDate = freezed,
    Object? startDate = freezed,
    Object? publishDate = freezed,
    Object? academicYr = freezed,
    Object? publish = freezed,
    Object? commentId = freezed,
    Object? studentId = freezed,
    Object? parentId = freezed,
    Object? homeworkStatus = freezed,
    Object? comment = freezed,
    Object? parentComment = freezed,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? rollNo = freezed,
  }) {
    return _then(_HomeworkStudenStatus(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      publishDate: freezed == publishDate
          ? _self.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      commentId: freezed == commentId
          ? _self.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _self.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _self.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkStatus: freezed == homeworkStatus
          ? _self.homeworkStatus
          : homeworkStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _self.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      parentComment: freezed == parentComment
          ? _self.parentComment
          : parentComment // ignore: cast_nullable_to_non_nullable
              as String?,
      firstName: freezed == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      rollNo: freezed == rollNo
          ? _self.rollNo
          : rollNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
