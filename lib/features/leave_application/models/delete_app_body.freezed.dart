// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_app_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeleteAppBody {
  @JsonKey(name: 'leave_app_id')
  String get leaveAppId;
  @JsonKey(name: 'short_name')
  String get shortName;
  String? get operation;

  /// Create a copy of DeleteAppBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeleteAppBodyCopyWith<DeleteAppBody> get copyWith =>
      _$DeleteAppBodyCopyWithImpl<DeleteAppBody>(
          this as DeleteAppBody, _$identity);

  /// Serializes this DeleteAppBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeleteAppBody &&
            (identical(other.leaveAppId, leaveAppId) ||
                other.leaveAppId == leaveAppId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.operation, operation) ||
                other.operation == operation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, leaveAppId, shortName, operation);

  @override
  String toString() {
    return 'DeleteAppBody(leaveAppId: $leaveAppId, shortName: $shortName, operation: $operation)';
  }
}

/// @nodoc
abstract mixin class $DeleteAppBodyCopyWith<$Res> {
  factory $DeleteAppBodyCopyWith(
          DeleteAppBody value, $Res Function(DeleteAppBody) _then) =
      _$DeleteAppBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'leave_app_id') String leaveAppId,
      @JsonKey(name: 'short_name') String shortName,
      String? operation});
}

/// @nodoc
class _$DeleteAppBodyCopyWithImpl<$Res>
    implements $DeleteAppBodyCopyWith<$Res> {
  _$DeleteAppBodyCopyWithImpl(this._self, this._then);

  final DeleteAppBody _self;
  final $Res Function(DeleteAppBody) _then;

  /// Create a copy of DeleteAppBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveAppId = null,
    Object? shortName = null,
    Object? operation = freezed,
  }) {
    return _then(_self.copyWith(
      leaveAppId: null == leaveAppId
          ? _self.leaveAppId
          : leaveAppId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DeleteAppBody].
extension DeleteAppBodyPatterns on DeleteAppBody {
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
    TResult Function(_DeleteAppBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeleteAppBody() when $default != null:
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
    TResult Function(_DeleteAppBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteAppBody():
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
    TResult? Function(_DeleteAppBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteAppBody() when $default != null:
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
    TResult Function(@JsonKey(name: 'leave_app_id') String leaveAppId,
            @JsonKey(name: 'short_name') String shortName, String? operation)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeleteAppBody() when $default != null:
        return $default(_that.leaveAppId, _that.shortName, _that.operation);
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
    TResult Function(@JsonKey(name: 'leave_app_id') String leaveAppId,
            @JsonKey(name: 'short_name') String shortName, String? operation)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteAppBody():
        return $default(_that.leaveAppId, _that.shortName, _that.operation);
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
    TResult? Function(@JsonKey(name: 'leave_app_id') String leaveAppId,
            @JsonKey(name: 'short_name') String shortName, String? operation)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteAppBody() when $default != null:
        return $default(_that.leaveAppId, _that.shortName, _that.operation);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DeleteAppBody implements DeleteAppBody {
  const _DeleteAppBody(
      {@JsonKey(name: 'leave_app_id') required this.leaveAppId,
      @JsonKey(name: 'short_name') required this.shortName,
      this.operation = 'delete'});
  factory _DeleteAppBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteAppBodyFromJson(json);

  @override
  @JsonKey(name: 'leave_app_id')
  final String leaveAppId;
  @override
  @JsonKey(name: 'short_name')
  final String shortName;
  @override
  @JsonKey()
  final String? operation;

  /// Create a copy of DeleteAppBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeleteAppBodyCopyWith<_DeleteAppBody> get copyWith =>
      __$DeleteAppBodyCopyWithImpl<_DeleteAppBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DeleteAppBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeleteAppBody &&
            (identical(other.leaveAppId, leaveAppId) ||
                other.leaveAppId == leaveAppId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.operation, operation) ||
                other.operation == operation));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, leaveAppId, shortName, operation);

  @override
  String toString() {
    return 'DeleteAppBody(leaveAppId: $leaveAppId, shortName: $shortName, operation: $operation)';
  }
}

/// @nodoc
abstract mixin class _$DeleteAppBodyCopyWith<$Res>
    implements $DeleteAppBodyCopyWith<$Res> {
  factory _$DeleteAppBodyCopyWith(
          _DeleteAppBody value, $Res Function(_DeleteAppBody) _then) =
      __$DeleteAppBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'leave_app_id') String leaveAppId,
      @JsonKey(name: 'short_name') String shortName,
      String? operation});
}

/// @nodoc
class __$DeleteAppBodyCopyWithImpl<$Res>
    implements _$DeleteAppBodyCopyWith<$Res> {
  __$DeleteAppBodyCopyWithImpl(this._self, this._then);

  final _DeleteAppBody _self;
  final $Res Function(_DeleteAppBody) _then;

  /// Create a copy of DeleteAppBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? leaveAppId = null,
    Object? shortName = null,
    Object? operation = freezed,
  }) {
    return _then(_DeleteAppBody(
      leaveAppId: null == leaveAppId
          ? _self.leaveAppId
          : leaveAppId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
