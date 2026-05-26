// lib/services/api_service.dart

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../../home/views/teacher_id.dart';
import '../models/lesson_plan_models.dart';

class ApiService {
  final Dio? dio;

  ApiService({this.dio});

  Future<Map<String, String>> _getHeaders() async {
    final token = await getLaravelToken();
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<String?> _getBaseUrl() async {
    return await getLaravelBaseUrl();
  }

  // Get classes by unique ID https://sms.evolvu.in/arnolds_test/public/api/get_teacherclasseswithclassteacher?teacher_id=33
  Future<ClassResponse> getClassesByUnqId({required String teacherId}) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse('${baseUrl}get_teacherclasseswithclassteacher?teacher_id=$teacherId'),
      headers: headers,
    );

    print('get_teacherclasseswithclassteacher Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load classes: ${response.statusCode}');
    }

    return ClassResponse.fromJson(jsonDecode(response.body));
  }

  // In api_service.dart, update the method

  Future<TeacherClassResponse> getClassesByTeacherId({required String teacherId}) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse('${baseUrl}get_teacherclasseswithclassteacher?teacher_id=$teacherId'),
      headers: headers,
    );

    print('get_teacherclasseswithclassteacher Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load classes: ${response.statusCode}');
    }

    return TeacherClassResponse.fromJson(jsonDecode(response.body));
  }

  Future<ChapterResponse> getChapterInfoByClassAndSubject({
    required int classId,
    required int subjectId,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse('${baseUrl}get_chapter_info_class_sub_id?class_id=$classId&subject_id=$subjectId'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load chapters: ${response.statusCode}');
    }

    return ChapterResponse.fromJson(jsonDecode(response.body));
  }

  // Get subjects according to class and sections
  Future<SubjectResponse> getSubjectsByClassAndSections({
    required int classId,
    required List<int> sectionIds,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final queryParams = StringBuffer();
    queryParams.write('class_id=$classId');
    for (var id in sectionIds) {
      queryParams.write('&section_ids[]=$id');
    }

    final response = await http.get(
      Uri.parse('${baseUrl}get_subjects_according_class_multiple?$queryParams'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load subjects: ${response.statusCode}');
    }

    return SubjectResponse.fromJson(jsonDecode(response.body));
  }

  // Get sub-subjects by class and subject
  Future<SubSubjectResponse> getSubSubjectsByClassAndSubject({
    required int classId,
    required int subjectId,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse('${baseUrl}get_subsubject_by_class_sub?class_id=$classId&subject_id=$subjectId'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load sub-subjects: ${response.statusCode}');
    }

    return SubSubjectResponse.fromJson(jsonDecode(response.body));
  }

  // Get lesson plan
  Future<LessonPlanResponse> getLessonPlan({
    required int classId,
    required int sectionId,
    required int smId,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse('${baseUrl}get_lesson_plan?class_id=$classId&section_id=$sectionId&sm_id=$smId'),
      headers: headers,
    );
    print('get_lesson_plan  Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load lesson plan: ${response.statusCode}');
    }

    return LessonPlanResponse.fromJson(jsonDecode(response.body));
  }



  Future<LessonPlanDetailsResponse> getLessonPlanDetails({
    required int classId,
    required int sectionId,
    required int smId,
    required int chapterId,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final classIdArray = '$classId^$sectionId';

    final response = await http.get(
      Uri.parse(
        '${baseUrl}get_lesson_plan_details'
            '?class_id=$classId'
            '&section_id=$sectionId'
            '&sm_id=$smId'
            '&chapter_id=$chapterId'
            '&class_id_array=${Uri.encodeComponent(classIdArray)}',
      ),
      headers: headers,
    );
    log('get_lesson_plan_details  Response body: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Failed to load lesson plan details: ${response.statusCode}');
    }

    return LessonPlanDetailsResponse.fromJson(jsonDecode(response.body));
  }
// In lp_api_service.dart
  Future<Map<String, dynamic>> getLessonPlanByUnqId(int unqId) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();
    try {
      final response = await http.get(
        Uri.parse('${baseUrl}get_lesson_plan_by_unq_id/$unqId'),
        headers: headers,
      );

      print('get_lesson_plan_by_unq_id Response status: ${response.statusCode}');
      print('get_lesson_plan_by_unq_id Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load lesson plan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getLessonPlanByUnqId: $e');
      throw Exception('Failed to load lesson plan: $e');
    }
  }
  Future<Map<String, dynamic>> saveLessonPlan({
    required Map<String, dynamic> payload,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.post(
      Uri.parse('${baseUrl}save_lesson_plan'),
      headers: headers,
      body: jsonEncode(payload),
    );

    print('save_lesson_plan response: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to save lesson plan: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  // DELETE lesson plan
  Future<Map<String, dynamic>> deleteLessonPlan({
    required int lessonPlanId,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.delete(
      Uri.parse('${baseUrl}delete_lesson_plan/$lessonPlanId'),
      headers: headers,
    );

    print('lessonPlanId in delete_lesson_plan response: ${lessonPlanId}');
    print('delete_lesson_plan response: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to delete lesson plan: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> updateLessonPlanStatus({
    required int lessonPlanId,
    required String? status,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.post(
      Uri.parse('${baseUrl}update_statusoflessonplan/$lessonPlanId'),
      headers: headers,
      body: jsonEncode({'status': status}),
    );

    print('update_statusoflessonplan response: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update status: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

// GET lesson plan headings non daily
  Future<LessonPlanHeadingNonDailyResponse> getLessonPlanHeadingNonDaily() async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.get(
      Uri.parse('${baseUrl}get_lesson_plan_heading_non_daily'),
      headers: headers,
    );

    print('get_lesson_plan_heading_non_daily response: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to load headings: ${response.statusCode}');
    }

    return LessonPlanHeadingNonDailyResponse.fromJson(jsonDecode(response.body));
  }

// PUT update lesson plan
  Future<Map<String, dynamic>> updateLessonPlan({
    required int unqId,
    required Map<String, dynamic> payload,
  }) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();

    final response = await http.put(
      Uri.parse('${baseUrl}update_lesson_plan/$unqId'),
      headers: headers,
      body: jsonEncode(payload),
    );

    print('update_lesson_plan response: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to update lesson plan: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

}