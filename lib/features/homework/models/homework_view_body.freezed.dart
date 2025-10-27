// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_view_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomeWorkViewBody {
  @JsonKey(name: "short_name")
  String? get shortName;
  @JsonKey(name: "acd_yr")
  String? get acdYr;
  @JsonKey(name: "class_id")
  String? get classId;
  @JsonKey(name: "section_id")
  String? get sectionId;
  @JsonKey(name: "homework_id")
  String? get homeworkId;

  /// Create a copy of HomeWorkViewBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomeWorkViewBodyCopyWith<HomeWorkViewBody> get copyWith =>
      _$HomeWorkViewBodyCopyWithImpl<HomeWorkViewBody>(
          this as HomeWorkViewBody, _$identity);

  /// Serializes this HomeWorkViewBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomeWorkViewBody &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, shortName, acdYr, classId, sectionId, homeworkId);

  @override
  String toString() {
    return 'HomeWorkViewBody(shortName: $shortName, acdYr: $acdYr, classId: $classId, sectionId: $sectionId, homeworkId: $homeworkId)';
  }
}

/// @nodoc
abstract mixin class $HomeWorkViewBodyCopyWith<$Res> {
  factory $HomeWorkViewBodyCopyWith(
          HomeWorkViewBody value, $Res Function(HomeWorkViewBody) _then) =
      _$HomeWorkViewBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "acd_yr") String? acdYr,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "homework_id") String? homeworkId});
}

/// @nodoc
class _$HomeWorkViewBodyCopyWithImpl<$Res>
    implements $HomeWorkViewBodyCopyWith<$Res> {
  _$HomeWorkViewBodyCopyWithImpl(this._self, this._then);

  final HomeWorkViewBody _self;
  final $Res Function(HomeWorkViewBody) _then;

  /// Create a copy of HomeWorkViewBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = freezed,
    Object? acdYr = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? homeworkId = freezed,
  }) {
    return _then(_self.copyWith(
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HomeWorkViewBody].
extension HomeWorkViewBodyPatterns on HomeWorkViewBody {
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
    TResult Function(_HomeWorkViewBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeWorkViewBody() when $default != null:
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
    TResult Function(_HomeWorkViewBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeWorkViewBody():
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
    TResult? Function(_HomeWorkViewBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeWorkViewBody() when $default != null:
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
            @JsonKey(name: "acd_yr") String? acdYr,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "homework_id") String? homeworkId)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HomeWorkViewBody() when $default != null:
        return $default(_that.shortName, _that.acdYr, _that.classId,
            _that.sectionId, _that.homeworkId);
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
            @JsonKey(name: "acd_yr") String? acdYr,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "homework_id") String? homeworkId)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeWorkViewBody():
        return $default(_that.shortName, _that.acdYr, _that.classId,
            _that.sectionId, _that.homeworkId);
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
            @JsonKey(name: "acd_yr") String? acdYr,
            @JsonKey(name: "class_id") String? classId,
            @JsonKey(name: "section_id") String? sectionId,
            @JsonKey(name: "homework_id") String? homeworkId)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HomeWorkViewBody() when $default != null:
        return $default(_that.shortName, _that.acdYr, _that.classId,
            _that.sectionId, _that.homeworkId);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _HomeWorkViewBody implements HomeWorkViewBody {
  const _HomeWorkViewBody(
      {@JsonKey(name: "short_name") this.shortName,
      @JsonKey(name: "acd_yr") this.acdYr,
      @JsonKey(name: "class_id") this.classId,
      @JsonKey(name: "section_id") this.sectionId,
      @JsonKey(name: "homework_id") this.homeworkId});
  factory _HomeWorkViewBody.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkViewBodyFromJson(json);

  @override
  @JsonKey(name: "short_name")
  final String? shortName;
  @override
  @JsonKey(name: "acd_yr")
  final String? acdYr;
  @override
  @JsonKey(name: "class_id")
  final String? classId;
  @override
  @JsonKey(name: "section_id")
  final String? sectionId;
  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;

  /// Create a copy of HomeWorkViewBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomeWorkViewBodyCopyWith<_HomeWorkViewBody> get copyWith =>
      __$HomeWorkViewBodyCopyWithImpl<_HomeWorkViewBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$HomeWorkViewBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomeWorkViewBody &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, shortName, acdYr, classId, sectionId, homeworkId);

  @override
  String toString() {
    return 'HomeWorkViewBody(shortName: $shortName, acdYr: $acdYr, classId: $classId, sectionId: $sectionId, homeworkId: $homeworkId)';
  }
}

/// @nodoc
abstract mixin class _$HomeWorkViewBodyCopyWith<$Res>
    implements $HomeWorkViewBodyCopyWith<$Res> {
  factory _$HomeWorkViewBodyCopyWith(
          _HomeWorkViewBody value, $Res Function(_HomeWorkViewBody) _then) =
      __$HomeWorkViewBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "acd_yr") String? acdYr,
      @JsonKey(name: "class_id") String? classId,
      @JsonKey(name: "section_id") String? sectionId,
      @JsonKey(name: "homework_id") String? homeworkId});
}

/// @nodoc
class __$HomeWorkViewBodyCopyWithImpl<$Res>
    implements _$HomeWorkViewBodyCopyWith<$Res> {
  __$HomeWorkViewBodyCopyWithImpl(this._self, this._then);

  final _HomeWorkViewBody _self;
  final $Res Function(_HomeWorkViewBody) _then;

  /// Create a copy of HomeWorkViewBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shortName = freezed,
    Object? acdYr = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? homeworkId = freezed,
  }) {
    return _then(_HomeWorkViewBody(
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
