import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/models.dart';

class ClasssService {
  final Dio apiClient;
  final String baseUrl;
  late final Box<TeacherUser> userBox;
  ClasssService(this.apiClient, this.baseUrl)
      : userBox = Hive.box('teacherUserCache');
  Future<List<ClassInfo>> getClasses(String accYear) async {
    final cachedUser = getCachedUser();
    if (cachedUser == null) {
      Utils.toast("No cached user found");
      return [];
    }

    final verification = cachedUser.teacherVerification;
    final regId = cachedUser.regId;
    if (!_hasRequiredVerificationData(verification)) {
      Utils.toast("Incomplete user verification data");
      return [];
    }

    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_class_for_daily_attendance',
        data: FormData.fromMap({
          'academic_yr': accYear,
          'short_name': verification?.shortName,
          'reg_id': regId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['class_name'];
          return data.map((item) => ClassInfo.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        Utils.debLog('Failed to load classes applications');
        return [];
      }
    } catch (e) {
      Utils.debLog('Error: $e');
      return [];
    }
  }

  TeacherUser? getCachedUser() => userBox.get('teacherUserCache');

  bool _hasRequiredVerificationData(TeacherVerification? verification) =>
      verification != null;
}
