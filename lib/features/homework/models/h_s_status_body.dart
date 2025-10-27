// To parse this JSON data, do
//
//     final homeworkDeleteBody = homeworkDeleteBodyFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'h_s_status_body.freezed.dart';
part 'h_s_status_body.g.dart';

@freezed
abstract class HSStatusBody with _$HSStatusBody {
  const factory HSStatusBody({
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "operation") @Default('HWStatus') String? operation,
    @JsonKey(name: "login_type") @Default('T') String? loginType,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "short_name") String? shortName,
  }) = _HSStatusBody;

  factory HSStatusBody.fromJson(Map<String, dynamic> json) =>
      _$HSStatusBodyFromJson(json);
}
