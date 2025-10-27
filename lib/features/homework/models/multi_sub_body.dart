// academic_yr:2025-2026
// reg_id:33
// short_name:SACS
// str_array:["136"^"539"]

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teacherapp/features/auth/models/models.dart';

part 'multi_sub_body.freezed.dart';
part 'multi_sub_body.g.dart';

@freezed
abstract class MultiSubBody with _$MultiSubBody {
  const factory MultiSubBody({
    @JsonKey(name: "academic_yr") required String academicYr,
    @JsonKey(name: "reg_id") required String regId,
    @JsonKey(name: "short_name") required String shortName,
    @JsonKey(name: "str_array") required List<ClassInfo> strArray,
  }) = _MultiSubBody;

  factory MultiSubBody.fromJson(Map<String, dynamic> json) =>
      _$MultiSubBodyFromJson(json);
}
