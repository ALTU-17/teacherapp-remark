// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chapter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateChapterRequest _$CreateChapterRequestFromJson(
        Map<String, dynamic> json) =>
    _CreateChapterRequest(
      shortName: json['short_name'] as String,
      classId: json['class_id'] as String,
      chapterNo: json['chapter_no'] as String,
      name: json['name'] as String,
      loginType: json['login_type'] as String,
      description: json['description'] as String,
      regId: json['reg_id'] as String,
      smId: json['sm_id'] as String,
      operation: json['operation'] as String,
      acdYr: json['acd_yr'] as String,
      subSubject: json['sub_subject'] as String?,
    );

Map<String, dynamic> _$CreateChapterRequestToJson(
        _CreateChapterRequest instance) =>
    <String, dynamic>{
      'short_name': instance.shortName,
      'class_id': instance.classId,
      'chapter_no': instance.chapterNo,
      'name': instance.name,
      'login_type': instance.loginType,
      'description': instance.description,
      'reg_id': instance.regId,
      'sm_id': instance.smId,
      'operation': instance.operation,
      'acd_yr': instance.acdYr,
      if (instance.subSubject case final value?) 'sub_subject': value,
    };
