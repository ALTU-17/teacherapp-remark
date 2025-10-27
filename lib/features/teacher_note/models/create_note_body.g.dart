// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_note_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreateNoteBody _$CreateNoteBodyFromJson(Map<String, dynamic> json) =>
    _CreateNoteBody(
      academicYear: json['academic_yr'] as String?,
      shortName: json['short_name'] as String?,
      randomNo: json['random_no'] as String?,
      teacherId: json['teacher_id'] as String?,
      description: json['description'] as String?,
      strArray: json['str_array'] as String?,
      loginType: json['login_type'] as String? ?? 'T',
      publish: json['publish'] as String? ?? 'Y',
      dailyNoteDate: json['dailynote_date'] as String?,
      operation: json['operation'] as String? ?? 'create',
      subjectId: json['subject_id'] as String?,
      sectionId: json['section_id'] as String?,
      classId: json['class_id'] as String?,
      notesId: json['notes_id'] as String?,
      deleteimagelist: (json['deleteimagelist'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      filename: (json['filename'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CreateNoteBodyToJson(_CreateNoteBody instance) =>
    <String, dynamic>{
      if (instance.academicYear case final value?) 'academic_yr': value,
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.randomNo case final value?) 'random_no': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.strArray case final value?) 'str_array': value,
      if (instance.loginType case final value?) 'login_type': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.dailyNoteDate case final value?) 'dailynote_date': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.subjectId case final value?) 'subject_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.notesId case final value?) 'notes_id': value,
      if (instance.deleteimagelist case final value?) 'deleteimagelist': value,
      if (instance.filename case final value?) 'filename': value,
    };
