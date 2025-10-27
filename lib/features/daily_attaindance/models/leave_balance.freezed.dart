// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveBalance {
  @JsonKey(name: "leave_type_id")
  String? get leaveTypeId;
  @JsonKey(name: "name")
  String? get name;
  @JsonKey(name: "staff_id")
  String? get staffId;
  @JsonKey(name: "leaves_allocated")
  String? get leavesAllocated;
  @JsonKey(name: "leaves_availed")
  String? get leavesAvailed;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveBalanceCopyWith<LeaveBalance> get copyWith =>
      _$LeaveBalanceCopyWithImpl<LeaveBalance>(
          this as LeaveBalance, _$identity);

  /// Serializes this LeaveBalance to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveBalance &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.leavesAllocated, leavesAllocated) ||
                other.leavesAllocated == leavesAllocated) &&
            (identical(other.leavesAvailed, leavesAvailed) ||
                other.leavesAvailed == leavesAvailed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, leaveTypeId, name, staffId, leavesAllocated, leavesAvailed);

  @override
  String toString() {
    return 'LeaveBalance(leaveTypeId: $leaveTypeId, name: $name, staffId: $staffId, leavesAllocated: $leavesAllocated, leavesAvailed: $leavesAvailed)';
  }
}

/// @nodoc
abstract mixin class $LeaveBalanceCopyWith<$Res> {
  factory $LeaveBalanceCopyWith(
          LeaveBalance value, $Res Function(LeaveBalance) _then) =
      _$LeaveBalanceCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "leave_type_id") String? leaveTypeId,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "staff_id") String? staffId,
      @JsonKey(name: "leaves_allocated") String? leavesAllocated,
      @JsonKey(name: "leaves_availed") String? leavesAvailed});
}

/// @nodoc
class _$LeaveBalanceCopyWithImpl<$Res> implements $LeaveBalanceCopyWith<$Res> {
  _$LeaveBalanceCopyWithImpl(this._self, this._then);

  final LeaveBalance _self;
  final $Res Function(LeaveBalance) _then;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveTypeId = freezed,
    Object? name = freezed,
    Object? staffId = freezed,
    Object? leavesAllocated = freezed,
    Object? leavesAvailed = freezed,
  }) {
    return _then(_self.copyWith(
      leaveTypeId: freezed == leaveTypeId
          ? _self.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String?,
      leavesAllocated: freezed == leavesAllocated
          ? _self.leavesAllocated
          : leavesAllocated // ignore: cast_nullable_to_non_nullable
              as String?,
      leavesAvailed: freezed == leavesAvailed
          ? _self.leavesAvailed
          : leavesAvailed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveBalance implements LeaveBalance {
  const _LeaveBalance(
      {@JsonKey(name: "leave_type_id") this.leaveTypeId,
      @JsonKey(name: "name") this.name,
      @JsonKey(name: "staff_id") this.staffId,
      @JsonKey(name: "leaves_allocated") this.leavesAllocated,
      @JsonKey(name: "leaves_availed") this.leavesAvailed});
  factory _LeaveBalance.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceFromJson(json);

  @override
  @JsonKey(name: "leave_type_id")
  final String? leaveTypeId;
  @override
  @JsonKey(name: "name")
  final String? name;
  @override
  @JsonKey(name: "staff_id")
  final String? staffId;
  @override
  @JsonKey(name: "leaves_allocated")
  final String? leavesAllocated;
  @override
  @JsonKey(name: "leaves_availed")
  final String? leavesAvailed;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveBalanceCopyWith<_LeaveBalance> get copyWith =>
      __$LeaveBalanceCopyWithImpl<_LeaveBalance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveBalanceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveBalance &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.leavesAllocated, leavesAllocated) ||
                other.leavesAllocated == leavesAllocated) &&
            (identical(other.leavesAvailed, leavesAvailed) ||
                other.leavesAvailed == leavesAvailed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, leaveTypeId, name, staffId, leavesAllocated, leavesAvailed);

  @override
  String toString() {
    return 'LeaveBalance(leaveTypeId: $leaveTypeId, name: $name, staffId: $staffId, leavesAllocated: $leavesAllocated, leavesAvailed: $leavesAvailed)';
  }
}

/// @nodoc
abstract mixin class _$LeaveBalanceCopyWith<$Res>
    implements $LeaveBalanceCopyWith<$Res> {
  factory _$LeaveBalanceCopyWith(
          _LeaveBalance value, $Res Function(_LeaveBalance) _then) =
      __$LeaveBalanceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "leave_type_id") String? leaveTypeId,
      @JsonKey(name: "name") String? name,
      @JsonKey(name: "staff_id") String? staffId,
      @JsonKey(name: "leaves_allocated") String? leavesAllocated,
      @JsonKey(name: "leaves_availed") String? leavesAvailed});
}

/// @nodoc
class __$LeaveBalanceCopyWithImpl<$Res>
    implements _$LeaveBalanceCopyWith<$Res> {
  __$LeaveBalanceCopyWithImpl(this._self, this._then);

  final _LeaveBalance _self;
  final $Res Function(_LeaveBalance) _then;

  /// Create a copy of LeaveBalance
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? leaveTypeId = freezed,
    Object? name = freezed,
    Object? staffId = freezed,
    Object? leavesAllocated = freezed,
    Object? leavesAvailed = freezed,
  }) {
    return _then(_LeaveBalance(
      leaveTypeId: freezed == leaveTypeId
          ? _self.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String?,
      leavesAllocated: freezed == leavesAllocated
          ? _self.leavesAllocated
          : leavesAllocated // ignore: cast_nullable_to_non_nullable
              as String?,
      leavesAvailed: freezed == leavesAvailed
          ? _self.leavesAvailed
          : leavesAvailed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
