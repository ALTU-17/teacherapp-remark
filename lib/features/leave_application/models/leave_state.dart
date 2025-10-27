import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teacherapp/features/leave_application/models/models.dart';
part 'leave_state.freezed.dart';

// Freezed model for Leave
@freezed
abstract class LeaveState with _$LeaveState {
  const factory LeaveState({
    @Default([]) List<Leave> leaves,
    @Default([]) List<LeaveBalance> leavesBalance,
  }) = _LeaveState;
}
