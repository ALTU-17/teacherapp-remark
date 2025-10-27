// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteView _$NoteViewFromJson(Map<String, dynamic> json) => _NoteView(
      rollNo: json['roll_no'] as String?,
      firstName: json['first_name'] as String?,
      midName: json['mid_name'] as String?,
      lastName: json['last_name'] as String?,
      readStatus: json['read_status'] as String?,
      studentId: json['student_id'] as String?,
    );

Map<String, dynamic> _$NoteViewToJson(_NoteView instance) => <String, dynamic>{
      if (instance.rollNo case final value?) 'roll_no': value,
      if (instance.firstName case final value?) 'first_name': value,
      if (instance.midName case final value?) 'mid_name': value,
      if (instance.lastName case final value?) 'last_name': value,
      if (instance.readStatus case final value?) 'read_status': value,
      if (instance.studentId case final value?) 'student_id': value,
    };
