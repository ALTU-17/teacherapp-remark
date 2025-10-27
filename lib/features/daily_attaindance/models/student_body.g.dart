// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentBody _$StudentBodyFromJson(Map<String, dynamic> json) => _StudentBody(
      academicYr: json['academic_yr'] as String?,
      classID: json['class_id'] as String?,
      sectionID: json['section_id'] as String?,
      onlyDate: json['only_date'] as String?,
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$StudentBodyToJson(_StudentBody instance) =>
    <String, dynamic>{
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.classID case final value?) 'class_id': value,
      if (instance.sectionID case final value?) 'section_id': value,
      if (instance.onlyDate case final value?) 'only_date': value,
      if (instance.shortName case final value?) 'short_name': value,
    };
