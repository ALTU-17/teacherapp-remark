// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Chapter {
  @JsonKey(name: "tec_name")
  String? get tecName;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "sub_name")
  String? get subName;
  @JsonKey(name: "class_name")
  String? get className;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "created_by")
  String? get createdBy;
  @JsonKey(name: "publish")
  String? get publish;
  @JsonKey(name: "isDelete")
  String? get isDelete;
  @JsonKey(name: "difficulty_level")
  String? get difficultyLevel;
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "sub_subject")
  String? get subSubject;
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "chapter_no")
  String? get chapterNo;
  @JsonKey(name: "subject_id")
  String? get subjectId;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "chapter_id")
  String? get chapterId; // UI fields (not from API)
  bool get isSelected;
  bool get isPublished;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChapterCopyWith<Chapter> get copyWith =>
      _$ChapterCopyWithImpl<Chapter>(this as Chapter, _$identity);

  /// Serializes this Chapter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Chapter &&
            (identical(other.tecName, tecName) || other.tecName == tecName) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.subName, subName) || other.subName == subName) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.subSubject, subSubject) ||
                other.subSubject == subSubject) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.chapterNo, chapterNo) ||
                other.chapterNo == chapterNo) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.chapterId, chapterId) ||
                other.chapterId == chapterId) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tecName,
      teacherId,
      subName,
      className,
      academicYr,
      createdBy,
      publish,
      isDelete,
      difficultyLevel,
      description,
      subSubject,
      name,
      chapterNo,
      subjectId,
      classId,
      chapterId,
      isSelected,
      isPublished);

  @override
  String toString() {
    return 'Chapter(tecName: $tecName, teacherId: $teacherId, subName: $subName, className: $className, academicYr: $academicYr, createdBy: $createdBy, publish: $publish, isDelete: $isDelete, difficultyLevel: $difficultyLevel, description: $description, subSubject: $subSubject, name: $name, chapterNo: $chapterNo, subjectId: $subjectId, classId: $classId, chapterId: $chapterId, isSelected: $isSelected, isPublished: $isPublished)';
  }
}

/// @nodoc
abstract mixin class $ChapterCopyWith<$Res> {
  factory $ChapterCopyWith(Chapter value, $Res Function(Chapter) _then) =
      _$ChapterCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "tec_name") String? tecName,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "sub_name") String? subName,
      @JsonKey(name: "class_name") String? className,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "created_by") String? createdBy,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "isDelete") String? isDelete,
      @JsonKey(name: "difficulty_level") String? difficultyLevel,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "sub_subject") String? subSubject,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "chapter_no") String? chapterNo,
      @JsonKey(name: "subject_id") String? subjectId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "chapter_id") String? chapterId,
      bool isSelected,
      bool isPublished});
}

/// @nodoc
class _$ChapterCopyWithImpl<$Res> implements $ChapterCopyWith<$Res> {
  _$ChapterCopyWithImpl(this._self, this._then);

  final Chapter _self;
  final $Res Function(Chapter) _then;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tecName = freezed,
    Object? teacherId = freezed,
    Object? subName = freezed,
    Object? className = freezed,
    Object? academicYr = freezed,
    Object? createdBy = freezed,
    Object? publish = freezed,
    Object? isDelete = freezed,
    Object? difficultyLevel = freezed,
    Object? description = freezed,
    Object? subSubject = freezed,
    Object? name = freezed,
    Object? chapterNo = freezed,
    Object? subjectId = freezed,
    Object? classId = freezed,
    Object? chapterId = freezed,
    Object? isSelected = null,
    Object? isPublished = null,
  }) {
    return _then(_self.copyWith(
      tecName: freezed == tecName
          ? _self.tecName
          : tecName // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      subName: freezed == subName
          ? _self.subName
          : subName // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _self.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: freezed == difficultyLevel
          ? _self.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      subSubject: freezed == subSubject
          ? _self.subSubject
          : subSubject // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterNo: freezed == chapterNo
          ? _self.chapterNo
          : chapterNo // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterId: freezed == chapterId
          ? _self.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Chapter implements Chapter {
  const _Chapter(
      {@JsonKey(name: "tec_name") this.tecName,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "sub_name") this.subName,
      @JsonKey(name: "class_name") this.className,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "created_by") this.createdBy,
      @JsonKey(name: "publish") this.publish,
      @JsonKey(name: "isDelete") this.isDelete,
      @JsonKey(name: "difficulty_level") this.difficultyLevel,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "sub_subject") this.subSubject,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "chapter_no") this.chapterNo,
      @JsonKey(name: "subject_id") this.subjectId,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "chapter_id") this.chapterId,
      this.isSelected = false,
      this.isPublished = false});
  factory _Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  @override
  @JsonKey(name: "tec_name")
  final String? tecName;
  @override
  @JsonKey(name: "teacher_id")
  final String? teacherId;
  @override
  @JsonKey(name: "sub_name")
  final String? subName;
  @override
  @JsonKey(name: "class_name")
  final String? className;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "created_by")
  final String? createdBy;
  @override
  @JsonKey(name: "publish")
  final String? publish;
  @override
  @JsonKey(name: "isDelete")
  final String? isDelete;
  @override
  @JsonKey(name: "difficulty_level")
  final String? difficultyLevel;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "sub_subject")
  final String? subSubject;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "chapter_no")
  final String? chapterNo;
  @override
  @JsonKey(name: "subject_id")
  final String? subjectId;
  @override
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "chapter_id")
  final String? chapterId;
// UI fields (not from API)
  @override
  @JsonKey()
  final bool isSelected;
  @override
  @JsonKey()
  final bool isPublished;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChapterCopyWith<_Chapter> get copyWith =>
      __$ChapterCopyWithImpl<_Chapter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChapterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Chapter &&
            (identical(other.tecName, tecName) || other.tecName == tecName) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.subName, subName) || other.subName == subName) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.difficultyLevel, difficultyLevel) ||
                other.difficultyLevel == difficultyLevel) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.subSubject, subSubject) ||
                other.subSubject == subSubject) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.chapterNo, chapterNo) ||
                other.chapterNo == chapterNo) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.chapterId, chapterId) ||
                other.chapterId == chapterId) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tecName,
      teacherId,
      subName,
      className,
      academicYr,
      createdBy,
      publish,
      isDelete,
      difficultyLevel,
      description,
      subSubject,
      name,
      chapterNo,
      subjectId,
      classId,
      chapterId,
      isSelected,
      isPublished);

  @override
  String toString() {
    return 'Chapter(tecName: $tecName, teacherId: $teacherId, subName: $subName, className: $className, academicYr: $academicYr, createdBy: $createdBy, publish: $publish, isDelete: $isDelete, difficultyLevel: $difficultyLevel, description: $description, subSubject: $subSubject, name: $name, chapterNo: $chapterNo, subjectId: $subjectId, classId: $classId, chapterId: $chapterId, isSelected: $isSelected, isPublished: $isPublished)';
  }
}

/// @nodoc
abstract mixin class _$ChapterCopyWith<$Res> implements $ChapterCopyWith<$Res> {
  factory _$ChapterCopyWith(_Chapter value, $Res Function(_Chapter) _then) =
      __$ChapterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "tec_name") String? tecName,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "sub_name") String? subName,
      @JsonKey(name: "class_name") String? className,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "created_by") String? createdBy,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "isDelete") String? isDelete,
      @JsonKey(name: "difficulty_level") String? difficultyLevel,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "sub_subject") String? subSubject,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "chapter_no") String? chapterNo,
      @JsonKey(name: "subject_id") String? subjectId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "chapter_id") String? chapterId,
      bool isSelected,
      bool isPublished});
}

/// @nodoc
class __$ChapterCopyWithImpl<$Res> implements _$ChapterCopyWith<$Res> {
  __$ChapterCopyWithImpl(this._self, this._then);

  final _Chapter _self;
  final $Res Function(_Chapter) _then;

  /// Create a copy of Chapter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tecName = freezed,
    Object? teacherId = freezed,
    Object? subName = freezed,
    Object? className = freezed,
    Object? academicYr = freezed,
    Object? createdBy = freezed,
    Object? publish = freezed,
    Object? isDelete = freezed,
    Object? difficultyLevel = freezed,
    Object? description = freezed,
    Object? subSubject = freezed,
    Object? name = freezed,
    Object? chapterNo = freezed,
    Object? subjectId = freezed,
    Object? classId = freezed,
    Object? chapterId = freezed,
    Object? isSelected = null,
    Object? isPublished = null,
  }) {
    return _then(_Chapter(
      tecName: freezed == tecName
          ? _self.tecName
          : tecName // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      subName: freezed == subName
          ? _self.subName
          : subName // ignore: cast_nullable_to_non_nullable
              as String?,
      className: freezed == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      createdBy: freezed == createdBy
          ? _self.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _self.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as String?,
      difficultyLevel: freezed == difficultyLevel
          ? _self.difficultyLevel
          : difficultyLevel // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      subSubject: freezed == subSubject
          ? _self.subSubject
          : subSubject // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterNo: freezed == chapterNo
          ? _self.chapterNo
          : chapterNo // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      chapterId: freezed == chapterId
          ? _self.chapterId
          : chapterId // ignore: cast_nullable_to_non_nullable
              as String?,
      isSelected: null == isSelected
          ? _self.isSelected
          : isSelected // ignore: cast_nullable_to_non_nullable
              as bool,
      isPublished: null == isPublished
          ? _self.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
