// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_delete_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteDeleteBody {
  @JsonKey(name: 'notes_id')
  String? get notesId;
  String? get operation;
  @JsonKey(name: 'login_type')
  String? get loginType;
  @JsonKey(name: 'short_name')
  String? get shortName;

  /// Create a copy of NoteDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoteDeleteBodyCopyWith<NoteDeleteBody> get copyWith =>
      _$NoteDeleteBodyCopyWithImpl<NoteDeleteBody>(
          this as NoteDeleteBody, _$identity);

  /// Serializes this NoteDeleteBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoteDeleteBody &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, notesId, operation, loginType, shortName);

  @override
  String toString() {
    return 'NoteDeleteBody(notesId: $notesId, operation: $operation, loginType: $loginType, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $NoteDeleteBodyCopyWith<$Res> {
  factory $NoteDeleteBodyCopyWith(
          NoteDeleteBody value, $Res Function(NoteDeleteBody) _then) =
      _$NoteDeleteBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'notes_id') String? notesId,
      String? operation,
      @JsonKey(name: 'login_type') String? loginType,
      @JsonKey(name: 'short_name') String? shortName});
}

/// @nodoc
class _$NoteDeleteBodyCopyWithImpl<$Res>
    implements $NoteDeleteBodyCopyWith<$Res> {
  _$NoteDeleteBodyCopyWithImpl(this._self, this._then);

  final NoteDeleteBody _self;
  final $Res Function(NoteDeleteBody) _then;

  /// Create a copy of NoteDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notesId = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? shortName = freezed,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [NoteDeleteBody].
extension NoteDeleteBodyPatterns on NoteDeleteBody {
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
    TResult Function(_NoteDeleteBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoteDeleteBody() when $default != null:
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
    TResult Function(_NoteDeleteBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteDeleteBody():
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
    TResult? Function(_NoteDeleteBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteDeleteBody() when $default != null:
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
            @JsonKey(name: 'short_name') String? shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NoteDeleteBody() when $default != null:
        return $default(
            _that.notesId, _that.operation, _that.loginType, _that.shortName);
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
            @JsonKey(name: 'short_name') String? shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteDeleteBody():
        return $default(
            _that.notesId, _that.operation, _that.loginType, _that.shortName);
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
            @JsonKey(name: 'short_name') String? shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NoteDeleteBody() when $default != null:
        return $default(
            _that.notesId, _that.operation, _that.loginType, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _NoteDeleteBody implements NoteDeleteBody {
  const _NoteDeleteBody(
      {@JsonKey(name: 'notes_id') this.notesId,
      this.operation = 'delete',
      @JsonKey(name: 'login_type') this.loginType = 'T',
      @JsonKey(name: 'short_name') this.shortName});
  factory _NoteDeleteBody.fromJson(Map<String, dynamic> json) =>
      _$NoteDeleteBodyFromJson(json);

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

  /// Create a copy of NoteDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NoteDeleteBodyCopyWith<_NoteDeleteBody> get copyWith =>
      __$NoteDeleteBodyCopyWithImpl<_NoteDeleteBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$NoteDeleteBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoteDeleteBody &&
            (identical(other.notesId, notesId) || other.notesId == notesId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, notesId, operation, loginType, shortName);

  @override
  String toString() {
    return 'NoteDeleteBody(notesId: $notesId, operation: $operation, loginType: $loginType, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$NoteDeleteBodyCopyWith<$Res>
    implements $NoteDeleteBodyCopyWith<$Res> {
  factory _$NoteDeleteBodyCopyWith(
          _NoteDeleteBody value, $Res Function(_NoteDeleteBody) _then) =
      __$NoteDeleteBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'notes_id') String? notesId,
      String? operation,
      @JsonKey(name: 'login_type') String? loginType,
      @JsonKey(name: 'short_name') String? shortName});
}

/// @nodoc
class __$NoteDeleteBodyCopyWithImpl<$Res>
    implements _$NoteDeleteBodyCopyWith<$Res> {
  __$NoteDeleteBodyCopyWithImpl(this._self, this._then);

  final _NoteDeleteBody _self;
  final $Res Function(_NoteDeleteBody) _then;

  /// Create a copy of NoteDeleteBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? notesId = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_NoteDeleteBody(
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
    ));
  }
}

// dart format on
