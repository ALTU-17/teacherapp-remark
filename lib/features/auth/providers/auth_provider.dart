import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import '../../../config/config.dart';
import '../../../providers/provider.dart';
import '../../home/views/teacher_id.dart';
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

  Future<String?> getLaravelBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('laravel_base_url');
  }

  Future<void> login(String password) async {
    state = const AsyncLoading();

    final user = await _authService.logInUser(password);
    if (user == null) {
      state = AsyncError("Login failed", StackTrace.current);
      return;
    }

    // 🔥 AFTER EXISTING LOGIN SUCCESS
    final verification = user.teacherVerification!;
    final laravelBaseUrl =  await getLaravelBaseUrl();
    print('Laravel Login URL: ${laravelBaseUrl}login');

    if (laravelBaseUrl != null) {
      final token = await _authService.loginLaravelAndGetToken(
        userId: verification.userId,
        password: password,
        shortName: verification.shortName,
        laravelBaseUrl: laravelBaseUrl,
      );

      if (token != null) {
        await ref
            .read(appConfigProvider.notifier)
            .setLaravelToken(token);
      }
    }

    state = AsyncData(user);
    ref.invalidate(teacherProvider);
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

    // 🔥 CLEAR AUTH STATE
    state = const AsyncData(TeacherUser());

    // 🔥 FORCE RESET ALL DEPENDENT PROVIDERS
    ref.invalidate(teacherProvider);
    ref.invalidate(staffApiProvider);
    ref.invalidateSelf();
  }

  Future<TeacherUser?> profileUpdate(TeacherDetails teacherDetails) async {
    final res = await _authService.profileUpdate(teacherDetails);
    if (res != null) state = AsyncData(res);
    return res;
  }

  Future<void> refreshTeacherFromLaravel(Teacher teacher) async {
    state = AsyncData(
      state.requireValue.copyWith(
        teacherDetails: state.requireValue.teacherDetails?.copyWith(
          phone: teacher.phone,
          bloodGroup: teacher.bloodGroup,
          address: teacher.address,
          // permanentAddress: teacher.permanentAddress,
        ),
      ),
    );
  }




  Future profileImageUpload(File image) async {
    final res = await _authService.profileImageUpload(image);
    //if (res) ref.invalidateSelf();
  }

  Future<void> onRecivePassword() async {
    final res = await _authService.onRecivePassword();
  }
}
class AuthState {
  final TeacherDetails? teacherDetails;
  final TeacherVerification? teacherVerification;
  final String? regId;

  AuthState({
    this.teacherDetails,
    this.teacherVerification,
    this.regId,
  });

  AuthState copyWith({
    TeacherDetails? teacherDetails,
  }) {
    return AuthState(
      teacherDetails: teacherDetails ?? this.teacherDetails,
      teacherVerification: teacherVerification,
      regId: regId,
    );
  }
}
class TeacherDetails1 {
  final String? phone;
  final String? bloodGroup;
  final String? address;
  final String? permanentAddress;

  TeacherDetails1({
    this.phone,
    this.bloodGroup,
    this.address,
    this.permanentAddress,
  });

  TeacherDetails1 copyWith({
    String? phone,
    String? bloodGroup,
    String? address,
    String? permanentAddress,
  }) {
    return TeacherDetails1(
      phone: phone ?? this.phone,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      address: address ?? this.address,
      permanentAddress: permanentAddress ?? this.permanentAddress,
    );
  }
}
