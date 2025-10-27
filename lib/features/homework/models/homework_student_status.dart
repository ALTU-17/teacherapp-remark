// To parse this JSON data, do
//
//     final homeworkGetStudenStatus = homeworkGetStudenStatusFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_student_status.freezed.dart';
part 'homework_student_status.g.dart';

@freezed
abstract class HomeworkStudentStatus with _$HomeworkStudentStatus {
  const factory HomeworkStudentStatus({
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "sm_id") String? smId,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "end_date") DateTime? endDate,
    @JsonKey(name: "start_date") DateTime? startDate,
    @JsonKey(name: "publish_date") DateTime? publishDate,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "publish") String? publish,
    @JsonKey(name: "comment_id") String? commentId,
    @JsonKey(name: "student_id") String? studentId,
    @JsonKey(name: "parent_id") String? parentId,
    @JsonKey(name: "homework_status") String? homeworkStatus,
    @JsonKey(name: "comment") String? comment,
    @JsonKey(name: "parent_comment") String? parentComment,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "roll_no") String? rollNo,
  }) = _HomeworkStudenStatus;

  factory HomeworkStudentStatus.fromJson(Map<String, dynamic> json) =>
      _$HomeworkStudenStatusFromJson(json);
}
