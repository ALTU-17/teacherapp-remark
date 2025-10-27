// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Subject {
  @JsonKey(name: "subject_id")
  String? get subjectId;
  @JsonKey(name: "sm_id")
  String? get smId;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "section_id")
  String? get sectionId;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "created_at")
  dynamic get createdAt;
  @JsonKey(name: "updated_at")
  dynamic get updatedAt;
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "subject_type")
  String? get subjectType;

  /// Create a copy of Subject
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubjectCopyWith<Subject> get copyWith =>
      _$SubjectCopyWithImpl<Subject>(this as Subject, _$identity);

  /// Serializes this Subject to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Subject &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subjectType, subjectType) ||
                other.subjectType == subjectType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      subjectId,
      smId,
      classId,
      sectionId,
      teacherId,
      academicYr,
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      name,
      subjectType);

  @override
  String toString() {
    return 'Subject(subjectId: $subjectId, smId: $smId, classId: $classId, sectionId: $sectionId, teacherId: $teacherId, academicYr: $academicYr, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, subjectType: $subjectType)';
  }
}

/// @nodoc
abstract mixin class $SubjectCopyWith<$Res> {
  factory $SubjectCopyWith(Subject value, $Res Function(Subject) _then) =
      _$SubjectCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "subject_id") String? subjectId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "created_at") dynamic createdAt,
      @JsonKey(name: "updated_at") dynamic updatedAt,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "subject_type") String? subjectType});
}

/// @nodoc
class _$SubjectCopyWithImpl<$Res> implements $SubjectCopyWith<$Res> {
  _$SubjectCopyWithImpl(this._self, this._then);

  final Subject _self;
  final $Res Function(Subject) _then;

  /// Create a copy of Subject
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? subjectId = freezed,
    Object? smId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? teacherId = freezed,
    Object? academicYr = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? name = freezed,
    Object? subjectType = freezed,
  }) {
    return _then(_self.copyWith(
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectType: freezed == subjectType
          ? _self.subjectType
          : subjectType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Subject].
extension SubjectPatterns on Subject {
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
    TResult Function(_Subject value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subject() when $default != null:
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
    TResult Function(_Subject value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subject():
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
    TResult? Function(_Subject value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subject() when $default != null:
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
            @JsonKey(name: "subject_id") String? subjectId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "created_at") dynamic createdAt,
            @JsonKey(name: "updated_at") dynamic updatedAt,
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "subject_type") String? subjectType)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Subject() when $default != null:
        return $default(
            _that.subjectId,
            _that.smId,
            _that.classId,
            _that.sectionId,
            _that.teacherId,
            _that.academicYr,
            _that.createdAt,
            _that.updatedAt,
            _that.name,
            _that.subjectType);
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
            @JsonKey(name: "subject_id") String? subjectId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "created_at") dynamic createdAt,
            @JsonKey(name: "updated_at") dynamic updatedAt,
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "subject_type") String? subjectType)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subject():
        return $default(
            _that.subjectId,
            _that.smId,
            _that.classId,
            _that.sectionId,
            _that.teacherId,
            _that.academicYr,
            _that.createdAt,
            _that.updatedAt,
            _that.name,
            _that.subjectType);
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
            @JsonKey(name: "subject_id") String? subjectId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "created_at") dynamic createdAt,
            @JsonKey(name: "updated_at") dynamic updatedAt,
            @JsonKey(name: "name") String? name,
            @JsonKey(name: "subject_type") String? subjectType)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Subject() when $default != null:
        return $default(
            _that.subjectId,
            _that.smId,
            _that.classId,
            _that.sectionId,
            _that.teacherId,
            _that.academicYr,
            _that.createdAt,
            _that.updatedAt,
            _that.name,
            _that.subjectType);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Subject implements Subject {
  const _Subject(
      {@JsonKey(name: "subject_id") this.subjectId,
      @JsonKey(name: "sm_id") this.smId,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "section_id") this.sectionId,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "subject_type") this.subjectType});
  factory _Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  @override
  @JsonKey(name: "subject_id")
  final String? subjectId;
  @override
  @JsonKey(name: "sm_id")
  final String? smId;
  @override
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "section_id")
  final String? sectionId;
  @override
  @JsonKey(name: "teacher_id")
  final String? teacherId;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "created_at")
  final dynamic createdAt;
  @override
  @JsonKey(name: "updated_at")
  final dynamic updatedAt;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "subject_type")
  final String? subjectType;

  /// Create a copy of Subject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubjectCopyWith<_Subject> get copyWith =>
      __$SubjectCopyWithImpl<_Subject>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubjectToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Subject &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.subjectType, subjectType) ||
                other.subjectType == subjectType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      subjectId,
      smId,
      classId,
      sectionId,
      teacherId,
      academicYr,
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt),
      name,
      subjectType);

  @override
  String toString() {
    return 'Subject(subjectId: $subjectId, smId: $smId, classId: $classId, sectionId: $sectionId, teacherId: $teacherId, academicYr: $academicYr, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, subjectType: $subjectType)';
  }
}

/// @nodoc
abstract mixin class _$SubjectCopyWith<$Res> implements $SubjectCopyWith<$Res> {
  factory _$SubjectCopyWith(_Subject value, $Res Function(_Subject) _then) =
      __$SubjectCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "subject_id") String? subjectId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "created_at") dynamic createdAt,
      @JsonKey(name: "updated_at") dynamic updatedAt,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "subject_type") String? subjectType});
}

/// @nodoc
class __$SubjectCopyWithImpl<$Res> implements _$SubjectCopyWith<$Res> {
  __$SubjectCopyWithImpl(this._self, this._then);

  final _Subject _self;
  final $Res Function(_Subject) _then;

  /// Create a copy of Subject
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? subjectId = freezed,
    Object? smId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? teacherId = freezed,
    Object? academicYr = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? name = freezed,
    Object? subjectType = freezed,
  }) {
    return _then(_Subject(
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectType: freezed == subjectType
          ? _self.subjectType
          : subjectType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
