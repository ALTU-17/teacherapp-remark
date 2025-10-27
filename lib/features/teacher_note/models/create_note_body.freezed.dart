// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_note_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateNoteBody {
  @JsonKey(name: 'academic_yr')
  String? get academicYear;
  @JsonKey(name: 'short_name')
  String? get shortName;
  @JsonKey(name: 'random_no')
  String? get randomNo;
  @JsonKey(name: 'teacher_id')
  String? get teacherId;
  String? get description;
  @JsonKey(name: 'str_array')
  String? get strArray;
  @JsonKey(name: 'login_type')
  String? get loginType;
  String? get publish;
  @JsonKey(name: 'dailynote_date')
  String? get dailyNoteDate;
  String? get operation;
  @JsonKey(name: 'subject_id')
  String? get subjectId; //////////
  @JsonKey(name: 'section_id')
  String? get sectionId;
  @JsonKey(name: 'class_id')
  String? get classId;
  @JsonKey(name: 'notes_id')
  String? get notesId; ///////////////
  @JsonKey(name: "deleteimagelist")
  List<String>? get deleteimagelist;
  @JsonKey(name: "filename")
  List<String>? get filename;
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<PlatformFile> get files;

  /// Create a copy of CreateNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateNoteBodyCopyWith<CreateNoteBody> get copyWith =>
      _$CreateNoteBodyCopyWithImpl<CreateNoteBody>(
          this as CreateNoteBody, _$identity);

  /// Serializes this CreateNoteBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateNoteBody &&
            (identical(other.academicYear, academicYear) ||
                other.academicYear == academicYear) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.strArray, strArray) ||
                other.strArray == strArray) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.dailyNoteDate, dailyNoteDate) ||
                other.dailyNoteDate == dailyNoteDate) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            const DeepCollectionEquality()
                .equals(other.deleteimagelist, deleteimagelist) &&
            const DeepCollectionEquality().equals(other.filename, filename) &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      academicYear,
      shortName,
      randomNo,
      teacherId,
      description,
      strArray,
      loginType,
      publish,
      dailyNoteDate,
      operation,
      subjectId,
      sectionId,
      classId,
      notesId,
      const DeepCollectionEquality().hash(deleteimagelist),
      const DeepCollectionEquality().hash(filename),
      const DeepCollectionEquality().hash(files));

  @override
  String toString() {
    return 'CreateNoteBody(academicYear: $academicYear, shortName: $shortName, randomNo: $randomNo, teacherId: $teacherId, description: $description, strArray: $strArray, loginType: $loginType, publish: $publish, dailyNoteDate: $dailyNoteDate, operation: $operation, subjectId: $subjectId, sectionId: $sectionId, classId: $classId, notesId: $notesId, deleteimagelist: $deleteimagelist, filename: $filename, files: $files)';
  }
}

/// @nodoc
abstract mixin class $CreateNoteBodyCopyWith<$Res> {
  factory $CreateNoteBodyCopyWith(
          CreateNoteBody value, $Res Function(CreateNoteBody) _then) =
      _$CreateNoteBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'academic_yr') String? academicYear,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'random_no') String? randomNo,
      @JsonKey(name: 'teacher_id') String? teacherId,
      String? description,
      @JsonKey(name: 'str_array') String? strArray,
      @JsonKey(name: 'login_type') String? loginType,
      String? publish,
      @JsonKey(name: 'dailynote_date') String? dailyNoteDate,
      String? operation,
      @JsonKey(name: 'subject_id') String? subjectId,
      @JsonKey(name: 'section_id') String? sectionId,
      @JsonKey(name: 'class_id') String? classId,
      @JsonKey(name: 'notes_id') String? notesId,
      @JsonKey(name: "deleteimagelist") List<String>? deleteimagelist,
      @JsonKey(name: "filename") List<String>? filename,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<PlatformFile> files});
}

/// @nodoc
class _$CreateNoteBodyCopyWithImpl<$Res>
    implements $CreateNoteBodyCopyWith<$Res> {
  _$CreateNoteBodyCopyWithImpl(this._self, this._then);

  final CreateNoteBody _self;
  final $Res Function(CreateNoteBody) _then;

  /// Create a copy of CreateNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academicYear = freezed,
    Object? shortName = freezed,
    Object? randomNo = freezed,
    Object? teacherId = freezed,
    Object? description = freezed,
    Object? strArray = freezed,
    Object? loginType = freezed,
    Object? publish = freezed,
    Object? dailyNoteDate = freezed,
    Object? operation = freezed,
    Object? subjectId = freezed,
    Object? sectionId = freezed,
    Object? classId = freezed,
    Object? notesId = freezed,
    Object? deleteimagelist = freezed,
    Object? filename = freezed,
    Object? files = null,
  }) {
    return _then(_self.copyWith(
      academicYear: freezed == academicYear
          ? _self.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      randomNo: freezed == randomNo
          ? _self.randomNo
          : randomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      strArray: freezed == strArray
          ? _self.strArray
          : strArray // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      dailyNoteDate: freezed == dailyNoteDate
          ? _self.dailyNoteDate
          : dailyNoteDate // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      deleteimagelist: freezed == deleteimagelist
          ? _self.deleteimagelist
          : deleteimagelist // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      files: null == files
          ? _self.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateNoteBody].
extension CreateNoteBodyPatterns on CreateNoteBody {
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
    TResult Function(_CreateNoteBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateNoteBody() when $default != null:
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
    TResult Function(_CreateNoteBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateNoteBody():
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
    TResult? Function(_CreateNoteBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateNoteBody() when $default != null:
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
            @JsonKey(name: 'academic_yr') String? academicYear,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'random_no') String? randomNo,
            @JsonKey(name: 'teacher_id') String? teacherId,
            String? description,
            @JsonKey(name: 'str_array') String? strArray,
            @JsonKey(name: 'login_type') String? loginType,
            String? publish,
            @JsonKey(name: 'dailynote_date') String? dailyNoteDate,
            String? operation,
            @JsonKey(name: 'subject_id') String? subjectId,
            @JsonKey(name: 'section_id') String? sectionId,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'notes_id') String? notesId,
            @JsonKey(name: "deleteimagelist") List<String>? deleteimagelist,
            @JsonKey(name: "filename") List<String>? filename,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile> files)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateNoteBody() when $default != null:
        return $default(
            _that.academicYear,
            _that.shortName,
            _that.randomNo,
            _that.teacherId,
            _that.description,
            _that.strArray,
            _that.loginType,
            _that.publish,
            _that.dailyNoteDate,
            _that.operation,
            _that.subjectId,
            _that.sectionId,
            _that.classId,
            _that.notesId,
            _that.deleteimagelist,
            _that.filename,
            _that.files);
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
            @JsonKey(name: 'academic_yr') String? academicYear,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'random_no') String? randomNo,
            @JsonKey(name: 'teacher_id') String? teacherId,
            String? description,
            @JsonKey(name: 'str_array') String? strArray,
            @JsonKey(name: 'login_type') String? loginType,
            String? publish,
            @JsonKey(name: 'dailynote_date') String? dailyNoteDate,
            String? operation,
            @JsonKey(name: 'subject_id') String? subjectId,
            @JsonKey(name: 'section_id') String? sectionId,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'notes_id') String? notesId,
            @JsonKey(name: "deleteimagelist") List<String>? deleteimagelist,
            @JsonKey(name: "filename") List<String>? filename,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile> files)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateNoteBody():
        return $default(
            _that.academicYear,
            _that.shortName,
            _that.randomNo,
            _that.teacherId,
            _that.description,
            _that.strArray,
            _that.loginType,
            _that.publish,
            _that.dailyNoteDate,
            _that.operation,
            _that.subjectId,
            _that.sectionId,
            _that.classId,
            _that.notesId,
            _that.deleteimagelist,
            _that.filename,
            _that.files);
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
            @JsonKey(name: 'academic_yr') String? academicYear,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'random_no') String? randomNo,
            @JsonKey(name: 'teacher_id') String? teacherId,
            String? description,
            @JsonKey(name: 'str_array') String? strArray,
            @JsonKey(name: 'login_type') String? loginType,
            String? publish,
            @JsonKey(name: 'dailynote_date') String? dailyNoteDate,
            String? operation,
            @JsonKey(name: 'subject_id') String? subjectId,
            @JsonKey(name: 'section_id') String? sectionId,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'notes_id') String? notesId,
            @JsonKey(name: "deleteimagelist") List<String>? deleteimagelist,
            @JsonKey(name: "filename") List<String>? filename,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile> files)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateNoteBody() when $default != null:
        return $default(
            _that.academicYear,
            _that.shortName,
            _that.randomNo,
            _that.teacherId,
            _that.description,
            _that.strArray,
            _that.loginType,
            _that.publish,
            _that.dailyNoteDate,
            _that.operation,
            _that.subjectId,
            _that.sectionId,
            _that.classId,
            _that.notesId,
            _that.deleteimagelist,
            _that.filename,
            _that.files);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateNoteBody implements CreateNoteBody {
  const _CreateNoteBody(
      {@JsonKey(name: 'academic_yr') this.academicYear,
      @JsonKey(name: 'short_name') this.shortName,
      @JsonKey(name: 'random_no') this.randomNo,
      @JsonKey(name: 'teacher_id') this.teacherId,
      this.description,
      @JsonKey(name: 'str_array') this.strArray,
      @JsonKey(name: 'login_type') this.loginType = 'T',
      this.publish = 'Y',
      @JsonKey(name: 'dailynote_date') this.dailyNoteDate,
      this.operation = 'create',
      @JsonKey(name: 'subject_id') this.subjectId,
      @JsonKey(name: 'section_id') this.sectionId,
      @JsonKey(name: 'class_id') this.classId,
      @JsonKey(name: 'notes_id') this.notesId,
      @JsonKey(name: "deleteimagelist") final List<String>? deleteimagelist,
      @JsonKey(name: "filename") final List<String>? filename,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<PlatformFile> files = const []})
      : _deleteimagelist = deleteimagelist,
        _filename = filename,
        _files = files;
  factory _CreateNoteBody.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteBodyFromJson(json);

  @override
  @JsonKey(name: 'academic_yr')
  final String? academicYear;
  @override
  @JsonKey(name: 'short_name')
  final String? shortName;
  @override
  @JsonKey(name: 'random_no')
  final String? randomNo;
  @override
  @JsonKey(name: 'teacher_id')
  final String? teacherId;
  @override
  final String? description;
  @override
  @JsonKey(name: 'str_array')
  final String? strArray;
  @override
  @JsonKey(name: 'login_type')
  final String? loginType;
  @override
  @JsonKey()
  final String? publish;
  @override
  @JsonKey(name: 'dailynote_date')
  final String? dailyNoteDate;
  @override
  @JsonKey()
  final String? operation;
  @override
  @JsonKey(name: 'subject_id')
  final String? subjectId;
//////////
  @override
  @JsonKey(name: 'section_id')
  final String? sectionId;
  @override
  @JsonKey(name: 'class_id')
  final String? classId;
  @override
  @JsonKey(name: 'notes_id')
  final String? notesId;
///////////////
  final List<String>? _deleteimagelist;
///////////////
  @override
  @JsonKey(name: "deleteimagelist")
  List<String>? get deleteimagelist {
    final value = _deleteimagelist;
    if (value == null) return null;
    if (_deleteimagelist is EqualUnmodifiableListView) return _deleteimagelist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _filename;
  @override
  @JsonKey(name: "filename")
  List<String>? get filename {
    final value = _filename;
    if (value == null) return null;
    if (_filename is EqualUnmodifiableListView) return _filename;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PlatformFile> _files;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<PlatformFile> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  /// Create a copy of CreateNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateNoteBodyCopyWith<_CreateNoteBody> get copyWith =>
      __$CreateNoteBodyCopyWithImpl<_CreateNoteBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateNoteBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateNoteBody &&
            (identical(other.academicYear, academicYear) ||
                other.academicYear == academicYear) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.strArray, strArray) ||
                other.strArray == strArray) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.dailyNoteDate, dailyNoteDate) ||
                other.dailyNoteDate == dailyNoteDate) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            const DeepCollectionEquality()
                .equals(other._deleteimagelist, _deleteimagelist) &&
            const DeepCollectionEquality().equals(other._filename, _filename) &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      academicYear,
      shortName,
      randomNo,
      teacherId,
      description,
      strArray,
      loginType,
      publish,
      dailyNoteDate,
      operation,
      subjectId,
      sectionId,
      classId,
      notesId,
      const DeepCollectionEquality().hash(_deleteimagelist),
      const DeepCollectionEquality().hash(_filename),
      const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'CreateNoteBody(academicYear: $academicYear, shortName: $shortName, randomNo: $randomNo, teacherId: $teacherId, description: $description, strArray: $strArray, loginType: $loginType, publish: $publish, dailyNoteDate: $dailyNoteDate, operation: $operation, subjectId: $subjectId, sectionId: $sectionId, classId: $classId, notesId: $notesId, deleteimagelist: $deleteimagelist, filename: $filename, files: $files)';
  }
}

/// @nodoc
abstract mixin class _$CreateNoteBodyCopyWith<$Res>
    implements $CreateNoteBodyCopyWith<$Res> {
  factory _$CreateNoteBodyCopyWith(
          _CreateNoteBody value, $Res Function(_CreateNoteBody) _then) =
      __$CreateNoteBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'academic_yr') String? academicYear,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'random_no') String? randomNo,
      @JsonKey(name: 'teacher_id') String? teacherId,
      String? description,
      @JsonKey(name: 'str_array') String? strArray,
      @JsonKey(name: 'login_type') String? loginType,
      String? publish,
      @JsonKey(name: 'dailynote_date') String? dailyNoteDate,
      String? operation,
      @JsonKey(name: 'subject_id') String? subjectId,
      @JsonKey(name: 'section_id') String? sectionId,
      @JsonKey(name: 'class_id') String? classId,
      @JsonKey(name: 'notes_id') String? notesId,
      @JsonKey(name: "deleteimagelist") List<String>? deleteimagelist,
      @JsonKey(name: "filename") List<String>? filename,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<PlatformFile> files});
}

/// @nodoc
class __$CreateNoteBodyCopyWithImpl<$Res>
    implements _$CreateNoteBodyCopyWith<$Res> {
  __$CreateNoteBodyCopyWithImpl(this._self, this._then);

  final _CreateNoteBody _self;
  final $Res Function(_CreateNoteBody) _then;

  /// Create a copy of CreateNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? academicYear = freezed,
    Object? shortName = freezed,
    Object? randomNo = freezed,
    Object? teacherId = freezed,
    Object? description = freezed,
    Object? strArray = freezed,
    Object? loginType = freezed,
    Object? publish = freezed,
    Object? dailyNoteDate = freezed,
    Object? operation = freezed,
    Object? subjectId = freezed,
    Object? sectionId = freezed,
    Object? classId = freezed,
    Object? notesId = freezed,
    Object? deleteimagelist = freezed,
    Object? filename = freezed,
    Object? files = null,
  }) {
    return _then(_CreateNoteBody(
      academicYear: freezed == academicYear
          ? _self.academicYear
          : academicYear // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      randomNo: freezed == randomNo
          ? _self.randomNo
          : randomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      strArray: freezed == strArray
          ? _self.strArray
          : strArray // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      dailyNoteDate: freezed == dailyNoteDate
          ? _self.dailyNoteDate
          : dailyNoteDate // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      deleteimagelist: freezed == deleteimagelist
          ? _self._deleteimagelist
          : deleteimagelist // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      filename: freezed == filename
          ? _self._filename
          : filename // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      files: null == files
          ? _self._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

// dart format on
