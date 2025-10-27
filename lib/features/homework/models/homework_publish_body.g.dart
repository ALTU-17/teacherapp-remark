// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_publish_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeworkPublishBody _$HomeworkPublishBodyFromJson(Map<String, dynamic> json) =>
    _HomeworkPublishBody(
      homeworkId: json['homework_id'] as String?,
      publish: json['publish'] as String?,
      operation: json['operation'] as String? ?? 'publish',
      loginType: json['login_type'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$HomeworkPublishBodyToJson(
        _HomeworkPublishBody instance) =>
    <String, dynamic>{
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.loginType case final value?) 'login_type': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.shortName case final value?) 'short_name': value,
    };
