// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassBody {
  @JsonKey(name: 'academic_yr')
  String get academicYr;
  @JsonKey(name: 'class_id')
  String get classId;
  @JsonKey(name: 'section_id')
  String get sectionId;
  @JsonKey(name: 'only_date')
  String get onlyDate;
  @JsonKey(name: 'short_name')
  String get shortName;

  /// Create a copy of ClassBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassBodyCopyWith<ClassBody> get copyWith =>
      _$ClassBodyCopyWithImpl<ClassBody>(this as ClassBody, _$identity);

  /// Serializes this ClassBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassBody &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.onlyDate, onlyDate) ||
                other.onlyDate == onlyDate) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, academicYr, classId, sectionId, onlyDate, shortName);

  @override
  String toString() {
    return 'ClassBody(academicYr: $academicYr, classId: $classId, sectionId: $sectionId, onlyDate: $onlyDate, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $ClassBodyCopyWith<$Res> {
  factory $ClassBodyCopyWith(ClassBody value, $Res Function(ClassBody) _then) =
      _$ClassBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'academic_yr') String academicYr,
      @JsonKey(name: 'class_id') String classId,
      @JsonKey(name: 'section_id') String sectionId,
      @JsonKey(name: 'only_date') String onlyDate,
      @JsonKey(name: 'short_name') String shortName});
}

/// @nodoc
class _$ClassBodyCopyWithImpl<$Res> implements $ClassBodyCopyWith<$Res> {
  _$ClassBodyCopyWithImpl(this._self, this._then);

  final ClassBody _self;
  final $Res Function(ClassBody) _then;

  /// Create a copy of ClassBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academicYr = null,
    Object? classId = null,
    Object? sectionId = null,
    Object? onlyDate = null,
    Object? shortName = null,
  }) {
    return _then(_self.copyWith(
      academicYr: null == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      onlyDate: null == onlyDate
          ? _self.onlyDate
          : onlyDate // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClassBody].
extension ClassBodyPatterns on ClassBody {
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
    TResult Function(_ClassBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassBody() when $default != null:
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
    TResult Function(_ClassBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassBody():
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
    TResult? Function(_ClassBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassBody() when $default != null:
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
            @JsonKey(name: 'academic_yr') String academicYr,
            @JsonKey(name: 'class_id') String classId,
            @JsonKey(name: 'section_id') String sectionId,
            @JsonKey(name: 'only_date') String onlyDate,
            @JsonKey(name: 'short_name') String shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassBody() when $default != null:
        return $default(_that.academicYr, _that.classId, _that.sectionId,
            _that.onlyDate, _that.shortName);
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
            @JsonKey(name: 'academic_yr') String academicYr,
            @JsonKey(name: 'class_id') String classId,
            @JsonKey(name: 'section_id') String sectionId,
            @JsonKey(name: 'only_date') String onlyDate,
            @JsonKey(name: 'short_name') String shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassBody():
        return $default(_that.academicYr, _that.classId, _that.sectionId,
            _that.onlyDate, _that.shortName);
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
            @JsonKey(name: 'academic_yr') String academicYr,
            @JsonKey(name: 'class_id') String classId,
            @JsonKey(name: 'section_id') String sectionId,
            @JsonKey(name: 'only_date') String onlyDate,
            @JsonKey(name: 'short_name') String shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassBody() when $default != null:
        return $default(_that.academicYr, _that.classId, _that.sectionId,
            _that.onlyDate, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ClassBody implements ClassBody {
  const _ClassBody(
      {@JsonKey(name: 'academic_yr') required this.academicYr,
      @JsonKey(name: 'class_id') required this.classId,
      @JsonKey(name: 'section_id') required this.sectionId,
      @JsonKey(name: 'only_date') required this.onlyDate,
      @JsonKey(name: 'short_name') required this.shortName});
  factory _ClassBody.fromJson(Map<String, dynamic> json) =>
      _$ClassBodyFromJson(json);

  @override
  @JsonKey(name: 'academic_yr')
  final String academicYr;
  @override
  @JsonKey(name: 'class_id')
  final String classId;
  @override
  @JsonKey(name: 'section_id')
  final String sectionId;
  @override
  @JsonKey(name: 'only_date')
  final String onlyDate;
  @override
  @JsonKey(name: 'short_name')
  final String shortName;

  /// Create a copy of ClassBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClassBodyCopyWith<_ClassBody> get copyWith =>
      __$ClassBodyCopyWithImpl<_ClassBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClassBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClassBody &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.onlyDate, onlyDate) ||
                other.onlyDate == onlyDate) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, academicYr, classId, sectionId, onlyDate, shortName);

  @override
  String toString() {
    return 'ClassBody(academicYr: $academicYr, classId: $classId, sectionId: $sectionId, onlyDate: $onlyDate, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$ClassBodyCopyWith<$Res>
    implements $ClassBodyCopyWith<$Res> {
  factory _$ClassBodyCopyWith(
          _ClassBody value, $Res Function(_ClassBody) _then) =
      __$ClassBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'academic_yr') String academicYr,
      @JsonKey(name: 'class_id') String classId,
      @JsonKey(name: 'section_id') String sectionId,
      @JsonKey(name: 'only_date') String onlyDate,
      @JsonKey(name: 'short_name') String shortName});
}

/// @nodoc
class __$ClassBodyCopyWithImpl<$Res> implements _$ClassBodyCopyWith<$Res> {
  __$ClassBodyCopyWithImpl(this._self, this._then);

  final _ClassBody _self;
  final $Res Function(_ClassBody) _then;

  /// Create a copy of ClassBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? academicYr = null,
    Object? classId = null,
    Object? sectionId = null,
    Object? onlyDate = null,
    Object? shortName = null,
  }) {
    return _then(_ClassBody(
      academicYr: null == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      sectionId: null == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String,
      onlyDate: null == onlyDate
          ? _self.onlyDate
          : onlyDate // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
