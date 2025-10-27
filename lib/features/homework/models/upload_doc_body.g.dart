// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_doc_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadDocBody _$UploadDocBodyFromJson(Map<String, dynamic> json) =>
    _UploadDocBody(
      uploadDate: json['upload_date'] as String?,
      homeworkId: json['homework_id'] as String?,
      randomNo: json['random_no'] as String? ?? '1',
      shortName: json['short_name'] as String?,
      docTypeFolder: json['doc_type_folder'] as String? ?? 'homework',
      filename: json['filename'] as String?,
      datafile: json['datafile'] as String?,
    );

Map<String, dynamic> _$UploadDocBodyToJson(_UploadDocBody instance) =>
    <String, dynamic>{
      if (instance.uploadDate case final value?) 'upload_date': value,
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.randomNo case final value?) 'random_no': value,
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.docTypeFolder case final value?) 'doc_type_folder': value,
      if (instance.filename case final value?) 'filename': value,
      if (instance.datafile case final value?) 'datafile': value,
    };
