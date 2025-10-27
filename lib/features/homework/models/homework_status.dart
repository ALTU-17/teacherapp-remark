import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_status.freezed.dart';
part 'homework_status.g.dart';

@freezed
abstract class HomeworkStatus with _$HomeworkStatus {
  const factory HomeworkStatus({
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "student_id") String? studentId,
    @JsonKey(name: "homework_status") String? homeworkStatus,
    @JsonKey(name: "teachercomment") String? teachercomment,
    @JsonKey(name: "short_name") String? shortName,
  }) = _HomeworkStatus;

  factory HomeworkStatus.fromJson(Map<String, dynamic> json) =>
      _$HomeworkStatusFromJson(json);
}
