// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Homework _$HomeworkFromJson(Map<String, dynamic> json) => _Homework(
      homeworkId: json['homework_id'] as String?,
      description: json['description'] as String?,
      teacherId: json['teacher_id'] as String?,
      sectionId: json['section_id'] as String?,
      smId: json['sm_id'] as String?,
      classId: json['class_id'] as String?,
      endDate: json['end_date'] as String?,
      startDate: json['start_date'] as String?,
      publishDate: json['publish_date'] as String?,
      academicYr: json['academic_yr'] as String?,
      publish: json['publish'] as String?,
      commentCount: json['comment_count'] as String?,
      clsName: json['cls_name'] as String?,
      secName: json['sec_name'] as String?,
      subName: json['sub_name'] as String?,
    );

Map<String, dynamic> _$HomeworkToJson(_Homework instance) => <String, dynamic>{
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.smId case final value?) 'sm_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.endDate case final value?) 'end_date': value,
      if (instance.startDate case final value?) 'start_date': value,
      if (instance.publishDate case final value?) 'publish_date': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.commentCount case final value?) 'comment_count': value,
      if (instance.clsName case final value?) 'cls_name': value,
      if (instance.secName case final value?) 'sec_name': value,
      if (instance.subName case final value?) 'sub_name': value,
    };
