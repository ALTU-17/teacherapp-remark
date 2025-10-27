// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'att.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Att _$AttFromJson(Map<String, dynamic> json) => _Att(
      attendanceStatus: json['attendance_status'] as String?,
      markAttendance: json['mark_attendance'] as String?,
      fName: json['fName'] as String?,
      lName: json['lName'] as String?,
      rollNo: json['rollno'] as String?,
      studentId: json['student_id'] as String?,
      classId: json['classid'] as String?,
      sectionId: json['sectionid'] as String?,
      date: json['date'] as String?,
      onlyDate: json['only_date'] as String?,
      teacherId: json['teacher_id'] as String?,
      academicYr: json['academic_yr'] as String?,
    );

Map<String, dynamic> _$AttToJson(_Att instance) => <String, dynamic>{
      if (instance.attendanceStatus case final value?)
        'attendance_status': value,
      if (instance.markAttendance case final value?) 'mark_attendance': value,
      if (instance.fName case final value?) 'fName': value,
      if (instance.lName case final value?) 'lName': value,
      if (instance.rollNo case final value?) 'rollno': value,
      if (instance.studentId case final value?) 'student_id': value,
      if (instance.classId case final value?) 'classid': value,
      if (instance.sectionId case final value?) 'sectionid': value,
      if (instance.date case final value?) 'date': value,
      if (instance.onlyDate case final value?) 'only_date': value,
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
    };
