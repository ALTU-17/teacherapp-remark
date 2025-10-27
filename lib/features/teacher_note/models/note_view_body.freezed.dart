// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_view_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteViewBody {
  @JsonKey(name: 'acd_yr')
  String? get acdYr;
  @JsonKey(name: 'class_id')
  String? get classId;
  @JsonKey(name: 'section_id')
  String? get sectionId;
  @JsonKey(name: 'notes_id')
  String? get notesId;
  @JsonKey(name: 'short_name')
  String? get shortName;

  /// Create a copy of NoteViewBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoteViewBodyCopyWith<NoteViewBody> get copyWith =>
      _$NoteViewBodyCopyWithImpl<NoteViewBody>(
          this as NoteViewBody, _$identity);

  /// Serializes this NoteViewBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoteViewBody &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, acdYr, classId, sectionId, notesId, shortName);

  @override
  String toString() {
    return 'NoteViewBody(acdYr: $acdYr, classId: $classId, sectionId: $sectionId, notesId: $notesId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $NoteViewBodyCopyWith<$Res> {
  factory $NoteViewBodyCopyWith(
          NoteViewBody value, $Res Function(NoteViewBody) _then) =
      _$NoteViewBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'acd_yr') String? acdYr,
      @JsonKey(name: 'class_id') String? classId,
      @JsonKey(name: 'section_id') String? sectionId,
      @JsonKey(name: 'notes_id') String? notesId,
      @JsonKey(name: 'short_name') String? shortName});
}

/// @nodoc
class _$NoteViewBodyCopyWithImpl<$Res> implements $NoteViewBodyCopyWith<$Res> {
  _$NoteViewBodyCopyWithImpl(this._self, this._then);

  final NoteViewBody _self;
  final $Res Function(NoteViewBody) _then;

  /// Create a copy of NoteViewBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acdYr = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? notesId = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_self.copyWith(
      acdYr: freezed == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NoteViewBody].
extension NoteViewBodyPatterns on NoteViewBody {
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
    TResult Function(_NoteViewBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoteViewBody() when $default != null:
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
    TResult Function(_NoteViewBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteViewBody():
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
    TResult? Function(_NoteViewBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteViewBody() when $default != null:
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
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'section_id') String? sectionId,
            @JsonKey(name: 'notes_id') String? notesId,
            @JsonKey(name: 'short_name') String? shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoteViewBody() when $default != null:
        return $default(_that.acdYr, _that.classId, _that.sectionId,
            _that.notesId, _that.shortName);
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
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'section_id') String? sectionId,
            @JsonKey(name: 'notes_id') String? notesId,
            @JsonKey(name: 'short_name') String? shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteViewBody():
        return $default(_that.acdYr, _that.classId, _that.sectionId,
            _that.notesId, _that.shortName);
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
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'class_id') String? classId,
            @JsonKey(name: 'section_id') String? sectionId,
            @JsonKey(name: 'notes_id') String? notesId,
            @JsonKey(name: 'short_name') String? shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteViewBody() when $default != null:
        return $default(_that.acdYr, _that.classId, _that.sectionId,
            _that.notesId, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NoteViewBody implements NoteViewBody {
  const _NoteViewBody(
      {@JsonKey(name: 'acd_yr') this.acdYr,
      @JsonKey(name: 'class_id') this.classId,
      @JsonKey(name: 'section_id') this.sectionId,
      @JsonKey(name: 'notes_id') this.notesId,
      @JsonKey(name: 'short_name') this.shortName});
  factory _NoteViewBody.fromJson(Map<String, dynamic> json) =>
      _$NoteViewBodyFromJson(json);

  @override
  @JsonKey(name: 'acd_yr')
  final String? acdYr;
  @override
  @JsonKey(name: 'class_id')
  final String? classId;
  @override
  @JsonKey(name: 'section_id')
  final String? sectionId;
  @override
  @JsonKey(name: 'notes_id')
  final String? notesId;
  @override
  @JsonKey(name: 'short_name')
  final String? shortName;

  /// Create a copy of NoteViewBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NoteViewBodyCopyWith<_NoteViewBody> get copyWith =>
      __$NoteViewBodyCopyWithImpl<_NoteViewBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NoteViewBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoteViewBody &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, acdYr, classId, sectionId, notesId, shortName);

  @override
  String toString() {
    return 'NoteViewBody(acdYr: $acdYr, classId: $classId, sectionId: $sectionId, notesId: $notesId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$NoteViewBodyCopyWith<$Res>
    implements $NoteViewBodyCopyWith<$Res> {
  factory _$NoteViewBodyCopyWith(
          _NoteViewBody value, $Res Function(_NoteViewBody) _then) =
      __$NoteViewBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'acd_yr') String? acdYr,
      @JsonKey(name: 'class_id') String? classId,
      @JsonKey(name: 'section_id') String? sectionId,
      @JsonKey(name: 'notes_id') String? notesId,
      @JsonKey(name: 'short_name') String? shortName});
}

/// @nodoc
class __$NoteViewBodyCopyWithImpl<$Res>
    implements _$NoteViewBodyCopyWith<$Res> {
  __$NoteViewBodyCopyWithImpl(this._self, this._then);

  final _NoteViewBody _self;
  final $Res Function(_NoteViewBody) _then;

  /// Create a copy of NoteViewBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? acdYr = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? notesId = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_NoteViewBody(
      acdYr: freezed == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      notesId: freezed == notesId
          ? _self.notesId
          : notesId // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
