import 'package:freezed_annotation/freezed_annotation.dart';

part 'homework_view_body.freezed.dart';
part 'homework_view_body.g.dart';

@freezed
abstract class HomeWorkViewBody with _$HomeWorkViewBody {
  const factory HomeWorkViewBody({
    @JsonKey(name: "short_name") String? shortName,
    @JsonKey(name: "acd_yr") String? acdYr,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "homework_id") String? homeworkId,
  }) = _HomeWorkViewBody;

  factory HomeWorkViewBody.fromJson(Map<String, dynamic> json) =>
      _$HomeWorkViewBodyFromJson(json);
}
