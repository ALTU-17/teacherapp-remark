// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doc_homework_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocHomeworkBody {
  @JsonKey(name: "homework_id")
  String get homeworkId;
  @JsonKey(name: "homework_date")
  String get homeworkDate;
  @JsonKey(name: "short_name")
  String get shortName;

  /// Create a copy of DocHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DocHomeworkBodyCopyWith<DocHomeworkBody> get copyWith =>
      _$DocHomeworkBodyCopyWithImpl<DocHomeworkBody>(
          this as DocHomeworkBody, _$identity);

  /// Serializes this DocHomeworkBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DocHomeworkBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.homeworkDate, homeworkDate) ||
                other.homeworkDate == homeworkDate) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, homeworkId, homeworkDate, shortName);

  @override
  String toString() {
    return 'DocHomeworkBody(homeworkId: $homeworkId, homeworkDate: $homeworkDate, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $DocHomeworkBodyCopyWith<$Res> {
  factory $DocHomeworkBodyCopyWith(
          DocHomeworkBody value, $Res Function(DocHomeworkBody) _then) =
      _$DocHomeworkBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String homeworkId,
      @JsonKey(name: "homework_date") String homeworkDate,
      @JsonKey(name: "short_name") String shortName});
}

/// @nodoc
class _$DocHomeworkBodyCopyWithImpl<$Res>
    implements $DocHomeworkBodyCopyWith<$Res> {
  _$DocHomeworkBodyCopyWithImpl(this._self, this._then);

  final DocHomeworkBody _self;
  final $Res Function(DocHomeworkBody) _then;

  /// Create a copy of DocHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeworkId = null,
    Object? homeworkDate = null,
    Object? shortName = null,
  }) {
    return _then(_self.copyWith(
      homeworkId: null == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String,
      homeworkDate: null == homeworkDate
          ? _self.homeworkDate
          : homeworkDate // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [DocHomeworkBody].
extension DocHomeworkBodyPatterns on DocHomeworkBody {
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
    TResult Function(_DocHomeworkBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocHomeworkBody() when $default != null:
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
    TResult Function(_DocHomeworkBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomeworkBody():
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
    TResult? Function(_DocHomeworkBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomeworkBody() when $default != null:
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
            @JsonKey(name: "homework_id") String homeworkId,
            @JsonKey(name: "homework_date") String homeworkDate,
            @JsonKey(name: "short_name") String shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocHomeworkBody() when $default != null:
        return $default(_that.homeworkId, _that.homeworkDate, _that.shortName);
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
            @JsonKey(name: "homework_id") String homeworkId,
            @JsonKey(name: "homework_date") String homeworkDate,
            @JsonKey(name: "short_name") String shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomeworkBody():
        return $default(_that.homeworkId, _that.homeworkDate, _that.shortName);
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
            @JsonKey(name: "homework_id") String homeworkId,
            @JsonKey(name: "homework_date") String homeworkDate,
            @JsonKey(name: "short_name") String shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomeworkBody() when $default != null:
        return $default(_that.homeworkId, _that.homeworkDate, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DocHomeworkBody implements DocHomeworkBody {
  const _DocHomeworkBody(
      {@JsonKey(name: "homework_id") required this.homeworkId,
      @JsonKey(name: "homework_date") required this.homeworkDate,
      @JsonKey(name: "short_name") required this.shortName});
  factory _DocHomeworkBody.fromJson(Map<String, dynamic> json) =>
      _$DocHomeworkBodyFromJson(json);

  @override
  @JsonKey(name: "homework_id")
  final String homeworkId;
  @override
  @JsonKey(name: "homework_date")
  final String homeworkDate;
  @override
  @JsonKey(name: "short_name")
  final String shortName;

  /// Create a copy of DocHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DocHomeworkBodyCopyWith<_DocHomeworkBody> get copyWith =>
      __$DocHomeworkBodyCopyWithImpl<_DocHomeworkBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DocHomeworkBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DocHomeworkBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.homeworkDate, homeworkDate) ||
                other.homeworkDate == homeworkDate) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, homeworkId, homeworkDate, shortName);

  @override
  String toString() {
    return 'DocHomeworkBody(homeworkId: $homeworkId, homeworkDate: $homeworkDate, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$DocHomeworkBodyCopyWith<$Res>
    implements $DocHomeworkBodyCopyWith<$Res> {
  factory _$DocHomeworkBodyCopyWith(
          _DocHomeworkBody value, $Res Function(_DocHomeworkBody) _then) =
      __$DocHomeworkBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String homeworkId,
      @JsonKey(name: "homework_date") String homeworkDate,
      @JsonKey(name: "short_name") String shortName});
}

/// @nodoc
class __$DocHomeworkBodyCopyWithImpl<$Res>
    implements _$DocHomeworkBodyCopyWith<$Res> {
  __$DocHomeworkBodyCopyWithImpl(this._self, this._then);

  final _DocHomeworkBody _self;
  final $Res Function(_DocHomeworkBody) _then;

  /// Create a copy of DocHomeworkBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeworkId = null,
    Object? homeworkDate = null,
    Object? shortName = null,
  }) {
    return _then(_DocHomeworkBody(
      homeworkId: null == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String,
      homeworkDate: null == homeworkDate
          ? _self.homeworkDate
          : homeworkDate // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
