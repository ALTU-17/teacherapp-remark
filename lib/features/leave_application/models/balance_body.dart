//  'acd_yr': '2024-2025',
//           'reg_id': '14',
//           'short_name': 'SACS',

import 'package:freezed_annotation/freezed_annotation.dart';

part 'balance_body.freezed.dart';
part 'balance_body.g.dart';

// Freezed model for Leave
@freezed
abstract class BalanceBody with _$BalanceBody {
  const factory BalanceBody({
    @JsonKey(name: 'acd_yr') required String acdYr,
    @JsonKey(name: 'reg_id') required String regId,
    @JsonKey(name: 'short_name') required String shortName,
  }) = _BalanceBody;

  factory BalanceBody.fromJson(Map<String, dynamic> json) =>
      _$BalanceBodyFromJson(json);
}
