// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subjects_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubjectsBody {
  @JsonKey(name: "academic_yr")
  String get academicYr;
  @JsonKey(name: "reg_id")
  String get regId;
  @JsonKey(name: "section_id")
  String get sectionId;
  @JsonKey(name: "class_id")
  String get classId;
  @JsonKey(name: "short_name")
  String get shortName;

  /// Create a copy of SubjectsBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SubjectsBodyCopyWith<SubjectsBody> get copyWith =>
      _$SubjectsBodyCopyWithImpl<SubjectsBody>(
          this as SubjectsBody, _$identity);

  /// Serializes this SubjectsBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SubjectsBody &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, academicYr, regId, sectionId, classId, shortName);

  @override
  String toString() {
    return 'SubjectsBody(academicYr: $academicYr, regId: $regId, sectionId: $sectionId, classId: $classId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $SubjectsBodyCopyWith<$Res> {
  factory $SubjectsBodyCopyWith(
          SubjectsBody value, $Res Function(SubjectsBody) _then) =
      _$SubjectsBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "academic_yr") String academicYr,
      @JsonKey(name: "reg_id") String regId,
      @JsonKey(name: "section_id") String sectionId,
      @JsonKey(name: "class_id") String classId,
      @JsonKey(name: "short_name") String shortName});
}

/// @nodoc
class _$SubjectsBodyCopyWithImpl<$Res> implements $SubjectsBodyCopyWith<$Res> {
  _$SubjectsBodyCopyWithImpl(this._self, this._then);

  final SubjectsBody _self;
  final $Res Function(SubjectsBody) _then;

  /// Create a copy of SubjectsBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academicYr = null,
    Object? regId = null,
    Object? sectionId = null,
    Object? classId = null,
    Object? shortName = null,
  }) {
    return _then(_self.copyWith(
      academicYr: null == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SubjectsBody].
extension SubjectsBodyPatterns on SubjectsBody {
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
    TResult Function(_SubjectsBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubjectsBody() when $default != null:
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
    TResult Function(_SubjectsBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectsBody():
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
    TResult? Function(_SubjectsBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectsBody() when $default != null:
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
            @JsonKey(name: "academic_yr") String academicYr,
            @JsonKey(name: "reg_id") String regId,
            @JsonKey(name: "section_id") String sectionId,
            @JsonKey(name: "class_id") String classId,
            @JsonKey(name: "short_name") String shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SubjectsBody() when $default != null:
        return $default(_that.academicYr, _that.regId, _that.sectionId,
            _that.classId, _that.shortName);
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
            @JsonKey(name: "academic_yr") String academicYr,
            @JsonKey(name: "reg_id") String regId,
            @JsonKey(name: "section_id") String sectionId,
            @JsonKey(name: "class_id") String classId,
            @JsonKey(name: "short_name") String shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectsBody():
        return $default(_that.academicYr, _that.regId, _that.sectionId,
            _that.classId, _that.shortName);
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
            @JsonKey(name: "academic_yr") String academicYr,
            @JsonKey(name: "reg_id") String regId,
            @JsonKey(name: "section_id") String sectionId,
            @JsonKey(name: "class_id") String classId,
            @JsonKey(name: "short_name") String shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SubjectsBody() when $default != null:
        return $default(_that.academicYr, _that.regId, _that.sectionId,
            _that.classId, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SubjectsBody implements SubjectsBody {
  const _SubjectsBody(
      {@JsonKey(name: "academic_yr") required this.academicYr,
      @JsonKey(name: "reg_id") required this.regId,
      @JsonKey(name: "section_id") required this.sectionId,
      @JsonKey(name: "class_id") required this.classId,
      @JsonKey(name: "short_name") required this.shortName});
  factory _SubjectsBody.fromJson(Map<String, dynamic> json) =>
      _$SubjectsBodyFromJson(json);

  @override
  @JsonKey(name: "academic_yr")
  final String academicYr;
  @override
  @JsonKey(name: "reg_id")
  final String regId;
  @override
  @JsonKey(name: "section_id")
  final String sectionId;
  @override
  @JsonKey(name: "class_id")
  final String classId;
  @override
  @JsonKey(name: "short_name")
  final String shortName;

  /// Create a copy of SubjectsBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubjectsBodyCopyWith<_SubjectsBody> get copyWith =>
      __$SubjectsBodyCopyWithImpl<_SubjectsBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SubjectsBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubjectsBody &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, academicYr, regId, sectionId, classId, shortName);

  @override
  String toString() {
    return 'SubjectsBody(academicYr: $academicYr, regId: $regId, sectionId: $sectionId, classId: $classId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$SubjectsBodyCopyWith<$Res>
    implements $SubjectsBodyCopyWith<$Res> {
  factory _$SubjectsBodyCopyWith(
          _SubjectsBody value, $Res Function(_SubjectsBody) _then) =
      __$SubjectsBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "academic_yr") String academicYr,
      @JsonKey(name: "reg_id") String regId,
      @JsonKey(name: "section_id") String sectionId,
      @JsonKey(name: "class_id") String classId,
      @JsonKey(name: "short_name") String shortName});
}

/// @nodoc
class __$SubjectsBodyCopyWithImpl<$Res>
    implements _$SubjectsBodyCopyWith<$Res> {
  __$SubjectsBodyCopyWithImpl(this._self, this._then);

  final _SubjectsBody _self;
  final $Res Function(_SubjectsBody) _then;

  /// Create a copy of SubjectsBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? academicYr = null,
    Object? regId = null,
    Object? sectionId = null,
    Object? classId = null,
    Object? shortName = null,
  }) {
    return _then(_SubjectsBody(
      academicYr: null == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
