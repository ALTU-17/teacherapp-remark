// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_plan_heading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonPlanHeading _$LessonPlanHeadingFromJson(Map<String, dynamic> json) =>
    _LessonPlanHeading(
      id: json['lesson_plan_headings_id'] as String,
      title: json['name'] as String,
      sequence: json['sequence'] as String,
      changeDaily: json['change_daily'] as String?,
      isUsed: json['IsUsed'] as String?,
    );

Map<String, dynamic> _$LessonPlanHeadingToJson(_LessonPlanHeading instance) =>
    <String, dynamic>{
      'lesson_plan_headings_id': instance.id,
      'name': instance.title,
      'sequence': instance.sequence,
      if (instance.changeDaily case final value?) 'change_daily': value,
      if (instance.isUsed case final value?) 'IsUsed': value,
    };
