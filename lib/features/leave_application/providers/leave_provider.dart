import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/auth.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/leave_application/models/models.dart';
import 'package:teacherapp/features/leave_application/services/leave_services.dart';
import 'package:teacherapp/providers/provider.dart';

import '../models/leave_state.dart';

part 'leave_provider.g.dart';

@Riverpod(keepAlive: false)
class LeaveP extends _$LeaveP {
  late LeaveService _leaveService;

  @override
  Future<LeaveState> build() async {
    final authData = _getAuthData();
    if (!authData.isValid) return LeaveState();

    final api = await ref.read(apiClientProvider.future);

    //.url is base url
    _leaveService = LeaveService(api, authData.url);

    final leaves = await _fetchLeaveApplications(authData);
    final leavesB = await _getBalanceLeave();
    return LeaveState(leaves: leaves, leavesBalance: leavesB);
  }

  Future<void> fetchLeaveApplications() async {
    final authData = _getAuthData();
    if (!authData.isValid) {
      state = const AsyncData(LeaveState());
      return;
    }
    final leaves = await _fetchLeaveApplications(authData);
    final leavesB = await _getBalanceLeave();
    state = AsyncData(LeaveState(leaves: leaves, leavesBalance: leavesB));
  }

  Future<void> deleteLeaveApplication(Leave leave) async {
    final authData = _getAuthData();
    if (!authData.isValid || leave.leaveAppId == null) return;

    final body = DeleteAppBody(
      leaveAppId: leave.leaveAppId!,
      shortName: authData.shortName,
    );
    await _leaveService.deleteLeaveApplication(body);
    await fetchLeaveApplications();
  }

  Future<bool> updateLeaveApplication(CreateUpdateBody body) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    final updatedBody = body.copyWith(
      shortName: authData.shortName,
      staffId: authData.regId,
      operation: 'edit',
      acdYr: authData.academicYr,
    );

    await _leaveService.updateLeaveApplication(updatedBody);
    // await fetchLeaveApplications();
    ref.invalidateSelf();
    return true;
  }

  Future<List<LeaveBalance>> _getBalanceLeave() async {
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final body = BalanceBody(
      acdYr: authData.academicYr, // authData.academicYr,
      regId: authData.regId,
      shortName: authData.shortName,
    );
    return await _leaveService.getBalanceLeave(body);
  }

  Future<bool> createLeaveApplication(CreateUpdateBody body) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    final updatedBody = body.copyWith(
      shortName: authData.shortName,
      staffId: authData.regId,
      acdYr: authData.academicYr,
    );
    Utils.debLog(updatedBody.toJson());
    await _leaveService.createLeaveApplication(updatedBody);
    //await fetchLeaveApplications();
    ref.invalidateSelf();
    return true;
  }

  AuthData _getAuthData() {
    final auth = ref.read(authProvider).requireValue;
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    return AuthData(
      shortName: auth.teacherVerification?.shortName ?? '',
      url: auth.teacherVerification?.teacherapkUrl ?? '',
      regId: auth.regId ?? '',
      academicYr: acdYear,
    );
  }

  Future<List<Leave>> _fetchLeaveApplications(AuthData authData) async {
    final body = LeaveAppBody(
      acdYr: authData.academicYr,
      staffId: authData.regId,
      shortName: authData.shortName,
    );
    return await _leaveService.fetchLeaveApplications(body);
  }
}
