// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SchoolDetails _$SchoolDetailsFromJson(Map<String, dynamic> json) =>
    _SchoolDetails(
      settingId: json['setting_id'] as String?,
      instituteName: json['institute_name'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phone_number'] as String?,
      pageTitle: json['page_title'] as String?,
      pageMetaTag: json['page_meta_tag'] as String?,
      academicYrFrom: json['academic_yr_from'] == null
          ? null
          : DateTime.parse(json['academic_yr_from'] as String),
      academicYrTo: json['academic_yr_to'] == null
          ? null
          : DateTime.parse(json['academic_yr_to'] as String),
      academicYr: json['academic_yr'] as String?,
      active: json['active'] as String?,
    );

Map<String, dynamic> _$SchoolDetailsToJson(_SchoolDetails instance) =>
    <String, dynamic>{
      if (instance.settingId case final value?) 'setting_id': value,
      if (instance.instituteName case final value?) 'institute_name': value,
      if (instance.address case final value?) 'address': value,
      if (instance.phoneNumber case final value?) 'phone_number': value,
      if (instance.pageTitle case final value?) 'page_title': value,
      if (instance.pageMetaTag case final value?) 'page_meta_tag': value,
      if (instance.academicYrFrom?.toIso8601String() case final value?)
        'academic_yr_from': value,
      if (instance.academicYrTo?.toIso8601String() case final value?)
        'academic_yr_to': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.active case final value?) 'active': value,
    };
