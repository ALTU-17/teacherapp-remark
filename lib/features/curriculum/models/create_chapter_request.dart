import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chapter_request.freezed.dart';
part 'create_chapter_request.g.dart';

@freezed
abstract class CreateChapterRequest with _$CreateChapterRequest {
  const factory CreateChapterRequest({
    @JsonKey(name: "short_name") required String shortName,
    @JsonKey(name: "class_id") required String classId,
    @JsonKey(name: "chapter_no") required String chapterNo,
    @JsonKey(name: "name") required String name,
    @JsonKey(name: "login_type") required String loginType,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "reg_id") required String regId,
    @JsonKey(name: "sm_id") required String smId,
    @JsonKey(name: "operation") required String operation,
    @JsonKey(name: "acd_yr") required String acdYr,
    @JsonKey(name: "sub_subject") String? subSubject,
  }) = _CreateChapterRequest;

  factory CreateChapterRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChapterRequestFromJson(json);
}