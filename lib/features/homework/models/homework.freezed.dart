// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Homework {
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
  String? get endDate;
  @JsonKey(name: "start_date")
  String? get startDate;
  @JsonKey(name: "publish_date")
  String? get publishDate;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "publish")
  String? get publish;
  @JsonKey(name: "comment_count")
  String? get commentCount;
  @JsonKey(name: "cls_name")
  String? get clsName;
  @JsonKey(name: "sec_name")
  String? get secName;
  @JsonKey(name: "sub_name")
  String? get subName;

  /// Create a copy of Homework
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeworkCopyWith<Homework> get copyWith =>
      _$HomeworkCopyWithImpl<Homework>(this as Homework, _$identity);

  /// Serializes this Homework to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Homework &&
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
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.clsName, clsName) || other.clsName == clsName) &&
            (identical(other.secName, secName) || other.secName == secName) &&
            (identical(other.subName, subName) || other.subName == subName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
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
      commentCount,
      clsName,
      secName,
      subName);

  @override
  String toString() {
    return 'Homework(homeworkId: $homeworkId, description: $description, teacherId: $teacherId, sectionId: $sectionId, smId: $smId, classId: $classId, endDate: $endDate, startDate: $startDate, publishDate: $publishDate, academicYr: $academicYr, publish: $publish, commentCount: $commentCount, clsName: $clsName, secName: $secName, subName: $subName)';
  }
}

/// @nodoc
abstract mixin class $HomeworkCopyWith<$Res> {
  factory $HomeworkCopyWith(Homework value, $Res Function(Homework) _then) =
      _$HomeworkCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "end_date") String? endDate,
      @JsonKey(name: "start_date") String? startDate,
      @JsonKey(name: "publish_date") String? publishDate,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "comment_count") String? commentCount,
      @JsonKey(name: "cls_name") String? clsName,
      @JsonKey(name: "sec_name") String? secName,
      @JsonKey(name: "sub_name") String? subName});
}

/// @nodoc
class _$HomeworkCopyWithImpl<$Res> implements $HomeworkCopyWith<$Res> {
  _$HomeworkCopyWithImpl(this._self, this._then);

  final Homework _self;
  final $Res Function(Homework) _then;

  /// Create a copy of Homework
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
    Object? commentCount = freezed,
    Object? clsName = freezed,
    Object? secName = freezed,
    Object? subName = freezed,
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
              as String?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      publishDate: freezed == publishDate
          ? _self.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      commentCount: freezed == commentCount
          ? _self.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as String?,
      clsName: freezed == clsName
          ? _self.clsName
          : clsName // ignore: cast_nullable_to_non_nullable
              as String?,
      secName: freezed == secName
          ? _self.secName
          : secName // ignore: cast_nullable_to_non_nullable
              as String?,
      subName: freezed == subName
          ? _self.subName
          : subName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Homework].
extension HomeworkPatterns on Homework {
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
    TResult Function(_Homework value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Homework() when $default != null:
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
    TResult Function(_Homework value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Homework():
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
    TResult? Function(_Homework value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Homework() when $default != null:
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
            @JsonKey(name: "end_date") String? endDate,
            @JsonKey(name: "start_date") String? startDate,
            @JsonKey(name: "publish_date") String? publishDate,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "comment_count") String? commentCount,
            @JsonKey(name: "cls_name") String? clsName,
            @JsonKey(name: "sec_name") String? secName,
            @JsonKey(name: "sub_name") String? subName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Homework() when $default != null:
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
            _that.commentCount,
            _that.clsName,
            _that.secName,
            _that.subName);
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
            @JsonKey(name: "end_date") String? endDate,
            @JsonKey(name: "start_date") String? startDate,
            @JsonKey(name: "publish_date") String? publishDate,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "comment_count") String? commentCount,
            @JsonKey(name: "cls_name") String? clsName,
            @JsonKey(name: "sec_name") String? secName,
            @JsonKey(name: "sub_name") String? subName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Homework():
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
            _that.commentCount,
            _that.clsName,
            _that.secName,
            _that.subName);
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
            @JsonKey(name: "end_date") String? endDate,
            @JsonKey(name: "start_date") String? startDate,
            @JsonKey(name: "publish_date") String? publishDate,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "comment_count") String? commentCount,
            @JsonKey(name: "cls_name") String? clsName,
            @JsonKey(name: "sec_name") String? secName,
            @JsonKey(name: "sub_name") String? subName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Homework() when $default != null:
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
            _that.commentCount,
            _that.clsName,
            _that.secName,
            _that.subName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Homework implements Homework {
  const _Homework(
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
      @JsonKey(name: "comment_count") this.commentCount,
      @JsonKey(name: "cls_name") this.clsName,
      @JsonKey(name: "sec_name") this.secName,
      @JsonKey(name: "sub_name") this.subName});
  factory _Homework.fromJson(Map<String, dynamic> json) =>
      _$HomeworkFromJson(json);

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
  final String? endDate;
  @override
  @JsonKey(name: "start_date")
  final String? startDate;
  @override
  @JsonKey(name: "publish_date")
  final String? publishDate;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "publish")
  final String? publish;
  @override
  @JsonKey(name: "comment_count")
  final String? commentCount;
  @override
  @JsonKey(name: "cls_name")
  final String? clsName;
  @override
  @JsonKey(name: "sec_name")
  final String? secName;
  @override
  @JsonKey(name: "sub_name")
  final String? subName;

  /// Create a copy of Homework
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeworkCopyWith<_Homework> get copyWith =>
      __$HomeworkCopyWithImpl<_Homework>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeworkToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Homework &&
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
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.clsName, clsName) || other.clsName == clsName) &&
            (identical(other.secName, secName) || other.secName == secName) &&
            (identical(other.subName, subName) || other.subName == subName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
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
      commentCount,
      clsName,
      secName,
      subName);

  @override
  String toString() {
    return 'Homework(homeworkId: $homeworkId, description: $description, teacherId: $teacherId, sectionId: $sectionId, smId: $smId, classId: $classId, endDate: $endDate, startDate: $startDate, publishDate: $publishDate, academicYr: $academicYr, publish: $publish, commentCount: $commentCount, clsName: $clsName, secName: $secName, subName: $subName)';
  }
}

/// @nodoc
abstract mixin class _$HomeworkCopyWith<$Res>
    implements $HomeworkCopyWith<$Res> {
  factory _$HomeworkCopyWith(_Homework value, $Res Function(_Homework) _then) =
      __$HomeworkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "end_date") String? endDate,
      @JsonKey(name: "start_date") String? startDate,
      @JsonKey(name: "publish_date") String? publishDate,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "comment_count") String? commentCount,
      @JsonKey(name: "cls_name") String? clsName,
      @JsonKey(name: "sec_name") String? secName,
      @JsonKey(name: "sub_name") String? subName});
}

/// @nodoc
class __$HomeworkCopyWithImpl<$Res> implements _$HomeworkCopyWith<$Res> {
  __$HomeworkCopyWithImpl(this._self, this._then);

  final _Homework _self;
  final $Res Function(_Homework) _then;

  /// Create a copy of Homework
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
    Object? commentCount = freezed,
    Object? clsName = freezed,
    Object? secName = freezed,
    Object? subName = freezed,
  }) {
    return _then(_Homework(
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
              as String?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      publishDate: freezed == publishDate
          ? _self.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      commentCount: freezed == commentCount
          ? _self.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as String?,
      clsName: freezed == clsName
          ? _self.clsName
          : clsName // ignore: cast_nullable_to_non_nullable
              as String?,
      secName: freezed == secName
          ? _self.secName
          : secName // ignore: cast_nullable_to_non_nullable
              as String?,
      subName: freezed == subName
          ? _self.subName
          : subName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
