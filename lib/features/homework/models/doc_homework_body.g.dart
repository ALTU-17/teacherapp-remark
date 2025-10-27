// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_homework_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocHomeworkBody _$DocHomeworkBodyFromJson(Map<String, dynamic> json) =>
    _DocHomeworkBody(
      homeworkId: json['homework_id'] as String,
      homeworkDate: json['homework_date'] as String,
      shortName: json['short_name'] as String,
    );

Map<String, dynamic> _$DocHomeworkBodyToJson(_DocHomeworkBody instance) =>
    <String, dynamic>{
      'homework_id': instance.homeworkId,
      'homework_date': instance.homeworkDate,
      'short_name': instance.shortName,
    };
