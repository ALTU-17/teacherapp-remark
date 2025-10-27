// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_delete_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteDeleteBody _$NoteDeleteBodyFromJson(Map<String, dynamic> json) =>
    _NoteDeleteBody(
      notesId: json['notes_id'] as String?,
      operation: json['operation'] as String? ?? 'delete',
      loginType: json['login_type'] as String? ?? 'T',
      shortName: json['short_name'] as String?,
    );

Map<String, dynamic> _$NoteDeleteBodyToJson(_NoteDeleteBody instance) =>
    <String, dynamic>{
      if (instance.notesId case final value?) 'notes_id': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.loginType case final value?) 'login_type': value,
      if (instance.shortName case final value?) 'short_name': value,
    };
