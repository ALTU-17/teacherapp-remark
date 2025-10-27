import 'package:freezed_annotation/freezed_annotation.dart';
part 'student_body.g.dart';
part 'student_body.freezed.dart';

@freezed
abstract class StudentBody with _$StudentBody {
  const factory StudentBody({
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "class_id") String? classID,
    @JsonKey(name: "section_id") String? sectionID,
    @JsonKey(name: "only_date") String? onlyDate,
    @JsonKey(name: "short_name") String? shortName,
  }) = _StudentBody;

  factory StudentBody.fromJson(Map<String, dynamic> json) =>
      _$StudentBodyFromJson(json);
}
