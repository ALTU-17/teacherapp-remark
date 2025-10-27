// To parse this JSON data, do
//
//     final leave = leaveFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave.freezed.dart';
part 'leave.g.dart';

@freezed
abstract class Leave with _$Leave {
  const factory Leave({
    @JsonKey(name: "leave_app_id") String? leaveAppId,
    @JsonKey(name: "staff_id") String? staffId,
    @JsonKey(name: "leave_type_id") String? leaveTypeId,
    @JsonKey(name: "leave_start_date") String? leaveStartDate,
    @JsonKey(name: "leave_end_date") String? leaveEndDate,
    @JsonKey(name: "no_of_days") String? noOfDays,
    @JsonKey(name: "approved_by") String? approvedBy,
    @JsonKey(name: "status") String? status,
    @JsonKey(name: "reason") String? reason,
    @JsonKey(name: "reason_for_rejection") String? reasonForRejection,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "created_at") String? createdAt,
    @JsonKey(name: "updated_at") String? updatedAt,
    @JsonKey(name: "name") String? name,
  }) = _Leave;

  factory Leave.fromJson(Map<String, dynamic> json) => _$LeaveFromJson(json);
}
