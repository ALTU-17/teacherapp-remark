// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_documnet_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeleteDocumentBody _$DeleteDocumentBodyFromJson(Map<String, dynamic> json) =>
    _DeleteDocumentBody(
      uploadDate: json['upload_date'] as String?,
      randomNo: json['random_no'] as String?,
      shortName: json['short_name'] as String?,
      docTypeFolder: json['doc_type_folder'] as String?,
      filename: json['filename'] as String?,
    );

Map<String, dynamic> _$DeleteDocumentBodyToJson(_DeleteDocumentBody instance) =>
    <String, dynamic>{
      if (instance.uploadDate case final value?) 'upload_date': value,
      if (instance.randomNo case final value?) 'random_no': value,
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.docTypeFolder case final value?) 'doc_type_folder': value,
      if (instance.filename case final value?) 'filename': value,
    };
