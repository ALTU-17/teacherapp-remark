// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Chapter _$ChapterFromJson(Map<String, dynamic> json) => _Chapter(
      tecName: json['tec_name'] as String?,
      teacherId: json['teacher_id'] as String?,
      subName: json['sub_name'] as String?,
      className: json['class_name'] as String?,
      academicYr: json['academic_yr'] as String?,
      createdBy: json['created_by'] as String?,
      publish: json['publish'] as String?,
      isDelete: json['isDelete'] as String?,
      difficultyLevel: json['difficulty_level'] as String?,
      description: json['description'] as String?,
      subSubject: json['sub_subject'] as String?,
      name: json['name'] as String?,
      chapterNo: json['chapter_no'] as String?,
      subjectId: json['subject_id'] as String?,
      classId: json['class_id'] as String?,
      chapterId: json['chapter_id'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
      isPublished: json['isPublished'] as bool? ?? false,
    );

Map<String, dynamic> _$ChapterToJson(_Chapter instance) => <String, dynamic>{
      if (instance.tecName case final value?) 'tec_name': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.subName case final value?) 'sub_name': value,
      if (instance.className case final value?) 'class_name': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.createdBy case final value?) 'created_by': value,
      if (instance.publish case final value?) 'publish': value,
      if (instance.isDelete case final value?) 'isDelete': value,
      if (instance.difficultyLevel case final value?) 'difficulty_level': value,
      if (instance.description case final value?) 'description': value,
      if (instance.subSubject case final value?) 'sub_subject': value,
      if (instance.name case final value?) 'name': value,
      if (instance.chapterNo case final value?) 'chapter_no': value,
      if (instance.subjectId case final value?) 'subject_id': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.chapterId case final value?) 'chapter_id': value,
      'isSelected': instance.isSelected,
      'isPublished': instance.isPublished,
    };
