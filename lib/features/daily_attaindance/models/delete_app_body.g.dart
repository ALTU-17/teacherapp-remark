// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_app_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeleteAppBody _$DeleteAppBodyFromJson(Map<String, dynamic> json) =>
    _DeleteAppBody(
      leaveAppId: json['leave_app_id'] as String,
      shortName: json['short_name'] as String,
      operation: json['operation'] as String? ?? 'delete',
    );

Map<String, dynamic> _$DeleteAppBodyToJson(_DeleteAppBody instance) =>
    <String, dynamic>{
      'leave_app_id': instance.leaveAppId,
      'short_name': instance.shortName,
      if (instance.operation case final value?) 'operation': value,
    };
