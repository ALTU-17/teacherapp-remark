// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_publish_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeworkPublishBody {
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "publish")
  String? get publish;
  @JsonKey(name: "operation")
  String? get operation;
  @JsonKey(name: "login_type")
  String? get loginType;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "section_id")
  String? get sectionId;
  @JsonKey(name: "short_name")
  String? get shortName;

  /// Create a copy of HomeworkPublishBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeworkPublishBodyCopyWith<HomeworkPublishBody> get copyWith =>
      _$HomeworkPublishBodyCopyWithImpl<HomeworkPublishBody>(
          this as HomeworkPublishBody, _$identity);

  /// Serializes this HomeworkPublishBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeworkPublishBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, publish, operation,
      loginType, classId, sectionId, shortName);

  @override
  String toString() {
    return 'HomeworkPublishBody(homeworkId: $homeworkId, publish: $publish, operation: $operation, loginType: $loginType, classId: $classId, sectionId: $sectionId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $HomeworkPublishBodyCopyWith<$Res> {
  factory $HomeworkPublishBodyCopyWith(
          HomeworkPublishBody value, $Res Function(HomeworkPublishBody) _then) =
      _$HomeworkPublishBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "short_name") String? shortName});
}

/// @nodoc
class _$HomeworkPublishBodyCopyWithImpl<$Res>
    implements $HomeworkPublishBodyCopyWith<$Res> {
  _$HomeworkPublishBodyCopyWithImpl(this._self, this._then);

  final HomeworkPublishBody _self;
  final $Res Function(HomeworkPublishBody) _then;

  /// Create a copy of HomeworkPublishBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeworkId = freezed,
    Object? publish = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_self.copyWith(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeworkPublishBody].
extension HomeworkPublishBodyPatterns on HomeworkPublishBody {
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
    TResult Function(_HomeworkPublishBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkPublishBody() when $default != null:
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
    TResult Function(_HomeworkPublishBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkPublishBody():
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
    TResult? Function(_HomeworkPublishBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkPublishBody() when $default != null:
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "short_name") String? shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeworkPublishBody() when $default != null:
        return $default(_that.homeworkId, _that.publish, _that.operation,
            _that.loginType, _that.classId, _that.sectionId, _that.shortName);
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "short_name") String? shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkPublishBody():
        return $default(_that.homeworkId, _that.publish, _that.operation,
            _that.loginType, _that.classId, _that.sectionId, _that.shortName);
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "publish") String? publish,
            @JsonKey(name: "operation") String? operation,
            @JsonKey(name: "login_type") String? loginType,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "short_name") String? shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeworkPublishBody() when $default != null:
        return $default(_that.homeworkId, _that.publish, _that.operation,
            _that.loginType, _that.classId, _that.sectionId, _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeworkPublishBody implements HomeworkPublishBody {
  const _HomeworkPublishBody(
      {@JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "publish") this.publish,
      @JsonKey(name: "operation") this.operation = 'publish',
      @JsonKey(name: "login_type") this.loginType,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "section_id") this.sectionId,
      @JsonKey(name: "short_name") this.shortName});
  factory _HomeworkPublishBody.fromJson(Map<String, dynamic> json) =>
      _$HomeworkPublishBodyFromJson(json);

  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "publish")
  final String? publish;
  @override
  @JsonKey(name: "operation")
  final String? operation;
  @override
  @JsonKey(name: "login_type")
  final String? loginType;
  @override
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "section_id")
  final String? sectionId;
  @override
  @JsonKey(name: "short_name")
  final String? shortName;

  /// Create a copy of HomeworkPublishBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeworkPublishBodyCopyWith<_HomeworkPublishBody> get copyWith =>
      __$HomeworkPublishBodyCopyWithImpl<_HomeworkPublishBody>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeworkPublishBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeworkPublishBody &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.publish, publish) || other.publish == publish) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, publish, operation,
      loginType, classId, sectionId, shortName);

  @override
  String toString() {
    return 'HomeworkPublishBody(homeworkId: $homeworkId, publish: $publish, operation: $operation, loginType: $loginType, classId: $classId, sectionId: $sectionId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$HomeworkPublishBodyCopyWith<$Res>
    implements $HomeworkPublishBodyCopyWith<$Res> {
  factory _$HomeworkPublishBodyCopyWith(_HomeworkPublishBody value,
          $Res Function(_HomeworkPublishBody) _then) =
      __$HomeworkPublishBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "publish") String? publish,
      @JsonKey(name: "operation") String? operation,
      @JsonKey(name: "login_type") String? loginType,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "short_name") String? shortName});
}

/// @nodoc
class __$HomeworkPublishBodyCopyWithImpl<$Res>
    implements _$HomeworkPublishBodyCopyWith<$Res> {
  __$HomeworkPublishBodyCopyWithImpl(this._self, this._then);

  final _HomeworkPublishBody _self;
  final $Res Function(_HomeworkPublishBody) _then;

  /// Create a copy of HomeworkPublishBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeworkId = freezed,
    Object? publish = freezed,
    Object? operation = freezed,
    Object? loginType = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_HomeworkPublishBody(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      publish: freezed == publish
          ? _self.publish
          : publish // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      loginType: freezed == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
