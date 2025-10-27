// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Note {
  @JsonKey(name: "notes_id")
  String? get notesId;
  @JsonKey(name: "date")
  String? get date;
  @JsonKey(name: "publish_date")
  DateTime? get publishDate;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "section_id")
  String? get sectionId;
  @JsonKey(name: "subject_id")
  String? get subjectId;
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "publish")
  String? get publish;
  @JsonKey(name: "subjectname")
  String? get subjectname;
  @JsonKey(name: "sm_id")
  String? get smId;
  @JsonKey(name: "classname")
  String? get classname;
  @JsonKey(name: "sectionname")
  String? get sectionname;

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoteCopyWith<Note> get copyWith =>
      _$NoteCopyWithImpl<Note>(this as Note, _$identity);

  /// Serializes this Note to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Note &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.publishDate, publishDate) ||
                other.publishDate == publishDate) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.subjectname, subjectname) ||
                other.subjectname == subjectname) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.classname, classname) ||
                other.classname == classname) &&
            (identical(other.sectionname, sectionname) ||
                other.sectionname == sectionname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notesId,
      date,
      publishDate,
      classId,
      teacherId,
      sectionId,
      subjectId,
      description,
      academicYr,
      publish,
      subjectname,
      smId,
      classname,
      sectionname);

  @override
  String toString() {
    return 'Note(notesId: $notesId, date: $date, publishDate: $publishDate, classId: $classId, teacherId: $teacherId, sectionId: $sectionId, subjectId: $subjectId, description: $description, academicYr: $academicYr, publish: $publish, subjectname: $subjectname, smId: $smId, classname: $classname, sectionname: $sectionname)';
  }
}

/// @nodoc
abstract mixin class $NoteCopyWith<$Res> {
  factory $NoteCopyWith(Note value, $Res Function(Note) _then) =
      _$NoteCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "notes_id") String? notesId,
      @JsonKey(name: "date") String? date,
      @JsonKey(name: "publish_date") DateTime? publishDate,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "subject_id") String? subjectId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "subjectname") String? subjectname,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "classname") String? classname,
      @JsonKey(name: "sectionname") String? sectionname});
}

/// @nodoc
class _$NoteCopyWithImpl<$Res> implements $NoteCopyWith<$Res> {
  _$NoteCopyWithImpl(this._self, this._then);

  final Note _self;
  final $Res Function(Note) _then;

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notesId = freezed,
    Object? date = freezed,
    Object? publishDate = freezed,
    Object? classId = freezed,
    Object? teacherId = freezed,
    Object? sectionId = freezed,
    Object? subjectId = freezed,
    Object? description = freezed,
    Object? academicYr = freezed,
    Object? publish = freezed,
    Object? subjectname = freezed,
    Object? smId = freezed,
    Object? classname = freezed,
    Object? sectionname = freezed,
  }) {
    return _then(_self.copyWith(
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      publishDate: freezed == publishDate
          ? _self.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectname: freezed == subjectname
          ? _self.subjectname
          : subjectname // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      classname: freezed == classname
          ? _self.classname
          : classname // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionname: freezed == sectionname
          ? _self.sectionname
          : sectionname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Note].
extension NotePatterns on Note {
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
    TResult Function(_Note value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Note() when $default != null:
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
    TResult Function(_Note value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Note():
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
    TResult? Function(_Note value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Note() when $default != null:
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
            @JsonKey(name: "notes_id") String? notesId,
            @JsonKey(name: "date") String? date,
            @JsonKey(name: "publish_date") DateTime? publishDate,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "subject_id") String? subjectId,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "subjectname") String? subjectname,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "classname") String? classname,
            @JsonKey(name: "sectionname") String? sectionname)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Note() when $default != null:
        return $default(
            _that.notesId,
            _that.date,
            _that.publishDate,
            _that.classId,
            _that.teacherId,
            _that.sectionId,
            _that.subjectId,
            _that.description,
            _that.academicYr,
            _that.publish,
            _that.subjectname,
            _that.smId,
            _that.classname,
            _that.sectionname);
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
            @JsonKey(name: "notes_id") String? notesId,
            @JsonKey(name: "date") String? date,
            @JsonKey(name: "publish_date") DateTime? publishDate,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "subject_id") String? subjectId,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "subjectname") String? subjectname,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "classname") String? classname,
            @JsonKey(name: "sectionname") String? sectionname)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Note():
        return $default(
            _that.notesId,
            _that.date,
            _that.publishDate,
            _that.classId,
            _that.teacherId,
            _that.sectionId,
            _that.subjectId,
            _that.description,
            _that.academicYr,
            _that.publish,
            _that.subjectname,
            _that.smId,
            _that.classname,
            _that.sectionname);
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
            @JsonKey(name: "notes_id") String? notesId,
            @JsonKey(name: "date") String? date,
            @JsonKey(name: "publish_date") DateTime? publishDate,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "subject_id") String? subjectId,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "subjectname") String? subjectname,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "classname") String? classname,
            @JsonKey(name: "sectionname") String? sectionname)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Note() when $default != null:
        return $default(
            _that.notesId,
            _that.date,
            _that.publishDate,
            _that.classId,
            _that.teacherId,
            _that.sectionId,
            _that.subjectId,
            _that.description,
            _that.academicYr,
            _that.publish,
            _that.subjectname,
            _that.smId,
            _that.classname,
            _that.sectionname);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Note implements Note {
  const _Note(
      {@JsonKey(name: "notes_id") this.notesId,
      @JsonKey(name: "date") this.date,
      @JsonKey(name: "publish_date") this.publishDate,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "section_id") this.sectionId,
      @JsonKey(name: "subject_id") this.subjectId,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "publish") this.publish,
      @JsonKey(name: "subjectname") this.subjectname,
      @JsonKey(name: "sm_id") this.smId,
      @JsonKey(name: "classname") this.classname,
      @JsonKey(name: "sectionname") this.sectionname});
  factory _Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  @override
  @JsonKey(name: "notes_id")
  final String? notesId;
  @override
  @JsonKey(name: "date")
  final String? date;
  @override
  @JsonKey(name: "publish_date")
  final DateTime? publishDate;
  @override
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "teacher_id")
  final String? teacherId;
  @override
  @JsonKey(name: "section_id")
  final String? sectionId;
  @override
  @JsonKey(name: "subject_id")
  final String? subjectId;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "publish")
  final String? publish;
  @override
  @JsonKey(name: "subjectname")
  final String? subjectname;
  @override
  @JsonKey(name: "sm_id")
  final String? smId;
  @override
  @JsonKey(name: "classname")
  final String? classname;
  @override
  @JsonKey(name: "sectionname")
  final String? sectionname;

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NoteCopyWith<_Note> get copyWith =>
      __$NoteCopyWithImpl<_Note>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NoteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Note &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.publishDate, publishDate) ||
                other.publishDate == publishDate) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.subjectname, subjectname) ||
                other.subjectname == subjectname) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.classname, classname) ||
                other.classname == classname) &&
            (identical(other.sectionname, sectionname) ||
                other.sectionname == sectionname));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notesId,
      date,
      publishDate,
      classId,
      teacherId,
      sectionId,
      subjectId,
      description,
      academicYr,
      publish,
      subjectname,
      smId,
      classname,
      sectionname);

  @override
  String toString() {
    return 'Note(notesId: $notesId, date: $date, publishDate: $publishDate, classId: $classId, teacherId: $teacherId, sectionId: $sectionId, subjectId: $subjectId, description: $description, academicYr: $academicYr, publish: $publish, subjectname: $subjectname, smId: $smId, classname: $classname, sectionname: $sectionname)';
  }
}

/// @nodoc
abstract mixin class _$NoteCopyWith<$Res> implements $NoteCopyWith<$Res> {
  factory _$NoteCopyWith(_Note value, $Res Function(_Note) _then) =
      __$NoteCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "notes_id") String? notesId,
      @JsonKey(name: "date") String? date,
      @JsonKey(name: "publish_date") DateTime? publishDate,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "subject_id") String? subjectId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "subjectname") String? subjectname,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "classname") String? classname,
      @JsonKey(name: "sectionname") String? sectionname});
}

/// @nodoc
class __$NoteCopyWithImpl<$Res> implements _$NoteCopyWith<$Res> {
  __$NoteCopyWithImpl(this._self, this._then);

  final _Note _self;
  final $Res Function(_Note) _then;

  /// Create a copy of Note
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? notesId = freezed,
    Object? date = freezed,
    Object? publishDate = freezed,
    Object? classId = freezed,
    Object? teacherId = freezed,
    Object? sectionId = freezed,
    Object? subjectId = freezed,
    Object? description = freezed,
    Object? academicYr = freezed,
    Object? publish = freezed,
    Object? subjectname = freezed,
    Object? smId = freezed,
    Object? classname = freezed,
    Object? sectionname = freezed,
  }) {
    return _then(_Note(
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      publishDate: freezed == publishDate
          ? _self.publishDate
          : publishDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectname: freezed == subjectname
          ? _self.subjectname
          : subjectname // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      classname: freezed == classname
          ? _self.classname
          : classname // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionname: freezed == sectionname
          ? _self.sectionname
          : sectionname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
