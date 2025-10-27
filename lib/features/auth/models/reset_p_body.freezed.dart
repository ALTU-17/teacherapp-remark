// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_p_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResetPBody {
  @JsonKey(name: "short_name")
  String? get shortName;
  @JsonKey(name: "user_id")
  String? get userId;
  @JsonKey(name: "answer_one")
  String? get answerOne;
  @JsonKey(name: "dob")
  String? get dob;
  @JsonKey(name: "role_id")
  String? get roleID;

  /// Create a copy of ResetPBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ResetPBodyCopyWith<ResetPBody> get copyWith =>
      _$ResetPBodyCopyWithImpl<ResetPBody>(this as ResetPBody, _$identity);

  /// Serializes this ResetPBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ResetPBody &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.answerOne, answerOne) ||
                other.answerOne == answerOne) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.roleID, roleID) || other.roleID == roleID));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, shortName, userId, answerOne, dob, roleID);

  @override
  String toString() {
    return 'ResetPBody(shortName: $shortName, userId: $userId, answerOne: $answerOne, dob: $dob, roleID: $roleID)';
  }
}

/// @nodoc
abstract mixin class $ResetPBodyCopyWith<$Res> {
  factory $ResetPBodyCopyWith(
          ResetPBody value, $Res Function(ResetPBody) _then) =
      _$ResetPBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "user_id") String? userId,
      @JsonKey(name: "answer_one") String? answerOne,
      @JsonKey(name: "dob") String? dob,
      @JsonKey(name: "role_id") String? roleID});
}

/// @nodoc
class _$ResetPBodyCopyWithImpl<$Res> implements $ResetPBodyCopyWith<$Res> {
  _$ResetPBodyCopyWithImpl(this._self, this._then);

  final ResetPBody _self;
  final $Res Function(ResetPBody) _then;

  /// Create a copy of ResetPBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = freezed,
    Object? userId = freezed,
    Object? answerOne = freezed,
    Object? dob = freezed,
    Object? roleID = freezed,
  }) {
    return _then(_self.copyWith(
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      answerOne: freezed == answerOne
          ? _self.answerOne
          : answerOne // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      roleID: freezed == roleID
          ? _self.roleID
          : roleID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ResetPBody].
extension ResetPBodyPatterns on ResetPBody {
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
    TResult Function(_ResetPBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ResetPBody() when $default != null:
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
    TResult Function(_ResetPBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ResetPBody():
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
    TResult? Function(_ResetPBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ResetPBody() when $default != null:
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
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "user_id") String? userId,
            @JsonKey(name: "answer_one") String? answerOne,
            @JsonKey(name: "dob") String? dob,
            @JsonKey(name: "role_id") String? roleID)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ResetPBody() when $default != null:
        return $default(_that.shortName, _that.userId, _that.answerOne,
            _that.dob, _that.roleID);
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
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "user_id") String? userId,
            @JsonKey(name: "answer_one") String? answerOne,
            @JsonKey(name: "dob") String? dob,
            @JsonKey(name: "role_id") String? roleID)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ResetPBody():
        return $default(_that.shortName, _that.userId, _that.answerOne,
            _that.dob, _that.roleID);
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
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "user_id") String? userId,
            @JsonKey(name: "answer_one") String? answerOne,
            @JsonKey(name: "dob") String? dob,
            @JsonKey(name: "role_id") String? roleID)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ResetPBody() when $default != null:
        return $default(_that.shortName, _that.userId, _that.answerOne,
            _that.dob, _that.roleID);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ResetPBody implements ResetPBody {
  const _ResetPBody(
      {@JsonKey(name: "short_name") this.shortName,
      @JsonKey(name: "user_id") this.userId,
      @JsonKey(name: "answer_one") this.answerOne,
      @JsonKey(name: "dob") this.dob,
      @JsonKey(name: "role_id") this.roleID = 'T'});
  factory _ResetPBody.fromJson(Map<String, dynamic> json) =>
      _$ResetPBodyFromJson(json);

  @override
  @JsonKey(name: "short_name")
  final String? shortName;
  @override
  @JsonKey(name: "user_id")
  final String? userId;
  @override
  @JsonKey(name: "answer_one")
  final String? answerOne;
  @override
  @JsonKey(name: "dob")
  final String? dob;
  @override
  @JsonKey(name: "role_id")
  final String? roleID;

  /// Create a copy of ResetPBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ResetPBodyCopyWith<_ResetPBody> get copyWith =>
      __$ResetPBodyCopyWithImpl<_ResetPBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ResetPBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ResetPBody &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.answerOne, answerOne) ||
                other.answerOne == answerOne) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.roleID, roleID) || other.roleID == roleID));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, shortName, userId, answerOne, dob, roleID);

  @override
  String toString() {
    return 'ResetPBody(shortName: $shortName, userId: $userId, answerOne: $answerOne, dob: $dob, roleID: $roleID)';
  }
}

/// @nodoc
abstract mixin class _$ResetPBodyCopyWith<$Res>
    implements $ResetPBodyCopyWith<$Res> {
  factory _$ResetPBodyCopyWith(
          _ResetPBody value, $Res Function(_ResetPBody) _then) =
      __$ResetPBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "user_id") String? userId,
      @JsonKey(name: "answer_one") String? answerOne,
      @JsonKey(name: "dob") String? dob,
      @JsonKey(name: "role_id") String? roleID});
}

/// @nodoc
class __$ResetPBodyCopyWithImpl<$Res> implements _$ResetPBodyCopyWith<$Res> {
  __$ResetPBodyCopyWithImpl(this._self, this._then);

  final _ResetPBody _self;
  final $Res Function(_ResetPBody) _then;

  /// Create a copy of ResetPBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shortName = freezed,
    Object? userId = freezed,
    Object? answerOne = freezed,
    Object? dob = freezed,
    Object? roleID = freezed,
  }) {
    return _then(_ResetPBody(
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      answerOne: freezed == answerOne
          ? _self.answerOne
          : answerOne // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _self.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
      roleID: freezed == roleID
          ? _self.roleID
          : roleID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
