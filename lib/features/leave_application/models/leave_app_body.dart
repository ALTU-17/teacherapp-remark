// body: {
//         'acd_yr': '2024-2025',
//         'staff_id': '14',
//         'short_name': 'SACS',
//       },

import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_app_body.freezed.dart';
part 'leave_app_body.g.dart';

// Freezed model for Leave
@freezed
abstract class LeaveAppBody with _$LeaveAppBody {
  const factory LeaveAppBody({
    @JsonKey(name: 'acd_yr') required String acdYr,
    @JsonKey(name: 'staff_id') required String staffId,
    @JsonKey(name: 'short_name') required String shortName,
  }) = _LeaveAppBody;

  factory LeaveAppBody.fromJson(Map<String, dynamic> json) =>
      _$LeaveAppBodyFromJson(json);
}
