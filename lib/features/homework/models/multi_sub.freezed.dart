// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multi_sub.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MultiSub {
  @JsonKey(name: "sm_id")
  String? get id;
  @JsonKey(name: "name")
  String? get name;

  /// Create a copy of MultiSub
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MultiSubCopyWith<MultiSub> get copyWith =>
      _$MultiSubCopyWithImpl<MultiSub>(this as MultiSub, _$identity);

  /// Serializes this MultiSub to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MultiSub &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'MultiSub(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class $MultiSubCopyWith<$Res> {
  factory $MultiSubCopyWith(MultiSub value, $Res Function(MultiSub) _then) =
      _$MultiSubCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "sm_id") String? id,
      @JsonKey(name: "name") String? name});
}

/// @nodoc
class _$MultiSubCopyWithImpl<$Res> implements $MultiSubCopyWith<$Res> {
  _$MultiSubCopyWithImpl(this._self, this._then);

  final MultiSub _self;
  final $Res Function(MultiSub) _then;

  /// Create a copy of MultiSub
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MultiSub].
extension MultiSubPatterns on MultiSub {
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
    TResult Function(_MultiSub value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MultiSub() when $default != null:
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
    TResult Function(_MultiSub value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSub():
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
    TResult? Function(_MultiSub value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSub() when $default != null:
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
    TResult Function(@JsonKey(name: "sm_id") String? id,
            @JsonKey(name: "name") String? name)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MultiSub() when $default != null:
        return $default(_that.id, _that.name);
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
    TResult Function(@JsonKey(name: "sm_id") String? id,
            @JsonKey(name: "name") String? name)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSub():
        return $default(_that.id, _that.name);
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
    TResult? Function(@JsonKey(name: "sm_id") String? id,
            @JsonKey(name: "name") String? name)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MultiSub() when $default != null:
        return $default(_that.id, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MultiSub implements MultiSub {
  const _MultiSub(
      {@JsonKey(name: "sm_id") this.id, @JsonKey(name: "name") this.name});
  factory _MultiSub.fromJson(Map<String, dynamic> json) =>
      _$MultiSubFromJson(json);

  @override
  @JsonKey(name: "sm_id")
  final String? id;
  @override
  @JsonKey(name: "name")
  final String? name;

  /// Create a copy of MultiSub
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MultiSubCopyWith<_MultiSub> get copyWith =>
      __$MultiSubCopyWithImpl<_MultiSub>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MultiSubToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MultiSub &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @override
  String toString() {
    return 'MultiSub(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$MultiSubCopyWith<$Res>
    implements $MultiSubCopyWith<$Res> {
  factory _$MultiSubCopyWith(_MultiSub value, $Res Function(_MultiSub) _then) =
      __$MultiSubCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "sm_id") String? id,
      @JsonKey(name: "name") String? name});
}

/// @nodoc
class __$MultiSubCopyWithImpl<$Res> implements _$MultiSubCopyWith<$Res> {
  __$MultiSubCopyWithImpl(this._self, this._then);

  final _MultiSub _self;
  final $Res Function(_MultiSub) _then;

  /// Create a copy of MultiSub
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_MultiSub(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
