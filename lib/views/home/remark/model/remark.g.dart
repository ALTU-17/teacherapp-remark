// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Remark _$RemarkFromJson(Map<String, dynamic> json) => _Remark(
      remarkId: json['remark_id'] as String,
      remarkDesc: json['remark_desc'] as String,
      remarkSubject: json['remark_subject'] as String,
      remarkType: json['remark_type'] as String,
      remarkDate: json['remark_date'] as String,
      className: json['class_name'] as String,
      secName: json['sec_name'] as String,
      subName: json['sub_name'] as String,
      firstName: json['first_name'] as String,
      midName: json['mid_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$RemarkToJson(_Remark instance) => <String, dynamic>{
      'remark_id': instance.remarkId,
      'remark_desc': instance.remarkDesc,
      'remark_subject': instance.remarkSubject,
      'remark_type': instance.remarkType,
      'remark_date': instance.remarkDate,
      'class_name': instance.className,
      'sec_name': instance.secName,
      'sub_name': instance.subName,
      'first_name': instance.firstName,
      'mid_name': instance.midName,
      'last_name': instance.lastName,
    };
