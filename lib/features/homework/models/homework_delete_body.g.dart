// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_delete_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeworkDeleteBody _$HomeworkDeleteBodyFromJson(Map<String, dynamic> json) =>
    _HomeworkDeleteBody(
      homeworkId: json['homework_id'] as String?,
      publish: json['publish'] as String?,
      operation: json['operation'] as String? ?? 'delete',
      loginType: json['login_type'] as String?,
      academicYr: json['academic_yr'] as String?,
      teacherId: json['teacher_id'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
      smId: json['sm_id'] as String?,
    );

Map<String, dynamic> _$HomeworkDeleteBodyToJson(_HomeworkDeleteBody instance) =>
    <String, dynamic>{
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.loginType case final value?) 'login_type': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.smId case final value?) 'sm_id': value,
    };
