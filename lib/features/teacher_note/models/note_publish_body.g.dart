// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_publish_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotePublishBody _$NotePublishBodyFromJson(Map<String, dynamic> json) =>
    _NotePublishBody(
      notesId: json['notes_id'] as String?,
      operation: json['operation'] as String? ?? 'publish',
      loginType: json['login_type'] as String? ?? 'T',
      shortName: json['short_name'] as String?,
      publish: json['publish'] as String? ?? 'Y',
      regId: json['reg_id'] as String?,
      acdYr: json['acd_yr'] as String?,
      subjectId: json['subject_id'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
    );

Map<String, dynamic> _$NotePublishBodyToJson(_NotePublishBody instance) =>
    <String, dynamic>{
      if (instance.notesId case final value?) 'notes_id': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.loginType case final value?) 'login_type': value,
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.regId case final value?) 'reg_id': value,
      if (instance.acdYr case final value?) 'acd_yr': value,
      if (instance.subjectId case final value?) 'subject_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
    };
