// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_student_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeworkStudenStatus _$HomeworkStudenStatusFromJson(
        Map<String, dynamic> json) =>
    _HomeworkStudenStatus(
      homeworkId: json['homework_id'] as String?,
      description: json['description'] as String?,
      teacherId: json['teacher_id'] as String?,
      sectionId: json['section_id'] as String?,
      smId: json['sm_id'] as String?,
      classId: json['class_id'] as String?,
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      startDate: json['start_date'] == null
          ? null
          : DateTime.parse(json['start_date'] as String),
      publishDate: json['publish_date'] == null
          ? null
          : DateTime.parse(json['publish_date'] as String),
      academicYr: json['academic_yr'] as String?,
      publish: json['publish'] as String?,
      commentId: json['comment_id'] as String?,
      studentId: json['student_id'] as String?,
      parentId: json['parent_id'] as String?,
      homeworkStatus: json['homework_status'] as String?,
      comment: json['comment'] as String?,
      parentComment: json['parent_comment'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      rollNo: json['roll_no'] as String?,
    );

Map<String, dynamic> _$HomeworkStudenStatusToJson(
        _HomeworkStudenStatus instance) =>
    <String, dynamic>{
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.description case final value?) 'description': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.smId case final value?) 'sm_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.endDate?.toIso8601String() case final value?)
        'end_date': value,
      if (instance.startDate?.toIso8601String() case final value?)
        'start_date': value,
      if (instance.publishDate?.toIso8601String() case final value?)
        'publish_date': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.commentId case final value?) 'comment_id': value,
      if (instance.studentId case final value?) 'student_id': value,
      if (instance.parentId case final value?) 'parent_id': value,
      if (instance.homeworkStatus case final value?) 'homework_status': value,
      if (instance.comment case final value?) 'comment': value,
      if (instance.parentComment case final value?) 'parent_comment': value,
      if (instance.firstName case final value?) 'first_name': value,
      if (instance.lastName case final value?) 'last_name': value,
      if (instance.rollNo case final value?) 'roll_no': value,
    };
