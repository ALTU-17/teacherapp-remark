import 'package:freezed_annotation/freezed_annotation.dart';
part 'student.g.dart';
part 'student.freezed.dart';

@freezed
abstract class Students with _$Students {
  const factory Students({
    @JsonKey(name: "attendance_id") required dynamic attendanceId,
    @JsonKey(name: "unq_id") required dynamic unqId,
    @JsonKey(name: "teacher_id") required dynamic teacherId,
    @JsonKey(name: "class_id") required String classId,
    @JsonKey(name: "section_id") required dynamic sectionId,
    @JsonKey(name: "subject_id") required dynamic subjectId,
    @JsonKey(name: "date") required dynamic date,
    @JsonKey(name: "student_id") required String studentId,
    @JsonKey(name: "attendance_status") String? attendanceStatus,
    @JsonKey(name: "only_date") required dynamic onlyDate,
    @JsonKey(name: "academic_yr") required dynamic academicYr,
    @JsonKey(name: "first_name") required String firstName,
    @JsonKey(name: "last_name") required String lastName,
    @JsonKey(name: "roll_no") required dynamic rollNo,
    @JsonKey(name: "isActive") required dynamic isActive,
    @JsonKey(name: "mark_attendance") String? markAttendance,
    @JsonKey(name: "Delete_btn") required String deleteBtn,
  }) = _Students;

  factory Students.fromJson(Map<String, dynamic> json) =>
      _$StudentsFromJson(json);
}
