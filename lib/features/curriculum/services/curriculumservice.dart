// services/curriculum_service.dart
import 'package:dio/dio.dart';
import 'package:hive_ce/hive.dart';
import '../../auth/models/teacher_user.dart';
import '../models/curriculum_role_info.dart';

class CurriculumService {
  final Dio apiClient;
  final String baseUrl;
  late final Box<TeacherUser> userBox;

  CurriculumService(this.apiClient, this.baseUrl)
      : userBox = Hive.box('teacherUserCache');

  Future<CurriculumRoleInfo?> getRoleInfo() async {
    try {
      final cachedUser = userBox.get('teacherUserCache');
      if (cachedUser == null) return null;

      final verification = cachedUser.teacherVerification;
      final regId = cachedUser.regId;
      final academicYr = cachedUser.academicYr;
      final name = verification?.shortName;

      if (name == null || regId == null || academicYr == null) return null;

      final response = await apiClient.post(
        '${baseUrl}CurriculumApi/get_allot_specialrole',
        data: FormData.fromMap({
          'short_name': name,
          'teacher_id': regId,
          'academic_yr': academicYr,
          'role': 'curri coordinator',
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final roles = jsonResponse['role'] as List<dynamic>?;

          // Find the curri coordinator role
          if (roles != null) {
            for (var roleData in roles) {
              if (roleData['role'] == 'curri coordinator') {
                return CurriculumRoleInfo.fromJson(roleData);
              }
            }
          }
        }
      }
      return null;
    } catch (e) {
      print('Error getting role info: $e');
      return null;
    }
  }
}