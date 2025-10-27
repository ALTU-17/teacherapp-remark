// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Students _$StudentsFromJson(Map<String, dynamic> json) => _Students(
      attendanceId: json['attendance_id'],
      unqId: json['unq_id'],
      teacherId: json['teacher_id'],
      classId: json['class_id'] as String,
      sectionId: json['section_id'],
      subjectId: json['subject_id'],
      date: json['date'],
      studentId: json['student_id'] as String,
      attendanceStatus: json['attendance_status'] as String?,
      onlyDate: json['only_date'],
      academicYr: json['academic_yr'],
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      rollNo: json['roll_no'],
      isActive: json['isActive'],
      markAttendance: json['mark_attendance'] as String?,
      deleteBtn: json['Delete_btn'] as String,
    );

Map<String, dynamic> _$StudentsToJson(_Students instance) => <String, dynamic>{
      if (instance.attendanceId case final value?) 'attendance_id': value,
      if (instance.unqId case final value?) 'unq_id': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      'class_id': instance.classId,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.subjectId case final value?) 'subject_id': value,
      if (instance.date case final value?) 'date': value,
      'student_id': instance.studentId,
      if (instance.attendanceStatus case final value?)
        'attendance_status': value,
      if (instance.onlyDate case final value?) 'only_date': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      if (instance.rollNo case final value?) 'roll_no': value,
      if (instance.isActive case final value?) 'isActive': value,
      if (instance.markAttendance case final value?) 'mark_attendance': value,
      'Delete_btn': instance.deleteBtn,
    };
