// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_view_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteViewBody _$NoteViewBodyFromJson(Map<String, dynamic> json) =>
    _NoteViewBody(
      acdYr: json['acd_yr'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
      notesId: json['notes_id'] as String?,
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$NoteViewBodyToJson(_NoteViewBody instance) =>
    <String, dynamic>{
      if (instance.acdYr case final value?) 'acd_yr': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.notesId case final value?) 'notes_id': value,
      if (instance.shortName case final value?) 'short_name': value,
    };
