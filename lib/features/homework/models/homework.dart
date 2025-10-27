import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework.freezed.dart';
part 'homework.g.dart';

@freezed
abstract class Homework with _$Homework {
  const factory Homework({
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "sm_id") String? smId,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "end_date") String? endDate,
    @JsonKey(name: "start_date") String? startDate,
    @JsonKey(name: "publish_date") String? publishDate,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "publish") String? publish,
    @JsonKey(name: "comment_count") String? commentCount,
    @JsonKey(name: "cls_name") String? clsName,
    @JsonKey(name: "sec_name") String? secName,
    @JsonKey(name: "sub_name") String? subName,
  }) = _Homework;

  factory Homework.fromJson(Map<String, dynamic> json) =>
      _$HomeworkFromJson(json);
}
