// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Leave {
  @JsonKey(name: "leave_app_id")
  String? get leaveAppId;
  @JsonKey(name: "staff_id")
  String? get staffId;
  @JsonKey(name: "leave_type_id")
  String? get leaveTypeId;
  @JsonKey(name: "leave_start_date")
  String? get leaveStartDate;
  @JsonKey(name: "leave_end_date")
  String? get leaveEndDate;
  @JsonKey(name: "no_of_days")
  String? get noOfDays;
  @JsonKey(name: "approved_by")
  String? get approvedBy;
  @JsonKey(name: "status")
  String? get status;
  @JsonKey(name: "reason")
  String? get reason;
  @JsonKey(name: "reason_for_rejection")
  String? get reasonForRejection;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "created_at")
  String? get createdAt;
  @JsonKey(name: "updated_at")
  String? get updatedAt;
  @JsonKey(name: "name")
  String? get name;

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveCopyWith<Leave> get copyWith =>
      _$LeaveCopyWithImpl<Leave>(this as Leave, _$identity);

  /// Serializes this Leave to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Leave &&
            (identical(other.leaveAppId, leaveAppId) ||
                other.leaveAppId == leaveAppId) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.leaveStartDate, leaveStartDate) ||
                other.leaveStartDate == leaveStartDate) &&
            (identical(other.leaveEndDate, leaveEndDate) ||
                other.leaveEndDate == leaveEndDate) &&
            (identical(other.noOfDays, noOfDays) ||
                other.noOfDays == noOfDays) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.reasonForRejection, reasonForRejection) ||
                other.reasonForRejection == reasonForRejection) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      leaveAppId,
      staffId,
      leaveTypeId,
      leaveStartDate,
      leaveEndDate,
      noOfDays,
      approvedBy,
      status,
      reason,
      reasonForRejection,
      academicYr,
      createdAt,
      updatedAt,
      name);

  @override
  String toString() {
    return 'Leave(leaveAppId: $leaveAppId, staffId: $staffId, leaveTypeId: $leaveTypeId, leaveStartDate: $leaveStartDate, leaveEndDate: $leaveEndDate, noOfDays: $noOfDays, approvedBy: $approvedBy, status: $status, reason: $reason, reasonForRejection: $reasonForRejection, academicYr: $academicYr, createdAt: $createdAt, updatedAt: $updatedAt, name: $name)';
  }
}

/// @nodoc
abstract mixin class $LeaveCopyWith<$Res> {
  factory $LeaveCopyWith(Leave value, $Res Function(Leave) _then) =
      _$LeaveCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "leave_app_id") String? leaveAppId,
      @JsonKey(name: "staff_id") String? staffId,
      @JsonKey(name: "leave_type_id") String? leaveTypeId,
      @JsonKey(name: "leave_start_date") String? leaveStartDate,
      @JsonKey(name: "leave_end_date") String? leaveEndDate,
      @JsonKey(name: "no_of_days") String? noOfDays,
      @JsonKey(name: "approved_by") String? approvedBy,
      @JsonKey(name: "status") String? status,
      @JsonKey(name: "reason") String? reason,
      @JsonKey(name: "reason_for_rejection") String? reasonForRejection,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      @JsonKey(name: "name") String? name});
}

/// @nodoc
class _$LeaveCopyWithImpl<$Res> implements $LeaveCopyWith<$Res> {
  _$LeaveCopyWithImpl(this._self, this._then);

  final Leave _self;
  final $Res Function(Leave) _then;

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveAppId = freezed,
    Object? staffId = freezed,
    Object? leaveTypeId = freezed,
    Object? leaveStartDate = freezed,
    Object? leaveEndDate = freezed,
    Object? noOfDays = freezed,
    Object? approvedBy = freezed,
    Object? status = freezed,
    Object? reason = freezed,
    Object? reasonForRejection = freezed,
    Object? academicYr = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? name = freezed,
  }) {
    return _then(_self.copyWith(
      leaveAppId: freezed == leaveAppId
          ? _self.leaveAppId
          : leaveAppId // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveTypeId: freezed == leaveTypeId
          ? _self.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveStartDate: freezed == leaveStartDate
          ? _self.leaveStartDate
          : leaveStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveEndDate: freezed == leaveEndDate
          ? _self.leaveEndDate
          : leaveEndDate // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfDays: freezed == noOfDays
          ? _self.noOfDays
          : noOfDays // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _self.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonForRejection: freezed == reasonForRejection
          ? _self.reasonForRejection
          : reasonForRejection // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Leave implements Leave {
  const _Leave(
      {@JsonKey(name: "leave_app_id") this.leaveAppId,
      @JsonKey(name: "staff_id") this.staffId,
      @JsonKey(name: "leave_type_id") this.leaveTypeId,
      @JsonKey(name: "leave_start_date") this.leaveStartDate,
      @JsonKey(name: "leave_end_date") this.leaveEndDate,
      @JsonKey(name: "no_of_days") this.noOfDays,
      @JsonKey(name: "approved_by") this.approvedBy,
      @JsonKey(name: "status") this.status,
      @JsonKey(name: "reason") this.reason,
      @JsonKey(name: "reason_for_rejection") this.reasonForRejection,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "created_at") this.createdAt,
      @JsonKey(name: "updated_at") this.updatedAt,
      @JsonKey(name: "name") this.name});
  factory _Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);

  @override
  @JsonKey(name: "leave_app_id")
  final String? leaveAppId;
  @override
  @JsonKey(name: "staff_id")
  final String? staffId;
  @override
  @JsonKey(name: "leave_type_id")
  final String? leaveTypeId;
  @override
  @JsonKey(name: "leave_start_date")
  final String? leaveStartDate;
  @override
  @JsonKey(name: "leave_end_date")
  final String? leaveEndDate;
  @override
  @JsonKey(name: "no_of_days")
  final String? noOfDays;
  @override
  @JsonKey(name: "approved_by")
  final String? approvedBy;
  @override
  @JsonKey(name: "status")
  final String? status;
  @override
  @JsonKey(name: "reason")
  final String? reason;
  @override
  @JsonKey(name: "reason_for_rejection")
  final String? reasonForRejection;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "created_at")
  final String? createdAt;
  @override
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @override
  @JsonKey(name: "name")
  final String? name;

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveCopyWith<_Leave> get copyWith =>
      __$LeaveCopyWithImpl<_Leave>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Leave &&
            (identical(other.leaveAppId, leaveAppId) ||
                other.leaveAppId == leaveAppId) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.leaveStartDate, leaveStartDate) ||
                other.leaveStartDate == leaveStartDate) &&
            (identical(other.leaveEndDate, leaveEndDate) ||
                other.leaveEndDate == leaveEndDate) &&
            (identical(other.noOfDays, noOfDays) ||
                other.noOfDays == noOfDays) &&
            (identical(other.approvedBy, approvedBy) ||
                other.approvedBy == approvedBy) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.reasonForRejection, reasonForRejection) ||
                other.reasonForRejection == reasonForRejection) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      leaveAppId,
      staffId,
      leaveTypeId,
      leaveStartDate,
      leaveEndDate,
      noOfDays,
      approvedBy,
      status,
      reason,
      reasonForRejection,
      academicYr,
      createdAt,
      updatedAt,
      name);

  @override
  String toString() {
    return 'Leave(leaveAppId: $leaveAppId, staffId: $staffId, leaveTypeId: $leaveTypeId, leaveStartDate: $leaveStartDate, leaveEndDate: $leaveEndDate, noOfDays: $noOfDays, approvedBy: $approvedBy, status: $status, reason: $reason, reasonForRejection: $reasonForRejection, academicYr: $academicYr, createdAt: $createdAt, updatedAt: $updatedAt, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$LeaveCopyWith<$Res> implements $LeaveCopyWith<$Res> {
  factory _$LeaveCopyWith(_Leave value, $Res Function(_Leave) _then) =
      __$LeaveCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "leave_app_id") String? leaveAppId,
      @JsonKey(name: "staff_id") String? staffId,
      @JsonKey(name: "leave_type_id") String? leaveTypeId,
      @JsonKey(name: "leave_start_date") String? leaveStartDate,
      @JsonKey(name: "leave_end_date") String? leaveEndDate,
      @JsonKey(name: "no_of_days") String? noOfDays,
      @JsonKey(name: "approved_by") String? approvedBy,
      @JsonKey(name: "status") String? status,
      @JsonKey(name: "reason") String? reason,
      @JsonKey(name: "reason_for_rejection") String? reasonForRejection,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "created_at") String? createdAt,
      @JsonKey(name: "updated_at") String? updatedAt,
      @JsonKey(name: "name") String? name});
}

/// @nodoc
class __$LeaveCopyWithImpl<$Res> implements _$LeaveCopyWith<$Res> {
  __$LeaveCopyWithImpl(this._self, this._then);

  final _Leave _self;
  final $Res Function(_Leave) _then;

  /// Create a copy of Leave
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? leaveAppId = freezed,
    Object? staffId = freezed,
    Object? leaveTypeId = freezed,
    Object? leaveStartDate = freezed,
    Object? leaveEndDate = freezed,
    Object? noOfDays = freezed,
    Object? approvedBy = freezed,
    Object? status = freezed,
    Object? reason = freezed,
    Object? reasonForRejection = freezed,
    Object? academicYr = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? name = freezed,
  }) {
    return _then(_Leave(
      leaveAppId: freezed == leaveAppId
          ? _self.leaveAppId
          : leaveAppId // ignore: cast_nullable_to_non_nullable
              as String?,
      staffId: freezed == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveTypeId: freezed == leaveTypeId
          ? _self.leaveTypeId
          : leaveTypeId // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveStartDate: freezed == leaveStartDate
          ? _self.leaveStartDate
          : leaveStartDate // ignore: cast_nullable_to_non_nullable
              as String?,
      leaveEndDate: freezed == leaveEndDate
          ? _self.leaveEndDate
          : leaveEndDate // ignore: cast_nullable_to_non_nullable
              as String?,
      noOfDays: freezed == noOfDays
          ? _self.noOfDays
          : noOfDays // ignore: cast_nullable_to_non_nullable
              as String?,
      approvedBy: freezed == approvedBy
          ? _self.approvedBy
          : approvedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      reason: freezed == reason
          ? _self.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonForRejection: freezed == reasonForRejection
          ? _self.reasonForRejection
          : reasonForRejection // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
