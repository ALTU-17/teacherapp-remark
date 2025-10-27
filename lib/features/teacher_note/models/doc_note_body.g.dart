// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_note_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocNoteBody _$DocNoteBodyFromJson(Map<String, dynamic> json) => _DocNoteBody(
      noteId: json['note_id'] as String,
      dailynoteDate: json['dailynote_date'] as String?,
      shortName: json['short_name'] as String,
    );

Map<String, dynamic> _$DocNoteBodyToJson(_DocNoteBody instance) =>
    <String, dynamic>{
      'note_id': instance.noteId,
      if (instance.dailynoteDate case final value?) 'dailynote_date': value,
      'short_name': instance.shortName,
    };
