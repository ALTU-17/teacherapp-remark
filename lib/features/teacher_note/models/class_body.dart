// academic_yr:2025-2026
// class_id:132
// section_id:521
// only_date:2025-05-12
// short_name:SACS

import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_body.freezed.dart';
part 'class_body.g.dart';

@freezed
abstract class ClassBody with _$ClassBody {
  const factory ClassBody({
    @JsonKey(name: 'academic_yr') required String academicYr,
    @JsonKey(name: 'class_id') required String classId,
    @JsonKey(name: 'section_id') required String sectionId,
    @JsonKey(name: 'only_date') required String onlyDate,
    @JsonKey(name: 'short_name') required String shortName,
  }) = _ClassBody;

  factory ClassBody.fromJson(Map<String, dynamic> json) =>
      _$ClassBodyFromJson(json);
}
