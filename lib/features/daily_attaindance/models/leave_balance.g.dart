// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveBalance _$LeaveBalanceFromJson(Map<String, dynamic> json) =>
    _LeaveBalance(
      leaveTypeId: json['leave_type_id'] as String?,
      name: json['name'] as String?,
      staffId: json['staff_id'] as String?,
      leavesAllocated: json['leaves_allocated'] as String?,
      leavesAvailed: json['leaves_availed'] as String?,
    );

Map<String, dynamic> _$LeaveBalanceToJson(_LeaveBalance instance) =>
    <String, dynamic>{
      if (instance.leaveTypeId case final value?) 'leave_type_id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.staffId case final value?) 'staff_id': value,
      if (instance.leavesAllocated case final value?) 'leaves_allocated': value,
      if (instance.leavesAvailed case final value?) 'leaves_availed': value,
    };
