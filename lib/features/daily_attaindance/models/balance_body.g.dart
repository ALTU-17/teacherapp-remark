// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BalanceBody _$BalanceBodyFromJson(Map<String, dynamic> json) => _BalanceBody(
      acdYr: json['acd_yr'] as String,
      regId: json['reg_id'] as String,
      shortName: json['short_name'] as String,
    );

Map<String, dynamic> _$BalanceBodyToJson(_BalanceBody instance) =>
    <String, dynamic>{
      'acd_yr': instance.acdYr,
      'reg_id': instance.regId,
      'short_name': instance.shortName,
    };
