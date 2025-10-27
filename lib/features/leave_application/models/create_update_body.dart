//  'leave_type_id': leaveTypeId,
//           'start_date': startDate,
//           'end_date': endDate,
//           'no_of_days': noOfDays,
//           'status': 'A', // Applied
//           'reason_rejection': '',
//           'staff_id': '14',
//           'acd_yr': '2024-2025',
//           'operation': 'create',
//           'reason': reason,
//           'short_name': 'SACS',

import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_update_body.freezed.dart';
part 'create_update_body.g.dart';

// Freezed model for Leave
@freezed
abstract class CreateUpdateBody with _$CreateUpdateBody {
  const factory CreateUpdateBody({
    @JsonKey(name: 'leave_app_id') String? leaveAppId,
    @JsonKey(name: 'leave_type_id') String? leaveTypeId,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
    @JsonKey(name: 'no_of_days') String? noOfDays,
    @Default('A') @JsonKey(name: 'status') String? status,
    @Default('') @JsonKey(name: 'reason_rejection') String? resonRejection,
    @JsonKey(name: 'staff_id') String? staffId,
    @JsonKey(name: 'acd_yr') String? acdYr,
    @Default('create')
    @JsonKey(name: 'operation')
    String? operation, //TODO REMEMBER TO CHANGE TO UPDATE
    @JsonKey(name: 'reason') String? reason,
    @JsonKey(name: 'short_name') String? shortName,
  }) = _CreateUpdateBody;

  factory CreateUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$CreateUpdateBodyFromJson(json);
}
