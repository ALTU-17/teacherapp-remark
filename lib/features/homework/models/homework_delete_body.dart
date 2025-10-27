// To parse this JSON data, do
//
//     final homeworkDeleteBody = homeworkDeleteBodyFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_delete_body.freezed.dart';
part 'homework_delete_body.g.dart';

@freezed
abstract class HomeworkDeleteBody with _$HomeworkDeleteBody {
  const factory HomeworkDeleteBody({
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "publish") String? publish,
    @JsonKey(name: "operation") @Default('delete') String? operation,
    @JsonKey(name: "login_type") String? loginType,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "sm_id") String? smId,
  }) = _HomeworkDeleteBody;

  factory HomeworkDeleteBody.fromJson(Map<String, dynamic> json) =>
      _$HomeworkDeleteBodyFromJson(json);
}
