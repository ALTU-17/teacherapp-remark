// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_homework_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateHomeworkBody {
  @JsonKey(name: "random_no")
  String? get randomNo;
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "teacher_id")
  String? get teacherId;
  @JsonKey(name: "section_id")
  String? get sectionId;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "sm_id")
  String? get smId;
  @JsonKey(name: "description")
  String? get description;
  @JsonKey(name: "publish")
  String? get publish;
  @JsonKey(name: "end_date")
  String? get endDate;
  @JsonKey(name: "start_date")
  String? get startDate;
  @JsonKey(name: "login_type")
  String? get loginType;
  @JsonKey(name: "operation")
  String? get operation;
  @JsonKey(name: "short_name")
  String? get shortName;
  @JsonKey(name: "deleteimagelist")
  List<String> get deleteimagelist;
  @JsonKey(name: "filename")
  List<String> get filename;
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<PlatformFile> get files;

  /// Create a copy of CreateHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateHomeworkBodyCopyWith<CreateHomeworkBody> get copyWith =>
      _$CreateHomeworkBodyCopyWithImpl<CreateHomeworkBody>(
          this as CreateHomeworkBody, _$identity);

  /// Serializes this CreateHomeworkBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateHomeworkBody &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            const DeepCollectionEquality()
                .equals(other.deleteimagelist, deleteimagelist) &&
            const DeepCollectionEquality().equals(other.filename, filename) &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      randomNo,
      homeworkId,
      academicYr,
      teacherId,
      sectionId,
      classId,
      smId,
      description,
      publish,
      endDate,
      startDate,
      loginType,
      operation,
      shortName,
      const DeepCollectionEquality().hash(deleteimagelist),
      const DeepCollectionEquality().hash(filename),
      const DeepCollectionEquality().hash(files));

  @override
  String toString() {
    return 'CreateHomeworkBody(randomNo: $randomNo, homeworkId: $homeworkId, academicYr: $academicYr, teacherId: $teacherId, sectionId: $sectionId, classId: $classId, smId: $smId, description: $description, publish: $publish, endDate: $endDate, startDate: $startDate, loginType: $loginType, operation: $operation, shortName: $shortName, deleteimagelist: $deleteimagelist, filename: $filename, files: $files)';
  }
}

/// @nodoc
abstract mixin class $CreateHomeworkBodyCopyWith<$Res> {
  factory $CreateHomeworkBodyCopyWith(
          CreateHomeworkBody value, $Res Function(CreateHomeworkBody) _then) =
      _$CreateHomeworkBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "random_no") String? randomNo,
      @JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "end_date") String? endDate,
      @JsonKey(name: "start_date") String? startDate,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "deleteimagelist") List<String> deleteimagelist,
      @JsonKey(name: "filename") List<String> filename,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<PlatformFile> files});
}

/// @nodoc
class _$CreateHomeworkBodyCopyWithImpl<$Res>
    implements $CreateHomeworkBodyCopyWith<$Res> {
  _$CreateHomeworkBodyCopyWithImpl(this._self, this._then);

  final CreateHomeworkBody _self;
  final $Res Function(CreateHomeworkBody) _then;

  /// Create a copy of CreateHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? randomNo = freezed,
    Object? homeworkId = freezed,
    Object? academicYr = freezed,
    Object? teacherId = freezed,
    Object? sectionId = freezed,
    Object? classId = freezed,
    Object? smId = freezed,
    Object? description = freezed,
    Object? publish = freezed,
    Object? endDate = freezed,
    Object? startDate = freezed,
    Object? loginType = freezed,
    Object? operation = freezed,
    Object? shortName = freezed,
    Object? deleteimagelist = null,
    Object? filename = null,
    Object? files = null,
  }) {
    return _then(_self.copyWith(
      randomNo: freezed == randomNo
          ? _self.randomNo
          : randomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      deleteimagelist: null == deleteimagelist
          ? _self.deleteimagelist
          : deleteimagelist // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filename: null == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as List<String>,
      files: null == files
          ? _self.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateHomeworkBody].
extension CreateHomeworkBodyPatterns on CreateHomeworkBody {
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
    TResult Function(_CreateHomeworkBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateHomeworkBody() when $default != null:
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
    TResult Function(_CreateHomeworkBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateHomeworkBody():
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
    TResult? Function(_CreateHomeworkBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateHomeworkBody() when $default != null:
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
            @JsonKey(name: "random_no") String? randomNo,
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "end_date") String? endDate,
            @JsonKey(name: "start_date") String? startDate,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "deleteimagelist") List<String> deleteimagelist,
            @JsonKey(name: "filename") List<String> filename,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile> files)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateHomeworkBody() when $default != null:
        return $default(
            _that.randomNo,
            _that.homeworkId,
            _that.academicYr,
            _that.teacherId,
            _that.sectionId,
            _that.classId,
            _that.smId,
            _that.description,
            _that.publish,
            _that.endDate,
            _that.startDate,
            _that.loginType,
            _that.operation,
            _that.shortName,
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
            @JsonKey(name: "random_no") String? randomNo,
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "end_date") String? endDate,
            @JsonKey(name: "start_date") String? startDate,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "deleteimagelist") List<String> deleteimagelist,
            @JsonKey(name: "filename") List<String> filename,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile> files)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateHomeworkBody():
        return $default(
            _that.randomNo,
            _that.homeworkId,
            _that.academicYr,
            _that.teacherId,
            _that.sectionId,
            _that.classId,
            _that.smId,
            _that.description,
            _that.publish,
            _that.endDate,
            _that.startDate,
            _that.loginType,
            _that.operation,
            _that.shortName,
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
            @JsonKey(name: "random_no") String? randomNo,
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "teacher_id") String? teacherId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "sm_id") String? smId,
            @JsonKey(name: "description") String? description,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "end_date") String? endDate,
            @JsonKey(name: "start_date") String? startDate,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "deleteimagelist") List<String> deleteimagelist,
            @JsonKey(name: "filename") List<String> filename,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile> files)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateHomeworkBody() when $default != null:
        return $default(
            _that.randomNo,
            _that.homeworkId,
            _that.academicYr,
            _that.teacherId,
            _that.sectionId,
            _that.classId,
            _that.smId,
            _that.description,
            _that.publish,
            _that.endDate,
            _that.startDate,
            _that.loginType,
            _that.operation,
            _that.shortName,
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
class _CreateHomeworkBody implements CreateHomeworkBody {
  const _CreateHomeworkBody(
      {@JsonKey(name: "random_no") this.randomNo,
      @JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "teacher_id") this.teacherId,
      @JsonKey(name: "section_id") this.sectionId,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "sm_id") this.smId,
      @JsonKey(name: "description") this.description,
      @JsonKey(name: "publish") this.publish,
      @JsonKey(name: "end_date") this.endDate,
      @JsonKey(name: "start_date") this.startDate,
      @JsonKey(name: "login_type") this.loginType,
      @JsonKey(name: "operation") this.operation = 'create',
      @JsonKey(name: "short_name") this.shortName,
      @JsonKey(name: "deleteimagelist")
      final List<String> deleteimagelist = const [],
      @JsonKey(name: "filename") final List<String> filename = const [],
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<PlatformFile> files = const []})
      : _deleteimagelist = deleteimagelist,
        _filename = filename,
        _files = files;
  factory _CreateHomeworkBody.fromJson(Map<String, dynamic> json) =>
      _$CreateHomeworkBodyFromJson(json);

  @override
  @JsonKey(name: "random_no")
  final String? randomNo;
  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "teacher_id")
  final String? teacherId;
  @override
  @JsonKey(name: "section_id")
  final String? sectionId;
  @override
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "sm_id")
  final String? smId;
  @override
  @JsonKey(name: "description")
  final String? description;
  @override
  @JsonKey(name: "publish")
  final String? publish;
  @override
  @JsonKey(name: "end_date")
  final String? endDate;
  @override
  @JsonKey(name: "start_date")
  final String? startDate;
  @override
  @JsonKey(name: "login_type")
  final String? loginType;
  @override
  @JsonKey(name: "operation")
  final String? operation;
  @override
  @JsonKey(name: "short_name")
  final String? shortName;
  final List<String> _deleteimagelist;
  @override
  @JsonKey(name: "deleteimagelist")
  List<String> get deleteimagelist {
    if (_deleteimagelist is EqualUnmodifiableListView) return _deleteimagelist;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_deleteimagelist);
  }

  final List<String> _filename;
  @override
  @JsonKey(name: "filename")
  List<String> get filename {
    if (_filename is EqualUnmodifiableListView) return _filename;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filename);
  }

  final List<PlatformFile> _files;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<PlatformFile> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  /// Create a copy of CreateHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateHomeworkBodyCopyWith<_CreateHomeworkBody> get copyWith =>
      __$CreateHomeworkBodyCopyWithImpl<_CreateHomeworkBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateHomeworkBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateHomeworkBody &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            const DeepCollectionEquality()
                .equals(other._deleteimagelist, _deleteimagelist) &&
            const DeepCollectionEquality().equals(other._filename, _filename) &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      randomNo,
      homeworkId,
      academicYr,
      teacherId,
      sectionId,
      classId,
      smId,
      description,
      publish,
      endDate,
      startDate,
      loginType,
      operation,
      shortName,
      const DeepCollectionEquality().hash(_deleteimagelist),
      const DeepCollectionEquality().hash(_filename),
      const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'CreateHomeworkBody(randomNo: $randomNo, homeworkId: $homeworkId, academicYr: $academicYr, teacherId: $teacherId, sectionId: $sectionId, classId: $classId, smId: $smId, description: $description, publish: $publish, endDate: $endDate, startDate: $startDate, loginType: $loginType, operation: $operation, shortName: $shortName, deleteimagelist: $deleteimagelist, filename: $filename, files: $files)';
  }
}

/// @nodoc
abstract mixin class _$CreateHomeworkBodyCopyWith<$Res>
    implements $CreateHomeworkBodyCopyWith<$Res> {
  factory _$CreateHomeworkBodyCopyWith(
          _CreateHomeworkBody value, $Res Function(_CreateHomeworkBody) _then) =
      __$CreateHomeworkBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "random_no") String? randomNo,
      @JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "teacher_id") String? teacherId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "sm_id") String? smId,
      @JsonKey(name: "description") String? description,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "end_date") String? endDate,
      @JsonKey(name: "start_date") String? startDate,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "deleteimagelist") List<String> deleteimagelist,
      @JsonKey(name: "filename") List<String> filename,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<PlatformFile> files});
}

/// @nodoc
class __$CreateHomeworkBodyCopyWithImpl<$Res>
    implements _$CreateHomeworkBodyCopyWith<$Res> {
  __$CreateHomeworkBodyCopyWithImpl(this._self, this._then);

  final _CreateHomeworkBody _self;
  final $Res Function(_CreateHomeworkBody) _then;

  /// Create a copy of CreateHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? randomNo = freezed,
    Object? homeworkId = freezed,
    Object? academicYr = freezed,
    Object? teacherId = freezed,
    Object? sectionId = freezed,
    Object? classId = freezed,
    Object? smId = freezed,
    Object? description = freezed,
    Object? publish = freezed,
    Object? endDate = freezed,
    Object? startDate = freezed,
    Object? loginType = freezed,
    Object? operation = freezed,
    Object? shortName = freezed,
    Object? deleteimagelist = null,
    Object? filename = null,
    Object? files = null,
  }) {
    return _then(_CreateHomeworkBody(
      randomNo: freezed == randomNo
          ? _self.randomNo
          : randomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      smId: freezed == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      deleteimagelist: null == deleteimagelist
          ? _self._deleteimagelist
          : deleteimagelist // ignore: cast_nullable_to_non_nullable
              as List<String>,
      filename: null == filename
          ? _self._filename
          : filename // ignore: cast_nullable_to_non_nullable
              as List<String>,
      files: null == files
          ? _self._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>,
    ));
  }
}

// dart format on
