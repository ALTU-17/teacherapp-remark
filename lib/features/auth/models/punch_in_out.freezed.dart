// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'punch_in_out.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PunchInOut {
  @HiveField(0)
  @JsonKey(name: "employee_id")
  String? get employeeId;
  @HiveField(1)
  @JsonKey(name: "date_part")
  String? get datePart;
  @HiveField(2)
  @JsonKey(name: "punch_in_time")
  String? get punchInTime;
  @HiveField(3)
  @JsonKey(name: "punch_out_time")
  String? get punchOutTime;
  @HiveField(4)
  @JsonKey(name: "name")
  String? get name;

  /// Create a copy of PunchInOut
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PunchInOutCopyWith<PunchInOut> get copyWith =>
      _$PunchInOutCopyWithImpl<PunchInOut>(this as PunchInOut, _$identity);

  /// Serializes this PunchInOut to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PunchInOut &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.datePart, datePart) ||
                other.datePart == datePart) &&
            (identical(other.punchInTime, punchInTime) ||
                other.punchInTime == punchInTime) &&
            (identical(other.punchOutTime, punchOutTime) ||
                other.punchOutTime == punchOutTime) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, employeeId, datePart, punchInTime, punchOutTime, name);

  @override
  String toString() {
    return 'PunchInOut(employeeId: $employeeId, datePart: $datePart, punchInTime: $punchInTime, punchOutTime: $punchOutTime, name: $name)';
  }
}

/// @nodoc
abstract mixin class $PunchInOutCopyWith<$Res> {
  factory $PunchInOutCopyWith(
          PunchInOut value, $Res Function(PunchInOut) _then) =
      _$PunchInOutCopyWithImpl;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: "employee_id") String? employeeId,
      @HiveField(1) @JsonKey(name: "date_part") String? datePart,
      @HiveField(2) @JsonKey(name: "punch_in_time") String? punchInTime,
      @HiveField(3) @JsonKey(name: "punch_out_time") String? punchOutTime,
      @HiveField(4) @JsonKey(name: "name") String? name});
}

/// @nodoc
class _$PunchInOutCopyWithImpl<$Res> implements $PunchInOutCopyWith<$Res> {
  _$PunchInOutCopyWithImpl(this._self, this._then);

  final PunchInOut _self;
  final $Res Function(PunchInOut) _then;

  /// Create a copy of PunchInOut
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employeeId = freezed,
    Object? datePart = freezed,
    Object? punchInTime = freezed,
    Object? punchOutTime = freezed,
    Object? name = freezed,
  }) {
    return _then(_self.copyWith(
      employeeId: freezed == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      datePart: freezed == datePart
          ? _self.datePart
          : datePart // ignore: cast_nullable_to_non_nullable
              as String?,
      punchInTime: freezed == punchInTime
          ? _self.punchInTime
          : punchInTime // ignore: cast_nullable_to_non_nullable
              as String?,
      punchOutTime: freezed == punchOutTime
          ? _self.punchOutTime
          : punchOutTime // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PunchInOut].
extension PunchInOutPatterns on PunchInOut {
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
    TResult Function(_PunchInOut value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PunchInOut() when $default != null:
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
    TResult Function(_PunchInOut value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PunchInOut():
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
    TResult? Function(_PunchInOut value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PunchInOut() when $default != null:
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
            @HiveField(0) @JsonKey(name: "employee_id") String? employeeId,
            @HiveField(1) @JsonKey(name: "date_part") String? datePart,
            @HiveField(2) @JsonKey(name: "punch_in_time") String? punchInTime,
            @HiveField(3) @JsonKey(name: "punch_out_time") String? punchOutTime,
            @HiveField(4) @JsonKey(name: "name") String? name)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PunchInOut() when $default != null:
        return $default(_that.employeeId, _that.datePart, _that.punchInTime,
            _that.punchOutTime, _that.name);
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
            @HiveField(0) @JsonKey(name: "employee_id") String? employeeId,
            @HiveField(1) @JsonKey(name: "date_part") String? datePart,
            @HiveField(2) @JsonKey(name: "punch_in_time") String? punchInTime,
            @HiveField(3) @JsonKey(name: "punch_out_time") String? punchOutTime,
            @HiveField(4) @JsonKey(name: "name") String? name)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PunchInOut():
        return $default(_that.employeeId, _that.datePart, _that.punchInTime,
            _that.punchOutTime, _that.name);
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
            @HiveField(0) @JsonKey(name: "employee_id") String? employeeId,
            @HiveField(1) @JsonKey(name: "date_part") String? datePart,
            @HiveField(2) @JsonKey(name: "punch_in_time") String? punchInTime,
            @HiveField(3) @JsonKey(name: "punch_out_time") String? punchOutTime,
            @HiveField(4) @JsonKey(name: "name") String? name)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PunchInOut() when $default != null:
        return $default(_that.employeeId, _that.datePart, _that.punchInTime,
            _that.punchOutTime, _that.name);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 4, adapterName: 'PunchInOutAdapter')
class _PunchInOut implements PunchInOut {
  const _PunchInOut(
      {@HiveField(0) @JsonKey(name: "employee_id") this.employeeId,
      @HiveField(1) @JsonKey(name: "date_part") this.datePart,
      @HiveField(2) @JsonKey(name: "punch_in_time") this.punchInTime,
      @HiveField(3) @JsonKey(name: "punch_out_time") this.punchOutTime,
      @HiveField(4) @JsonKey(name: "name") this.name});
  factory _PunchInOut.fromJson(Map<String, dynamic> json) =>
      _$PunchInOutFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: "employee_id")
  final String? employeeId;
  @override
  @HiveField(1)
  @JsonKey(name: "date_part")
  final String? datePart;
  @override
  @HiveField(2)
  @JsonKey(name: "punch_in_time")
  final String? punchInTime;
  @override
  @HiveField(3)
  @JsonKey(name: "punch_out_time")
  final String? punchOutTime;
  @override
  @HiveField(4)
  @JsonKey(name: "name")
  final String? name;

  /// Create a copy of PunchInOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PunchInOutCopyWith<_PunchInOut> get copyWith =>
      __$PunchInOutCopyWithImpl<_PunchInOut>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$PunchInOutToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PunchInOut &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.datePart, datePart) ||
                other.datePart == datePart) &&
            (identical(other.punchInTime, punchInTime) ||
                other.punchInTime == punchInTime) &&
            (identical(other.punchOutTime, punchOutTime) ||
                other.punchOutTime == punchOutTime) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, employeeId, datePart, punchInTime, punchOutTime, name);

  @override
  String toString() {
    return 'PunchInOut(employeeId: $employeeId, datePart: $datePart, punchInTime: $punchInTime, punchOutTime: $punchOutTime, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$PunchInOutCopyWith<$Res>
    implements $PunchInOutCopyWith<$Res> {
  factory _$PunchInOutCopyWith(
          _PunchInOut value, $Res Function(_PunchInOut) _then) =
      __$PunchInOutCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: "employee_id") String? employeeId,
      @HiveField(1) @JsonKey(name: "date_part") String? datePart,
      @HiveField(2) @JsonKey(name: "punch_in_time") String? punchInTime,
      @HiveField(3) @JsonKey(name: "punch_out_time") String? punchOutTime,
      @HiveField(4) @JsonKey(name: "name") String? name});
}

/// @nodoc
class __$PunchInOutCopyWithImpl<$Res> implements _$PunchInOutCopyWith<$Res> {
  __$PunchInOutCopyWithImpl(this._self, this._then);

  final _PunchInOut _self;
  final $Res Function(_PunchInOut) _then;

  /// Create a copy of PunchInOut
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? employeeId = freezed,
    Object? datePart = freezed,
    Object? punchInTime = freezed,
    Object? punchOutTime = freezed,
    Object? name = freezed,
  }) {
    return _then(_PunchInOut(
      employeeId: freezed == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      datePart: freezed == datePart
          ? _self.datePart
          : datePart // ignore: cast_nullable_to_non_nullable
              as String?,
      punchInTime: freezed == punchInTime
          ? _self.punchInTime
          : punchInTime // ignore: cast_nullable_to_non_nullable
              as String?,
      punchOutTime: freezed == punchOutTime
          ? _self.punchOutTime
          : punchOutTime // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
