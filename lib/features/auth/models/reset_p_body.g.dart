// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_p_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResetPBody _$ResetPBodyFromJson(Map<String, dynamic> json) => _ResetPBody(
      shortName: json['short_name'] as String?,
      userId: json['user_id'] as String?,
      answerOne: json['answer_one'] as String?,
      dob: json['dob'] as String?,
      roleID: json['role_id'] as String? ?? 'T',
    );

Map<String, dynamic> _$ResetPBodyToJson(_ResetPBody instance) =>
    <String, dynamic>{
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.answerOne case final value?) 'answer_one': value,
      if (instance.dob case final value?) 'dob': value,
      if (instance.roleID case final value?) 'role_id': value,
    };
