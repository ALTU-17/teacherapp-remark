import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_details.freezed.dart';
part 'school_details.g.dart';

@freezed
abstract class SchoolDetails with _$SchoolDetails {
  const factory SchoolDetails({
    @JsonKey(name: "setting_id") String? settingId,
    @JsonKey(name: "institute_name") String? instituteName,
    @JsonKey(name: "address") String? address,
    @JsonKey(name: "phone_number") String? phoneNumber,
    @JsonKey(name: "page_title") String? pageTitle,
    @JsonKey(name: "page_meta_tag") String? pageMetaTag,
    @JsonKey(name: "academic_yr_from") DateTime? academicYrFrom,
    @JsonKey(name: "academic_yr_to") DateTime? academicYrTo,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "active") String? active,
  }) = _SchoolDetails;

  factory SchoolDetails.fromJson(Map<String, dynamic> json) =>
      _$SchoolDetailsFromJson(json);
}
