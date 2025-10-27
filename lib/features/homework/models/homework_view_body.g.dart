// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_view_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeWorkViewBody _$HomeWorkViewBodyFromJson(Map<String, dynamic> json) =>
    _HomeWorkViewBody(
      shortName: json['short_name'] as String?,
      acdYr: json['acd_yr'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
      homeworkId: json['homework_id'] as String?,
    );

Map<String, dynamic> _$HomeWorkViewBodyToJson(_HomeWorkViewBody instance) =>
    <String, dynamic>{
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.acdYr case final value?) 'acd_yr': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.homeworkId case final value?) 'homework_id': value,
    };
