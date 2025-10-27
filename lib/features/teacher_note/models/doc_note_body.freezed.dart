// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doc_note_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocNoteBody {
  @JsonKey(name: "note_id")
  String get noteId;
  @JsonKey(name: "dailynote_date")
  String? get dailynoteDate;
  @JsonKey(name: "short_name")
  String get shortName;

  /// Create a copy of DocNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DocNoteBodyCopyWith<DocNoteBody> get copyWith =>
      _$DocNoteBodyCopyWithImpl<DocNoteBody>(this as DocNoteBody, _$identity);

  /// Serializes this DocNoteBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DocNoteBody &&
            (identical(other.noteId, noteId) || other.noteId == noteId) &&
            (identical(other.dailynoteDate, dailynoteDate) ||
                other.dailynoteDate == dailynoteDate) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, noteId, dailynoteDate, shortName);

  @override
  String toString() {
    return 'DocNoteBody(noteId: $noteId, dailynoteDate: $dailynoteDate, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $DocNoteBodyCopyWith<$Res> {
  factory $DocNoteBodyCopyWith(
          DocNoteBody value, $Res Function(DocNoteBody) _then) =
      _$DocNoteBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "note_id") String noteId,
      @JsonKey(name: "dailynote_date") String? dailynoteDate,
      @JsonKey(name: "short_name") String shortName});
}

/// @nodoc
class _$DocNoteBodyCopyWithImpl<$Res> implements $DocNoteBodyCopyWith<$Res> {
  _$DocNoteBodyCopyWithImpl(this._self, this._then);

  final DocNoteBody _self;
  final $Res Function(DocNoteBody) _then;

  /// Create a copy of DocNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? noteId = null,
    Object? dailynoteDate = freezed,
    Object? shortName = null,
  }) {
    return _then(_self.copyWith(
      noteId: null == noteId
          ? _self.noteId
          : noteId // ignore: cast_nullable_to_non_nullable
              as String,
      dailynoteDate: freezed == dailynoteDate
          ? _self.dailynoteDate
          : dailynoteDate // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [DocNoteBody].
extension DocNoteBodyPatterns on DocNoteBody {
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
    TResult Function(_DocNoteBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocNoteBody() when $default != null:
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
    TResult Function(_DocNoteBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocNoteBody():
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
    TResult? Function(_DocNoteBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocNoteBody() when $default != null:
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
            @JsonKey(name: "note_id") String noteId,
            @JsonKey(name: "dailynote_date") String? dailynoteDate,
            @JsonKey(name: "short_name") String shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocNoteBody() when $default != null:
        return $default(_that.noteId, _that.dailynoteDate, _that.shortName);
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
            @JsonKey(name: "note_id") String noteId,
            @JsonKey(name: "dailynote_date") String? dailynoteDate,
            @JsonKey(name: "short_name") String shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocNoteBody():
        return $default(_that.noteId, _that.dailynoteDate, _that.shortName);
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
            @JsonKey(name: "note_id") String noteId,
            @JsonKey(name: "dailynote_date") String? dailynoteDate,
            @JsonKey(name: "short_name") String shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocNoteBody() when $default != null:
        return $default(_that.noteId, _that.dailynoteDate, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DocNoteBody implements DocNoteBody {
  const _DocNoteBody(
      {@JsonKey(name: "note_id") required this.noteId,
      @JsonKey(name: "dailynote_date") this.dailynoteDate,
      @JsonKey(name: "short_name") required this.shortName});
  factory _DocNoteBody.fromJson(Map<String, dynamic> json) =>
      _$DocNoteBodyFromJson(json);

  @override
  @JsonKey(name: "note_id")
  final String noteId;
  @override
  @JsonKey(name: "dailynote_date")
  final String? dailynoteDate;
  @override
  @JsonKey(name: "short_name")
  final String shortName;

  /// Create a copy of DocNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DocNoteBodyCopyWith<_DocNoteBody> get copyWith =>
      __$DocNoteBodyCopyWithImpl<_DocNoteBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DocNoteBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DocNoteBody &&
            (identical(other.noteId, noteId) || other.noteId == noteId) &&
            (identical(other.dailynoteDate, dailynoteDate) ||
                other.dailynoteDate == dailynoteDate) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, noteId, dailynoteDate, shortName);

  @override
  String toString() {
    return 'DocNoteBody(noteId: $noteId, dailynoteDate: $dailynoteDate, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$DocNoteBodyCopyWith<$Res>
    implements $DocNoteBodyCopyWith<$Res> {
  factory _$DocNoteBodyCopyWith(
          _DocNoteBody value, $Res Function(_DocNoteBody) _then) =
      __$DocNoteBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "note_id") String noteId,
      @JsonKey(name: "dailynote_date") String? dailynoteDate,
      @JsonKey(name: "short_name") String shortName});
}

/// @nodoc
class __$DocNoteBodyCopyWithImpl<$Res> implements _$DocNoteBodyCopyWith<$Res> {
  __$DocNoteBodyCopyWithImpl(this._self, this._then);

  final _DocNoteBody _self;
  final $Res Function(_DocNoteBody) _then;

  /// Create a copy of DocNoteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? noteId = null,
    Object? dailynoteDate = freezed,
    Object? shortName = null,
  }) {
    return _then(_DocNoteBody(
      noteId: null == noteId
          ? _self.noteId
          : noteId // ignore: cast_nullable_to_non_nullable
              as String,
      dailynoteDate: freezed == dailynoteDate
          ? _self.dailynoteDate
          : dailynoteDate // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
