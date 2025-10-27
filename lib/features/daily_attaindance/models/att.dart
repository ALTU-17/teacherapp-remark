// Sample JSON structure this model represents:
// {
//   "attendance_status": "0",
//"mark_attendance": "0",
//   "fName": "SAMARTH",
//   "lName": "JARHAD",
//   "rollno": "",
//   "student_id": "22193",
//   "classid": "137",
//   "sectionid": "542",
//   "date": "2025-08-04",
//   "only_date": "2025-08-04",
//   "teacher_id": "29",
//   "academic_yr": "2025-2026"
// }

import 'package:freezed_annotation/freezed_annotation.dart';
part 'att.freezed.dart';
part 'att.g.dart';

@freezed
abstract class Att with _$Att {
  const factory Att({
    @JsonKey(name: "attendance_status") String? attendanceStatus,
    @JsonKey(name: "fName") String? fName,
    @JsonKey(name: "lName") String? lName,
    @JsonKey(name: "rollno") String? rollNo,
    @JsonKey(name: "student_id") String? studentId,
    @JsonKey(name: "classid") String? classId,
    @JsonKey(name: "sectionid") String? sectionId,
    @JsonKey(name: "date") String? date,
    @JsonKey(name: "only_date") String? onlyDate,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "academic_yr") String? academicYr,
  }) = _Att;

  factory Att.fromJson(Map<String, dynamic> json) => _$AttFromJson(json);
}
