// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeworkStatus _$HomeworkStatusFromJson(Map<String, dynamic> json) =>
    _HomeworkStatus(
      homeworkId: json['homework_id'] as String?,
      studentId: json['student_id'] as String?,
      homeworkStatus: json['homework_status'] as String?,
      teachercomment: json['teachercomment'] as String?,
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$HomeworkStatusToJson(_HomeworkStatus instance) =>
    <String, dynamic>{
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.studentId case final value?) 'student_id': value,
      if (instance.homeworkStatus case final value?) 'homework_status': value,
      if (instance.teachercomment case final value?) 'teachercomment': value,
      if (instance.shortName case final value?) 'short_name': value,
    };
