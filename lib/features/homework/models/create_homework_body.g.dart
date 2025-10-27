// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_homework_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateHomeworkBody _$CreateHomeworkBodyFromJson(Map<String, dynamic> json) =>
    _CreateHomeworkBody(
      randomNo: json['random_no'] as String?,
      homeworkId: json['homework_id'] as String?,
      academicYr: json['academic_yr'] as String?,
      teacherId: json['teacher_id'] as String?,
      sectionId: json['section_id'] as String?,
      classId: json['class_id'] as String?,
      smId: json['sm_id'] as String?,
      description: json['description'] as String?,
      publish: json['publish'] as String?,
      endDate: json['end_date'] as String?,
      startDate: json['start_date'] as String?,
      loginType: json['login_type'] as String?,
      operation: json['operation'] as String? ?? 'create',
      shortName: json['short_name'] as String?,
      deleteimagelist: (json['deleteimagelist'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      filename: (json['filename'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CreateHomeworkBodyToJson(_CreateHomeworkBody instance) =>
    <String, dynamic>{
      if (instance.randomNo case final value?) 'random_no': value,
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.smId case final value?) 'sm_id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.endDate case final value?) 'end_date': value,
      if (instance.startDate case final value?) 'start_date': value,
      if (instance.loginType case final value?) 'login_type': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.shortName case final value?) 'short_name': value,
      'deleteimagelist': instance.deleteimagelist,
      'filename': instance.filename,
    };
