// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_update_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateUpdateBody _$CreateUpdateBodyFromJson(Map<String, dynamic> json) =>
    _CreateUpdateBody(
      leaveAppId: json['leave_app_id'] as String?,
      leaveTypeId: json['leave_type_id'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      noOfDays: json['no_of_days'] as String?,
      status: json['status'] as String? ?? 'A',
      resonRejection: json['reason_rejection'] as String? ?? '',
      staffId: json['staff_id'] as String?,
      acdYr: json['acd_yr'] as String?,
      operation: json['operation'] as String? ?? 'create',
      reason: json['reason'] as String?,
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$CreateUpdateBodyToJson(_CreateUpdateBody instance) =>
    <String, dynamic>{
      if (instance.leaveAppId case final value?) 'leave_app_id': value,
      if (instance.leaveTypeId case final value?) 'leave_type_id': value,
      if (instance.startDate case final value?) 'start_date': value,
      if (instance.endDate case final value?) 'end_date': value,
      if (instance.noOfDays case final value?) 'no_of_days': value,
      if (instance.status case final value?) 'status': value,
      if (instance.resonRejection case final value?) 'reason_rejection': value,
      if (instance.staffId case final value?) 'staff_id': value,
      if (instance.acdYr case final value?) 'acd_yr': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.reason case final value?) 'reason': value,
      if (instance.shortName case final value?) 'short_name': value,
    };
