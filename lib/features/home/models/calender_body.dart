import 'package:freezed_annotation/freezed_annotation.dart';

part 'calender_body.freezed.dart';
part 'calender_body.g.dart';

@freezed
abstract class CalenderBody with _$CalenderBody {
  const factory CalenderBody({
    @JsonKey(name: "short_name") String? shortName,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "reg_id") String? regId,
    @JsonKey(name: "month") String? month,
    @JsonKey(name: "section_name") String? sectionName,
    @JsonKey(name: "year") String? year,
  }) = _CalenderBody;

  factory CalenderBody.fromJson(Map<String, dynamic> json) =>
      _$CalenderBodyFromJson(json);
}
