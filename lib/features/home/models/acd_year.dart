import 'package:freezed_annotation/freezed_annotation.dart';

part 'acd_year.freezed.dart';
part 'acd_year.g.dart';

@freezed
abstract class AcdYear with _$AcdYear {
  const factory AcdYear({
    @JsonKey(name: "academic_yr") String? academicYr,
  }) = _AcdYear;

  factory AcdYear.fromJson(Map<String, dynamic> json) =>
      _$AcdYearFromJson(json);
}
