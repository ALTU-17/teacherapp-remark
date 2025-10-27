import 'package:freezed_annotation/freezed_annotation.dart';

import 'doc_homework.dart';

part 'homework_view_by_parent.freezed.dart';
part 'homework_view_by_parent.g.dart';

@freezed
abstract class HomeworkViewByParent with _$HomeworkViewByParent {
  const factory HomeworkViewByParent({
    @JsonKey(name: "roll_no") String? rollNo,
    @JsonKey(name: "first_name") String? firstName,
    @JsonKey(name: "mid_name") String? midName,
    @JsonKey(name: "last_name") String? lastName,
    @JsonKey(name: "read_status") String? readStatus,
    @JsonKey(name: "student_id") String? studentId,
    @JsonKey(name: "attachment") DocHomework? attachment,
  }) = _HomeworkViewByParent;

  factory HomeworkViewByParent.fromJson(Map<String, dynamic> json) =>
      _$HomeworkViewByParentFromJson(json);
}
