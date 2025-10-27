// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_publish_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotePublishBody {
  @JsonKey(name: 'notes_id')
  String? get notesId;
  String? get operation;
  @JsonKey(name: 'login_type')
  String? get loginType;
  @JsonKey(name: 'short_name')
  String? get shortName;
  @JsonKey(name: 'publish')
  String? get publish;
  @JsonKey(name: 'reg_id')
  String? get regId;
  @JsonKey(name: 'acd_yr')
  String? get acdYr;
  @JsonKey(name: 'subject_id')
  String? get subjectId;
  @JsonKey(name: 'class_id')
  String? get classId;
  @JsonKey(name: 'section_id')
  String? get sectionId;

  /// Create a copy of NotePublishBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NotePublishBodyCopyWith<NotePublishBody> get copyWith =>
      _$NotePublishBodyCopyWithImpl<NotePublishBody>(
          this as NotePublishBody, _$identity);

  /// Serializes this NotePublishBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NotePublishBody &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, notesId, operation, loginType,
      shortName, publish, regId, acdYr, subjectId, classId, sectionId);

  @override
  String toString() {
    return 'NotePublishBody(notesId: $notesId, operation: $operation, loginType: $loginType, shortName: $shortName, publish: $publish, regId: $regId, acdYr: $acdYr, subjectId: $subjectId, classId: $classId, sectionId: $sectionId)';
  }
}

/// @nodoc
abstract mixin class $NotePublishBodyCopyWith<$Res> {
  factory $NotePublishBodyCopyWith(
          NotePublishBody value, $Res Function(NotePublishBody) _then) =
      _$NotePublishBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'notes_id') String? notesId,
      String? operation,
      @JsonKey(name: 'login_type') String? loginType,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'publish') String? publish,
      @JsonKey(name: 'reg_id') String? regId,
      @JsonKey(name: 'acd_yr') String? acdYr,
      @JsonKey(name: 'subject_id') String? subjectId,
      @JsonKey(name: 'class_id') String? classId,
      @JsonKey(name: 'section_id') String? sectionId});
}

/// @nodoc
class _$NotePublishBodyCopyWithImpl<$Res>
    implements $NotePublishBodyCopyWith<$Res> {
  _$NotePublishBodyCopyWithImpl(this._self, this._then);

  final NotePublishBody _self;
  final $Res Function(NotePublishBody) _then;

  /// Create a copy of NotePublishBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notesId = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? shortName = freezed,
    Object? publish = freezed,
    Object? regId = freezed,
    Object? acdYr = freezed,
    Object? subjectId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
  }) {
    return _then(_self.copyWith(
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      acdYr: freezed == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NotePublishBody].
extension NotePublishBodyPatterns on NotePublishBody {
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
    TResult Function(_NotePublishBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotePublishBody() when $default != null:
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
    TResult Function(_NotePublishBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotePublishBody():
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
    TResult? Function(_NotePublishBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotePublishBody() when $default != null:
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
            @JsonKey(name: 'notes_id') String? notesId,
            String? operation,
            @JsonKey(name: 'login_type') String? loginType,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'publish') String? publish,
            @JsonKey(name: 'reg_id') String? regId,
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'subject_id') String? subjectId,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'section_id') String? sectionId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NotePublishBody() when $default != null:
        return $default(
            _that.notesId,
            _that.operation,
            _that.loginType,
            _that.shortName,
            _that.publish,
            _that.regId,
            _that.acdYr,
            _that.subjectId,
            _that.classId,
            _that.sectionId);
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
            @JsonKey(name: 'notes_id') String? notesId,
            String? operation,
            @JsonKey(name: 'login_type') String? loginType,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'publish') String? publish,
            @JsonKey(name: 'reg_id') String? regId,
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'subject_id') String? subjectId,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'section_id') String? sectionId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotePublishBody():
        return $default(
            _that.notesId,
            _that.operation,
            _that.loginType,
            _that.shortName,
            _that.publish,
            _that.regId,
            _that.acdYr,
            _that.subjectId,
            _that.classId,
            _that.sectionId);
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
            @JsonKey(name: 'notes_id') String? notesId,
            String? operation,
            @JsonKey(name: 'login_type') String? loginType,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'publish') String? publish,
            @JsonKey(name: 'reg_id') String? regId,
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'subject_id') String? subjectId,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'section_id') String? sectionId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NotePublishBody() when $default != null:
        return $default(
            _that.notesId,
            _that.operation,
            _that.loginType,
            _that.shortName,
            _that.publish,
            _that.regId,
            _that.acdYr,
            _that.subjectId,
            _that.classId,
            _that.sectionId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NotePublishBody implements NotePublishBody {
  const _NotePublishBody(
      {@JsonKey(name: 'notes_id') this.notesId,
      this.operation = 'publish',
      @JsonKey(name: 'login_type') this.loginType = 'T',
      @JsonKey(name: 'short_name') this.shortName,
      @JsonKey(name: 'publish') this.publish = 'Y',
      @JsonKey(name: 'reg_id') this.regId,
      @JsonKey(name: 'acd_yr') this.acdYr,
      @JsonKey(name: 'subject_id') this.subjectId,
      @JsonKey(name: 'class_id') this.classId,
      @JsonKey(name: 'section_id') this.sectionId});
  factory _NotePublishBody.fromJson(Map<String, dynamic> json) =>
      _$NotePublishBodyFromJson(json);

  @override
  @JsonKey(name: 'notes_id')
  final String? notesId;
  @override
  @JsonKey()
  final String? operation;
  @override
  @JsonKey(name: 'login_type')
  final String? loginType;
  @override
  @JsonKey(name: 'short_name')
  final String? shortName;
  @override
  @JsonKey(name: 'publish')
  final String? publish;
  @override
  @JsonKey(name: 'reg_id')
  final String? regId;
  @override
  @JsonKey(name: 'acd_yr')
  final String? acdYr;
  @override
  @JsonKey(name: 'subject_id')
  final String? subjectId;
  @override
  @JsonKey(name: 'class_id')
  final String? classId;
  @override
  @JsonKey(name: 'section_id')
  final String? sectionId;

  /// Create a copy of NotePublishBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NotePublishBodyCopyWith<_NotePublishBody> get copyWith =>
      __$NotePublishBodyCopyWithImpl<_NotePublishBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NotePublishBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotePublishBody &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.subjectId, subjectId) ||
                other.subjectId == subjectId) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, notesId, operation, loginType,
      shortName, publish, regId, acdYr, subjectId, classId, sectionId);

  @override
  String toString() {
    return 'NotePublishBody(notesId: $notesId, operation: $operation, loginType: $loginType, shortName: $shortName, publish: $publish, regId: $regId, acdYr: $acdYr, subjectId: $subjectId, classId: $classId, sectionId: $sectionId)';
  }
}

/// @nodoc
abstract mixin class _$NotePublishBodyCopyWith<$Res>
    implements $NotePublishBodyCopyWith<$Res> {
  factory _$NotePublishBodyCopyWith(
          _NotePublishBody value, $Res Function(_NotePublishBody) _then) =
      __$NotePublishBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'notes_id') String? notesId,
      String? operation,
      @JsonKey(name: 'login_type') String? loginType,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'publish') String? publish,
      @JsonKey(name: 'reg_id') String? regId,
      @JsonKey(name: 'acd_yr') String? acdYr,
      @JsonKey(name: 'subject_id') String? subjectId,
      @JsonKey(name: 'class_id') String? classId,
      @JsonKey(name: 'section_id') String? sectionId});
}

/// @nodoc
class __$NotePublishBodyCopyWithImpl<$Res>
    implements _$NotePublishBodyCopyWith<$Res> {
  __$NotePublishBodyCopyWithImpl(this._self, this._then);

  final _NotePublishBody _self;
  final $Res Function(_NotePublishBody) _then;

  /// Create a copy of NotePublishBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? notesId = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? shortName = freezed,
    Object? publish = freezed,
    Object? regId = freezed,
    Object? acdYr = freezed,
    Object? subjectId = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
  }) {
    return _then(_NotePublishBody(
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      acdYr: freezed == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String?,
      subjectId: freezed == subjectId
          ? _self.subjectId
          : subjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
