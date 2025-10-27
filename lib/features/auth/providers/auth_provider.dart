import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import '../../../providers/provider.dart';
import '../models/models.dart';
import '../services/services.dart';
part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  late AuthService _authService;
  @override
  //user check here
  Future<TeacherUser> build() async {
    final api = await ref.read(apiClientProvider.future);
    _authService = AuthService(api);
    final u = _authService.getCachedUser();
    if (u == null) return TeacherUser();
    return u;
  }

  Future<bool> validateTeacher(String userID) async {
    final res = await _authService.validateTeacher(userID);
    state = AsyncData(TeacherUser(teacherVerification: res));
    return true;
  }

  Future<void> login(String password) async {
    final res = await _authService.logInUser(password);

    if (res == null) return;
    Utils.debLog(res.toJson());
    state = AsyncData(res);
  }

  Future<void> refreshUser() async {
    final year = ref.read(academicYearProvider).requireValue.selectedYear;
    final res = await _authService.refreshUser(year);
    if (res == null) return;
    state = AsyncData(res);
  }

  Future<bool> changePassword(ForgotPBody b) async {
    final res = await _authService.changePassword(b);
    // if (res) {
    //   return await logOut();
    // }
    return res;
    // Utils.debLog(b.toJson());
    // return true;
  }

  Future<String?> restPassword(ResetPBody b) async {
    final res = await _authService.resetPassword(b);

    return res;
  }

  Future<void> logOut() async {
    await _authService.logout();

    state = AsyncData(TeacherUser());
  }

  Future<TeacherUser?> profileUpdate(TeacherDetails teacherDetails) async {
    final res = await _authService.profileUpdate(teacherDetails);
    if (res != null) state = AsyncData(res);
    return res;
  }

  Future profileImageUpload(File image) async {
    final res = await _authService.profileImageUpload(image);
    //if (res) ref.invalidateSelf();
  }

  Future<void> onRecivePassword() async {
    final res = await _authService.onRecivePassword();
  }
}
