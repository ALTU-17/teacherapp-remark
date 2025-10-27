// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_sub_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MultiSubBody _$MultiSubBodyFromJson(Map<String, dynamic> json) =>
    _MultiSubBody(
      academicYr: json['academic_yr'] as String,
      regId: json['reg_id'] as String,
      shortName: json['short_name'] as String,
      strArray: (json['str_array'] as List<dynamic>)
          .map((e) => ClassInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MultiSubBodyToJson(_MultiSubBody instance) =>
    <String, dynamic>{
      'academic_yr': instance.academicYr,
      'reg_id': instance.regId,
      'short_name': instance.shortName,
      'str_array': instance.strArray,
    };
