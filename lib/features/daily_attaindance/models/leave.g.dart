// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Leave _$LeaveFromJson(Map<String, dynamic> json) => _Leave(
      leaveAppId: json['leave_app_id'] as String?,
      staffId: json['staff_id'] as String?,
      leaveTypeId: json['leave_type_id'] as String?,
      leaveStartDate: json['leave_start_date'] as String?,
      leaveEndDate: json['leave_end_date'] as String?,
      noOfDays: json['no_of_days'] as String?,
      approvedBy: json['approved_by'] as String?,
      status: json['status'] as String?,
      reason: json['reason'] as String?,
      reasonForRejection: json['reason_for_rejection'] as String?,
      academicYr: json['academic_yr'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LeaveToJson(_Leave instance) => <String, dynamic>{
      if (instance.leaveAppId case final value?) 'leave_app_id': value,
      if (instance.staffId case final value?) 'staff_id': value,
      if (instance.leaveTypeId case final value?) 'leave_type_id': value,
      if (instance.leaveStartDate case final value?) 'leave_start_date': value,
      if (instance.leaveEndDate case final value?) 'leave_end_date': value,
      if (instance.noOfDays case final value?) 'no_of_days': value,
      if (instance.approvedBy case final value?) 'approved_by': value,
      if (instance.status case final value?) 'status': value,
      if (instance.reason case final value?) 'reason': value,
      if (instance.reasonForRejection case final value?)
        'reason_for_rejection': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.createdAt case final value?) 'created_at': value,
      if (instance.updatedAt case final value?) 'updated_at': value,
      if (instance.name case final value?) 'name': value,
    };
