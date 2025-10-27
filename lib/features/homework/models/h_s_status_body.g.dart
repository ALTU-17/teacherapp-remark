// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'h_s_status_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HSStatusBody _$HSStatusBodyFromJson(Map<String, dynamic> json) =>
    _HSStatusBody(
      homeworkId: json['homework_id'] as String?,
      operation: json['operation'] as String? ?? 'HWStatus',
      loginType: json['login_type'] as String? ?? 'T',
      academicYr: json['academic_yr'] as String?,
      teacherId: json['teacher_id'] as String?,
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$HSStatusBodyToJson(_HSStatusBody instance) =>
    <String, dynamic>{
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.loginType case final value?) 'login_type': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.shortName case final value?) 'short_name': value,
    };
