// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subjects_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SubjectsBody _$SubjectsBodyFromJson(Map<String, dynamic> json) =>
    _SubjectsBody(
      academicYr: json['academic_yr'] as String,
      regId: json['reg_id'] as String,
      sectionId: json['section_id'] as String,
      classId: json['class_id'] as String,
      shortName: json['short_name'] as String,
    );

Map<String, dynamic> _$SubjectsBodyToJson(_SubjectsBody instance) =>
    <String, dynamic>{
      'academic_yr': instance.academicYr,
      'reg_id': instance.regId,
      'section_id': instance.sectionId,
      'class_id': instance.classId,
      'short_name': instance.shortName,
    };
