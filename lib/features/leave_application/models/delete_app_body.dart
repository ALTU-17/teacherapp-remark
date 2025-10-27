// body: {
//         'acd_yr': '2024-2025',
//         'staff_id': '14',
//         'short_name': 'SACS',
//       },

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_app_body.freezed.dart';
part 'delete_app_body.g.dart';

// Freezed model for Leave
@freezed
abstract class DeleteAppBody with _$DeleteAppBody {
  const factory DeleteAppBody({
    @JsonKey(name: 'leave_app_id') required String leaveAppId,
    @JsonKey(name: 'short_name') required String shortName,
    @Default('delete') String? operation,
  }) = _DeleteAppBody;

  factory DeleteAppBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteAppBodyFromJson(json);
}
