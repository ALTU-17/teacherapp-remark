// To parse this JSON data, do
//
//     final homeworkPublishBody = homeworkPublishBodyFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_publish_body.freezed.dart';
part 'homework_publish_body.g.dart';

@freezed
abstract class HomeworkPublishBody with _$HomeworkPublishBody {
  const factory HomeworkPublishBody({
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "publish") String? publish,
    @JsonKey(name: "operation") @Default('publish') String? operation,
    @JsonKey(name: "login_type") String? loginType,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "short_name") String? shortName,
  }) = _HomeworkPublishBody;

  factory HomeworkPublishBody.fromJson(Map<String, dynamic> json) =>
      _$HomeworkPublishBodyFromJson(json);
}
