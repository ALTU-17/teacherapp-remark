// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calender_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalenderBody _$CalenderBodyFromJson(Map<String, dynamic> json) =>
    _CalenderBody(
      shortName: json['short_name'] as String?,
      academicYr: json['academic_yr'] as String?,
      regId: json['reg_id'] as String?,
      month: json['month'] as String?,
      sectionName: json['section_name'] as String?,
      year: json['year'] as String?,
    );

Map<String, dynamic> _$CalenderBodyToJson(_CalenderBody instance) =>
    <String, dynamic>{
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.regId case final value?) 'reg_id': value,
      if (instance.month case final value?) 'month': value,
      if (instance.sectionName case final value?) 'section_name': value,
      if (instance.year case final value?) 'year': value,
    };
