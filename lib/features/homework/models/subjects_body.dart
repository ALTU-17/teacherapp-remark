import 'package:freezed_annotation/freezed_annotation.dart';

part 'subjects_body.freezed.dart';
part 'subjects_body.g.dart';

@freezed
abstract class SubjectsBody with _$SubjectsBody {
  const factory SubjectsBody({
    @JsonKey(name: "academic_yr") required String academicYr,
    @JsonKey(name: "reg_id") required String regId,
    @JsonKey(name: "section_id") required String sectionId,
    @JsonKey(name: "class_id") required String classId,
    @JsonKey(name: "short_name") required String shortName,
  }) = _SubjectsBody;

  factory SubjectsBody.fromJson(Map<String, dynamic> json) =>
      _$SubjectsBodyFromJson(json);
}
