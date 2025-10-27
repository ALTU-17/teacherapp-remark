// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_doc_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UploadDocNote _$UploadDocNoteFromJson(Map<String, dynamic> json) =>
    _UploadDocNote(
      uploadDate: json['upload_date'] as String?,
      randomNo: json['random_no'] as String? ?? '1',
      shortName: json['short_name'] as String?,
      docTypeFolder: json['doc_type_folder'] as String? ?? 'daily_notes',
      filename: json['filename'] as String?,
      datafile: json['datafile'] as String?,
    );

Map<String, dynamic> _$UploadDocNoteToJson(_UploadDocNote instance) =>
    <String, dynamic>{
      if (instance.uploadDate case final value?) 'upload_date': value,
      if (instance.randomNo case final value?) 'random_no': value,
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.docTypeFolder case final value?) 'doc_type_folder': value,
      if (instance.filename case final value?) 'filename': value,
      if (instance.datafile case final value?) 'datafile': value,
    };
