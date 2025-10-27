// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_update_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateUpdateBody {
  @JsonKey(name: 'leave_app_id')
  String? get leaveAppId;
  @JsonKey(name: 'leave_type_id')
  String? get leaveTypeId;
  @JsonKey(name: 'start_date')
  String? get startDate;
  @JsonKey(name: 'end_date')
  String? get endDate;
  @JsonKey(name: 'no_of_days')
  String? get noOfDays;
  @JsonKey(name: 'status')
  String? get status;
  @JsonKey(name: 'reason_rejection')
  String? get resonRejection;
  @JsonKey(name: 'staff_id')
  String? get staffId;
  @JsonKey(name: 'acd_yr')
  String? get acdYr;
  @JsonKey(name: 'operation')
  String? get operation; //TODO REMEMBER TO CHANGE TO UPDATE
  @JsonKey(name: 'reason')
  String? get reason;
  @JsonKey(name: 'short_name')
  String? get shortName;

  /// Create a copy of CreateUpdateBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateUpdateBodyCopyWith<CreateUpdateBody> get copyWith =>
      _$CreateUpdateBodyCopyWithImpl<CreateUpdateBody>(
          this as CreateUpdateBody, _$identity);

  /// Serializes this CreateUpdateBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateUpdateBody &&
            (identical(other.leaveAppId, leaveAppId) ||
                other.leaveAppId == leaveAppId) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.noOfDays, noOfDays) ||
                other.noOfDays == noOfDays) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resonRejection, resonRejection) ||
                other.resonRejection == resonRejection) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      leaveAppId,
      leaveTypeId,
      startDate,
      endDate,
      noOfDays,
      status,
      resonRejection,
      staffId,
      acdYr,
      operation,
      reason,
      shortName);

  @override
  String toString() {
    return 'CreateUpdateBody(leaveAppId: $leaveAppId, leaveTypeId: $leaveTypeId, startDate: $startDate, endDate: $endDate, noOfDays: $noOfDays, status: $status, resonRejection: $resonRejection, staffId: $staffId, acdYr: $acdYr, operation: $operation, reason: $reason, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $CreateUpdateBodyCopyWith<$Res> {
  factory $CreateUpdateBodyCopyWith(
          CreateUpdateBody value, $Res Function(CreateUpdateBody) _then) =
      _$CreateUpdateBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'leave_app_id') String? leaveAppId,
      @JsonKey(name: 'leave_type_id') String? leaveTypeId,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'end_date') String? endDate,
      @JsonKey(name: 'no_of_days') String? noOfDays,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'reason_rejection') String? resonRejection,
      @JsonKey(name: 'staff_id') String? staffId,
      @JsonKey(name: 'acd_yr') String? acdYr,
      @JsonKey(name: 'operation') String? operation,
      @JsonKey(name: 'reason') String? reason,
      @JsonKey(name: 'short_name') String? shortName});
}

/// @nodoc
class _$CreateUpdateBodyCopyWithImpl<$Res>
    implements $CreateUpdateBodyCopyWith<$Res> {
  _$CreateUpdateBodyCopyWithImpl(this._self, this._then);

  final CreateUpdateBody _self;
  final $Res Function(CreateUpdateBody) _then;

  /// Create a copy of CreateUpdateBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveAppId = freezed,
    Object? leaveTypeId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? noOfDays = freezed,
    Object? status = freezed,
    Object? resonRejection = freezed,
    Object? staffId = freezed,
    Object? acdYr = freezed,
    Object? operation = freezed,
    Object? reason = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_self.copyWith(
      leaveAppId: freezed == leaveAppId
          ? _self.leaveAppId
          : leaveAppId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveTypeId: freezed == leaveTypeId
          ? _self.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfDays: freezed == noOfDays
          ? _self.noOfDays
          : noOfDays // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      resonRejection: freezed == resonRejection
          ? _self.resonRejection
          : resonRejection // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String?,
      acdYr: freezed == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CreateUpdateBody].
extension CreateUpdateBodyPatterns on CreateUpdateBody {
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
    TResult Function(_CreateUpdateBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateUpdateBody() when $default != null:
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
    TResult Function(_CreateUpdateBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateUpdateBody():
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
    TResult? Function(_CreateUpdateBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateUpdateBody() when $default != null:
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
            @JsonKey(name: 'leave_app_id') String? leaveAppId,
            @JsonKey(name: 'leave_type_id') String? leaveTypeId,
            @JsonKey(name: 'start_date') String? startDate,
            @JsonKey(name: 'end_date') String? endDate,
            @JsonKey(name: 'no_of_days') String? noOfDays,
            @JsonKey(name: 'status') String? status,
            @JsonKey(name: 'reason_rejection') String? resonRejection,
            @JsonKey(name: 'staff_id') String? staffId,
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'operation') String? operation,
            @JsonKey(name: 'reason') String? reason,
            @JsonKey(name: 'short_name') String? shortName)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CreateUpdateBody() when $default != null:
        return $default(
            _that.leaveAppId,
            _that.leaveTypeId,
            _that.startDate,
            _that.endDate,
            _that.noOfDays,
            _that.status,
            _that.resonRejection,
            _that.staffId,
            _that.acdYr,
            _that.operation,
            _that.reason,
            _that.shortName);
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
            @JsonKey(name: 'leave_app_id') String? leaveAppId,
            @JsonKey(name: 'leave_type_id') String? leaveTypeId,
            @JsonKey(name: 'start_date') String? startDate,
            @JsonKey(name: 'end_date') String? endDate,
            @JsonKey(name: 'no_of_days') String? noOfDays,
            @JsonKey(name: 'status') String? status,
            @JsonKey(name: 'reason_rejection') String? resonRejection,
            @JsonKey(name: 'staff_id') String? staffId,
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'operation') String? operation,
            @JsonKey(name: 'reason') String? reason,
            @JsonKey(name: 'short_name') String? shortName)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateUpdateBody():
        return $default(
            _that.leaveAppId,
            _that.leaveTypeId,
            _that.startDate,
            _that.endDate,
            _that.noOfDays,
            _that.status,
            _that.resonRejection,
            _that.staffId,
            _that.acdYr,
            _that.operation,
            _that.reason,
            _that.shortName);
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
            @JsonKey(name: 'leave_app_id') String? leaveAppId,
            @JsonKey(name: 'leave_type_id') String? leaveTypeId,
            @JsonKey(name: 'start_date') String? startDate,
            @JsonKey(name: 'end_date') String? endDate,
            @JsonKey(name: 'no_of_days') String? noOfDays,
            @JsonKey(name: 'status') String? status,
            @JsonKey(name: 'reason_rejection') String? resonRejection,
            @JsonKey(name: 'staff_id') String? staffId,
            @JsonKey(name: 'acd_yr') String? acdYr,
            @JsonKey(name: 'operation') String? operation,
            @JsonKey(name: 'reason') String? reason,
            @JsonKey(name: 'short_name') String? shortName)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CreateUpdateBody() when $default != null:
        return $default(
            _that.leaveAppId,
            _that.leaveTypeId,
            _that.startDate,
            _that.endDate,
            _that.noOfDays,
            _that.status,
            _that.resonRejection,
            _that.staffId,
            _that.acdYr,
            _that.operation,
            _that.reason,
            _that.shortName);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _CreateUpdateBody implements CreateUpdateBody {
  const _CreateUpdateBody(
      {@JsonKey(name: 'leave_app_id') this.leaveAppId,
      @JsonKey(name: 'leave_type_id') this.leaveTypeId,
      @JsonKey(name: 'start_date') this.startDate,
      @JsonKey(name: 'end_date') this.endDate,
      @JsonKey(name: 'no_of_days') this.noOfDays,
      @JsonKey(name: 'status') this.status = 'A',
      @JsonKey(name: 'reason_rejection') this.resonRejection = '',
      @JsonKey(name: 'staff_id') this.staffId,
      @JsonKey(name: 'acd_yr') this.acdYr,
      @JsonKey(name: 'operation') this.operation = 'create',
      @JsonKey(name: 'reason') this.reason,
      @JsonKey(name: 'short_name') this.shortName});
  factory _CreateUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$CreateUpdateBodyFromJson(json);

  @override
  @JsonKey(name: 'leave_app_id')
  final String? leaveAppId;
  @override
  @JsonKey(name: 'leave_type_id')
  final String? leaveTypeId;
  @override
  @JsonKey(name: 'start_date')
  final String? startDate;
  @override
  @JsonKey(name: 'end_date')
  final String? endDate;
  @override
  @JsonKey(name: 'no_of_days')
  final String? noOfDays;
  @override
  @JsonKey(name: 'status')
  final String? status;
  @override
  @JsonKey(name: 'reason_rejection')
  final String? resonRejection;
  @override
  @JsonKey(name: 'staff_id')
  final String? staffId;
  @override
  @JsonKey(name: 'acd_yr')
  final String? acdYr;
  @override
  @JsonKey(name: 'operation')
  final String? operation;
//TODO REMEMBER TO CHANGE TO UPDATE
  @override
  @JsonKey(name: 'reason')
  final String? reason;
  @override
  @JsonKey(name: 'short_name')
  final String? shortName;

  /// Create a copy of CreateUpdateBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateUpdateBodyCopyWith<_CreateUpdateBody> get copyWith =>
      __$CreateUpdateBodyCopyWithImpl<_CreateUpdateBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateUpdateBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateUpdateBody &&
            (identical(other.leaveAppId, leaveAppId) ||
                other.leaveAppId == leaveAppId) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.noOfDays, noOfDays) ||
                other.noOfDays == noOfDays) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resonRejection, resonRejection) ||
                other.resonRejection == resonRejection) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      leaveAppId,
      leaveTypeId,
      startDate,
      endDate,
      noOfDays,
      status,
      resonRejection,
      staffId,
      acdYr,
      operation,
      reason,
      shortName);

  @override
  String toString() {
    return 'CreateUpdateBody(leaveAppId: $leaveAppId, leaveTypeId: $leaveTypeId, startDate: $startDate, endDate: $endDate, noOfDays: $noOfDays, status: $status, resonRejection: $resonRejection, staffId: $staffId, acdYr: $acdYr, operation: $operation, reason: $reason, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$CreateUpdateBodyCopyWith<$Res>
    implements $CreateUpdateBodyCopyWith<$Res> {
  factory _$CreateUpdateBodyCopyWith(
          _CreateUpdateBody value, $Res Function(_CreateUpdateBody) _then) =
      __$CreateUpdateBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'leave_app_id') String? leaveAppId,
      @JsonKey(name: 'leave_type_id') String? leaveTypeId,
      @JsonKey(name: 'start_date') String? startDate,
      @JsonKey(name: 'end_date') String? endDate,
      @JsonKey(name: 'no_of_days') String? noOfDays,
      @JsonKey(name: 'status') String? status,
      @JsonKey(name: 'reason_rejection') String? resonRejection,
      @JsonKey(name: 'staff_id') String? staffId,
      @JsonKey(name: 'acd_yr') String? acdYr,
      @JsonKey(name: 'operation') String? operation,
      @JsonKey(name: 'reason') String? reason,
      @JsonKey(name: 'short_name') String? shortName});
}

/// @nodoc
class __$CreateUpdateBodyCopyWithImpl<$Res>
    implements _$CreateUpdateBodyCopyWith<$Res> {
  __$CreateUpdateBodyCopyWithImpl(this._self, this._then);

  final _CreateUpdateBody _self;
  final $Res Function(_CreateUpdateBody) _then;

  /// Create a copy of CreateUpdateBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? leaveAppId = freezed,
    Object? leaveTypeId = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? noOfDays = freezed,
    Object? status = freezed,
    Object? resonRejection = freezed,
    Object? staffId = freezed,
    Object? acdYr = freezed,
    Object? operation = freezed,
    Object? reason = freezed,
    Object? shortName = freezed,
  }) {
    return _then(_CreateUpdateBody(
      leaveAppId: freezed == leaveAppId
          ? _self.leaveAppId
          : leaveAppId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveTypeId: freezed == leaveTypeId
          ? _self.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      startDate: freezed == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String?,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfDays: freezed == noOfDays
          ? _self.noOfDays
          : noOfDays // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      resonRejection: freezed == resonRejection
          ? _self.resonRejection
          : resonRejection // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String?,
      acdYr: freezed == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
