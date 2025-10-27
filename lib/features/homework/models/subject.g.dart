// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subject _$SubjectFromJson(Map<String, dynamic> json) => _Subject(
      subjectId: json['subject_id'] as String?,
      smId: json['sm_id'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
      teacherId: json['teacher_id'] as String?,
      academicYr: json['academic_yr'] as String?,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      name: json['name'] as String?,
      subjectType: json['subject_type'] as String?,
    );

Map<String, dynamic> _$SubjectToJson(_Subject instance) => <String, dynamic>{
      if (instance.subjectId case final value?) 'subject_id': value,
      if (instance.smId case final value?) 'sm_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.createdAt case final value?) 'created_at': value,
      if (instance.updatedAt case final value?) 'updated_at': value,
      if (instance.name case final value?) 'name': value,
      if (instance.subjectType case final value?) 'subject_type': value,
    };
