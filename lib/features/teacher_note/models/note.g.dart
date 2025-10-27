// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Note _$NoteFromJson(Map<String, dynamic> json) => _Note(
      notesId: json['notes_id'] as String?,
      date: json['date'] as String?,
      publishDate: json['publish_date'] == null
          ? null
          : DateTime.parse(json['publish_date'] as String),
      classId: json['class_id'] as String?,
      teacherId: json['teacher_id'] as String?,
      sectionId: json['section_id'] as String?,
      subjectId: json['subject_id'] as String?,
      description: json['description'] as String?,
      academicYr: json['academic_yr'] as String?,
      publish: json['publish'] as String?,
      subjectname: json['subjectname'] as String?,
      smId: json['sm_id'] as String?,
      classname: json['classname'] as String?,
      sectionname: json['sectionname'] as String?,
    );

Map<String, dynamic> _$NoteToJson(_Note instance) => <String, dynamic>{
      if (instance.notesId case final value?) 'notes_id': value,
      if (instance.date case final value?) 'date': value,
      if (instance.publishDate?.toIso8601String() case final value?)
        'publish_date': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.subjectId case final value?) 'subject_id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.subjectname case final value?) 'subjectname': value,
      if (instance.smId case final value?) 'sm_id': value,
      if (instance.classname case final value?) 'classname': value,
      if (instance.sectionname case final value?) 'sectionname': value,
    };
