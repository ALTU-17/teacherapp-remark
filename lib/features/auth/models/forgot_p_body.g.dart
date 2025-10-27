// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_p_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ForgotPBody _$ForgotPBodyFromJson(Map<String, dynamic> json) => _ForgotPBody(
      shortName: json['short_name'] as String?,
      userId: json['user_id'] as String?,
      answerOne: json['answerone'] as String?,
      passwordRe: json['password_re'] as String?,
      passwordOld: json['password_old'] as String?,
      passwordNew: json['password_new'] as String?,
    );

Map<String, dynamic> _$ForgotPBodyToJson(_ForgotPBody instance) =>
    <String, dynamic>{
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.answerOne case final value?) 'answerone': value,
      if (instance.passwordRe case final value?) 'password_re': value,
      if (instance.passwordOld case final value?) 'password_old': value,
      if (instance.passwordNew case final value?) 'password_new': value,
    };
