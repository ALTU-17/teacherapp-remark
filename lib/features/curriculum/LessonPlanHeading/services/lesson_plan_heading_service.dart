import 'package:dio/dio.dart';
import '../../../auth/models/models.dart';
import '../model/lesson_plan_heading.dart'; // For auth

class LessonPlanHeadingService {
  final Dio apiClient;
  final String baseUrl;

  LessonPlanHeadingService(this.apiClient, this.baseUrl);

  Future<List<LessonPlanHeading>> getHeadings(String shortName) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}CurriculumApi/get_lesson_plan_heading',
        data: FormData.fromMap({'short_name': shortName}),
      );
      if (response.statusCode == 200 && response.data['status'] == true) {
        return (response.data['lph_list'] as List)
            .map((e) => LessonPlanHeading.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Error loading headings: $e');
    }
  }

  Future<Map<String, dynamic>> createHeading({
    required String sequence,
    required String name,
    required String shortName,
    required bool changeDaily,
  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}CurriculumApi/lesson_plan_heading',
        data: FormData.fromMap({
          'sequence': sequence,
          'operation': 'create',
          'name': name,
          'short_name': shortName,
          'change_daily': changeDaily ? 'Y' : '',
        }),
      );
      return response.data;
    } catch (e) {
      return {'status': false, 'error_msg': e.toString()};
    }
  }

  Future<Map<String, dynamic>> editHeading({
    required String id,
    required String sequence,
    required String name,
    required String shortName,
    required bool changeDaily,
  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}CurriculumApi/lesson_plan_heading',
        data: FormData.fromMap({
          'lesson_plan_headings_id': id,
          'sequence': sequence,
          'operation': 'edit',
          'name': name,
          'short_name': shortName,
          'change_daily': changeDaily ? 'Y' : '',
        }),
      );
      return response.data;
    } catch (e) {
      return {'status': false, 'error_msg': e.toString()};
    }
  }



  Future<bool> deleteHeading({
    required String shortName,
    required String id,
  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}CurriculumApi/lesson_plan_heading',
        data: FormData.fromMap({
          'short_name': shortName,
          'lesson_plan_headings_id': id,
          'operation': 'delete',
        }),
      );
      return response.statusCode == 200 && response.data['status'] == true;
    } catch (e) {
      return false;
    }
  }
}
