import 'dart:io';
import 'package:hive_ce/hive.dart';
import 'package:dio/dio.dart';
import '../models/models.dart';
import 'package:teacherapp/config/utils.dart';

import '../models/school_details.dart';

class AuthService {
  final Dio apiClient;
  late final Box<TeacherUser> userBox;

  AuthService(this.apiClient) : userBox = Hive.box('teacherUserCache');

  Future<TeacherVerification> validateTeacher(String userId) async {
    final response = await apiClient.post(
      '/validate_teacher_user',
      data: FormData.fromMap({"user_id": userId}),
    );
    final verification =
    TeacherVerification.fromJson(response.data).copyWith(userId: userId);
    await userBox.put(
        "teacherUserCache", TeacherUser(teacherVerification: verification));
    return verification;
  }

  TeacherUser? getCachedUser() => userBox.get('teacherUserCache');

  Future<bool> logout() async {
    await userBox.delete("teacherUserCache");
    return true;
  }

  Future<bool> changePassword(ForgotPBody body) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return false;
    }
    final verification = cachedUser.teacherVerification;
    if (!_hasRequiredVerificationData(verification)) {
      Utils.toast("Incomplete user verification data");
      return false;
    }

    final url = '${verification!.teacherapkUrl}AdminApi/change_password';
    final fData = body.copyWith(
      userId: cachedUser.userId,
      shortName: cachedUser.teacherVerification?.shortName,
    );
    // Utils.debLog(fData.toJson());
    final response = await apiClient.post(
      url,

      // data: FormData.fromMap({
      //   "user_id": cachedUser.userId,
      // }),
      data: FormData.fromMap(fData.toJson()),
    );
    if (response.statusCode == 200) {
      if (response.data.toString().contains('error_msg')) {
        Utils.toast(response.data['error_msg']);
        return false;
      }
      return true;
    }

    return false;
  }

  Future<String?> resetPassword(ResetPBody body) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }
    final verification = cachedUser.teacherVerification;
    if (!_hasRequiredVerificationData(verification)) {
      Utils.toast("Incomplete user verification data");
      return null;
    }

    final url = '${verification!.teacherapkUrl}AdminApi/reset_password';
    final fData = body.copyWith(
      shortName: cachedUser.teacherVerification?.shortName,
    );
    Utils.debLog("Reset password request: ${fData.toJson()}");
    final response = await apiClient.post(
      url,
      data: FormData.fromMap(fData.toJson()),
    );
    if (response.statusCode == 200) {
      Utils.debLog("Reset password response: ${response.data}");
      if (response.data['status'] == false) {
        Utils.toast(response.data['message']);
        return null;
      }
      // Try different possible password fields in the response
      final password = response.data['password'] ??
          response.data['new_password'] ??
          response.data['reset_password'] ??
          response.data['generated_password'];

      if (password != null) {
        Utils.debLog("Found password in response: $password");
        return password;
      } else {
        Utils.debLog(
            "No password found in response. Available keys: ${response.data.keys.toList()}");
        // If no password field, return a default message
        return "Password has been reset. Please check your email or contact administrator.";
      }
    }
    return null;
  }

  Future<SchoolDetails?> getSchoolDetails() async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }
    final verification = cachedUser.teacherVerification;

    if (!_hasRequiredVerificationData(verification)) {
      Utils.toast("Incomplete user verification data");
      return null;
    }
    final shortName = verification?.shortName;

    final url = '${verification!.teacherapkUrl}AdminApi/get_settings_data';

    final response = await apiClient.post(
      url,

      data: FormData.fromMap({"shortName": shortName}),
      // data: FormData.fromMap(fData.toJson()),
    );
    if (response.statusCode == 200) {
      final data = response.data['acd_data'] as List<dynamic>;

      return SchoolDetails.fromJson(data.first);
    }

    return null;
  }

  Future<TeacherUser?> logInUser(String password) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }

    final verification = cachedUser.teacherVerification;
    if (!_hasRequiredVerificationData(verification)) {
      Utils.toast("Incomplete user verification data");
      return null;
    }

    final url = '${verification!.teacherapkUrl}LoginApi/login';
    try {
      final response = await apiClient.post(
        url,
        data: FormData.fromMap({
          "user_id": verification.userId,
          "password": password,
          "short_name": verification.shortName,
        }),
      );

      if (response.statusCode == 200) {
        if (response.data.toString().contains('error_msg')) {
          Utils.toast(response.data['error_msg']);
          return null;
        }

        Utils.toast("Login successful", true);
        final user = TeacherUser.fromJson(response.data)
            .copyWith(teacherVerification: verification);
        await userBox.put('teacherUserCache', user);

        final teacherDetails = await getTeacherDetails();
        final adminDetails = await getTeacherDetailFromAdmin();
        final punch = await getPunchInOut();

        final mergedDetails =
        adminDetails?.copyWith(classs: teacherDetails?.classs);
        final u = user.copyWith(teacherDetails: mergedDetails, punc: punch);
        await userBox.put('teacherUserCache', u);
        return u;
      }
    } catch (e) {
      Utils.toast("Login error: ${e.toString()}");
    }
    return null;
  }

  Future<TeacherUser?> refreshUser(String year) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }
    final teacherDetails = await getTeacherDetails(year);
    final adminDetails = await getTeacherDetailFromAdmin();
    final punch = await getPunchInOut();

    final mergedDetails = adminDetails?.copyWith(
      classs: teacherDetails?.classs ?? cachedUser.teacherDetails?.classs,
    );
    final u = cachedUser.copyWith(
      teacherDetails: mergedDetails,
      punc: punch,
    );
    final updated = u.copyWith(academicYr: year);
    await userBox.put('teacherUserCache', updated);
    return updated;
  }

  Future<TeacherUser?> profileUpdate(TeacherDetails teacherDetails) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }

    final verification = cachedUser.teacherVerification;
    final regId = cachedUser.regId;
    if (!_hasRequiredVerificationData(verification)) {
      Utils.toast("Incomplete user verification data");
      return null;
    }

    final url = '${verification!.teacherapkUrl}AdminApi/teachers';

    final moB = teacherDetails.copyWith(
      regId: regId,
      operation: 'update',
      shortName: verification.shortName,
    );
    try {
      final response = await apiClient.post(
        url,
        data: FormData.fromMap(moB.toJson()),
      );

      if (response.statusCode == 200) {
        if (response.data.toString().contains('error_msg')) {
          Utils.toast(response.data['error_msg']);
          return null;
        }
        Utils.toast("Profile Updated");
        final cUser = userBox.get('teacherUserCache');
        final profile = await getTeacherDetailFromAdmin();
        final user = cUser?.copyWith(teacherDetails: profile);
        if (user == null) return null;
        await userBox.put('teacherUserCache', user);
        return user;
      }
    } catch (e) {
      Utils.toast("Login error: ${e.toString()}");
    }
    return null;
  }

  Future<bool> profileImageUpload(File image) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return false;
    }

    final verification = cachedUser.teacherVerification;
    final regId = cachedUser.regId;
    if (!_hasRequiredVerificationData(verification)) {
      Utils.toast("Incomplete user verification data");
      return false;
    }

    final url = '${verification!.url}upload_teacher_profile_image_into_folder';
    final filename =
        "${cachedUser.userId}_$regId.${image.path.split(".").last}";
    String base64String = await Utils.fileToBase64(image);
    final sh = verification.shortName;
    try {
      final response = await apiClient.post(
        url,
        data: FormData.fromMap({
          "teacher_id": regId,
          "short_name": sh,
          "filename": filename,
          "doc_type_folder": "teacher_image",
          "filedata": base64String
        }),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      Utils.toast("Login error: ${e.toString()}");
    }
    return false;
  }

  Future<TeacherDetails?> getTeacherDetails([String? year]) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }

    final verification = cachedUser.teacherVerification;
    final academicYr = year ?? cachedUser.academicYr; //cachedUser.academicYr;
    final regId = cachedUser.regId;

    if (!_hasRequiredTeacherData(verification, academicYr, regId)) {
      Utils.toast("Missing required teacher data");
      return null;
    }

    final url = '${verification!.teacherapkUrl}AdminApi/get_teacher';
    try {
      final response = await apiClient.post(
        url,
        data: FormData.fromMap({
          "academic_yr": academicYr,
          "reg_id": regId,
          "short_name": verification.shortName,
        }),
      );

      if (response.statusCode == 200) {
        final x = TeacherDetails.fromJson(response.data);
        //   Utils.toast("Changed Academic Year", true);
        return x;
      }
      return null;
    } catch (e) {
      if (e.toString().contains('List<dynamic>?')) {
        //  Utils.toast("The current academic year is not active.");
        return null;
      }
      Utils.debLog(e.toString());
      return null;
    }
  }

  Future<TeacherDetails?> getTeacherDetailFromAdmin() async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }

    final verification = cachedUser.teacherVerification;
    final regId = cachedUser.regId;

    if (!_hasRequiredAdminData(verification, regId)) {
      Utils.toast("Missing required admin data");
      return null;
    }

    final url = '${verification!.teacherapkUrl}AdminApi/teachers';
    try {
      final response = await apiClient.post(
        url,
        data: FormData.fromMap({
          "reg_id": regId.toString(),
          "short_name": verification.shortName,
          "operation": "view",
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        final d = response.data['teachers_info'] as List<dynamic>;
        return TeacherDetails.fromJson(d.first);
      }
      Utils.toast("Failed to load admin teacher details");
      return null;
    } catch (e) {
      Utils.toast("Error fetching admin details: ${e.toString()}");
      return null;
    }
  }

  Future<PunchInOut?> getPunchInOut() async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return null;
    }

    final verification = cachedUser.teacherVerification;
    final regId = cachedUser.regId;

    if (!_hasRequiredPunchData(verification, regId)) {
      Utils.toast("Missing required punch data");
      return null;
    }

    final url = '${verification!.teacherapkUrl}AdminApi/get_punch_in_out_time';
    try {
      final response = await apiClient.post(
        url,
        data: FormData.fromMap({
          "reg_id": regId.toString(),
          "short_name": verification.shortName,
          "teacher_id": regId.toString(),
        }),
      );

      if (response.statusCode == 200 && response.data != null) {
        return PunchInOut.fromJson(response.data);
      }
      Utils.toast("Failed to fetch punch data");
    } catch (e) {
      Utils.toast("Error fetching punch data: ${e.toString()}");
    }
    return null;
  }

  Future onRecivePassword() async {
    try {
      final cachedUser = getCachedUser();
      if (cachedUser == null) {
        Utils.toast("No cached user found");
        return null;
      }

      final verification = cachedUser.teacherVerification;

      final userId = verification?.userId ?? "";

      final url = '${verification!.teacherapkUrl}LoginApi/receive_new_password';
      final response = await apiClient.post(
        url,
        data: FormData.fromMap({"user_id": userId}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Utils.toast(response.data['message']);
      }
      Utils.toast("Failed to fetch punch data");
      return;
    } catch (e) {
      return;
    }
  }

  bool _hasRequiredVerificationData(TeacherVerification? verification) =>
      verification != null;

  bool _hasRequiredTeacherData(TeacherVerification? verification,
      String? academicYr, String? regId) =>
      verification != null && academicYr != null && regId != null;

  bool _hasRequiredAdminData(
      TeacherVerification? verification, String? regId) =>
      verification != null && regId != null;

  bool _hasRequiredPunchData(
      TeacherVerification? verification, String? regId) =>
      verification != null && regId != null;
}