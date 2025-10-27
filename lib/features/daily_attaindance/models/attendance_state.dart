import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:teacherapp/features/daily_attaindance/models/student.dart';
part 'attendance_state.freezed.dart';

@freezed
abstract class AttendanceState with _$AttendanceState {
  const factory AttendanceState({
    @Default([]) List<Students> students,
    @Default([]) List<Students> selectedStudents,
  }) = _AttendanceState;
}
