import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_balance.freezed.dart';
part 'leave_balance.g.dart';

@freezed
abstract class LeaveBalance with _$LeaveBalance {
  const factory LeaveBalance({
    @JsonKey(name: "leave_type_id") String? leaveTypeId,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "staff_id") String? staffId,
    @JsonKey(name: "leaves_allocated") String? leavesAllocated,
    @JsonKey(name: "leaves_availed") String? leavesAvailed,
  }) = _LeaveBalance;

  factory LeaveBalance.fromJson(Map<String, dynamic> json) =>
      _$LeaveBalanceFromJson(json);
}
