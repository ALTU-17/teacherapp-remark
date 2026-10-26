import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:teacherapp/features/home/views/teacher_id.dart';

import 'models.dart';

class LessonPlanTemplateApiService {
  Future<Map<String, String>> _getHeaders() async {
    final token = await getLaravelToken();
    return {
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  Future<String> _getBaseUrl() async {
    final baseUrl = await getLaravelBaseUrl();
    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('Laravel base URL missing');
    }
    return baseUrl;
  }

  Future<Map<String, dynamic>> _getJson(String pathWithQuery) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl$pathWithQuery'),
      headers: headers,
    );

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid server response');
    }

    if (response.statusCode >= 500) {
      throw Exception(decoded['message']?.toString() ?? 'Server error');
    }

    return decoded;
  }

  Future<Map<String, dynamic>> _deleteJson(String pathWithQuery) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();
    _logWriteRequest('DELETE', pathWithQuery);
    final response = await http.delete(
      Uri.parse('$baseUrl$pathWithQuery'),
      headers: headers,
    );
    _logWriteResponse('DELETE', pathWithQuery, response);

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid server response');
    }

    if (response.statusCode >= 500) {
      throw Exception(decoded['message']?.toString() ?? 'Server error');
    }

    return decoded;
  }

  Future<Map<String, dynamic>> _postJson(
    String pathWithQuery,
    Map<String, dynamic> payload,
  ) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();
    _logWriteRequest('POST', pathWithQuery, payload: payload);
    final response = await http.post(
      Uri.parse('$baseUrl$pathWithQuery'),
      headers: headers,
      body: jsonEncode(payload),
    );
    _logWriteResponse('POST', pathWithQuery, response);

    return _decodeWriteResponse(response);
  }

  Future<Map<String, dynamic>> _putJson(
    String pathWithQuery,
    Map<String, dynamic> payload,
  ) async {
    final baseUrl = await _getBaseUrl();
    final headers = await _getHeaders();
    _logWriteRequest('PUT', pathWithQuery, payload: payload);
    final response = await http.put(
      Uri.parse('$baseUrl$pathWithQuery'),
      headers: headers,
      body: jsonEncode(payload),
    );
    _logWriteResponse('PUT', pathWithQuery, response);

    return _decodeWriteResponse(response);
  }

  void _logWriteRequest(
    String method,
    String pathWithQuery, {
    Map<String, dynamic>? payload,
  }) {
    developer.log(
      payload == null
          ? '$method $pathWithQuery'
          : '$method $pathWithQuery\npayload: ${jsonEncode(payload)}',
      name: 'LPT API',
    );
  }

  void _logWriteResponse(
    String method,
    String pathWithQuery,
    http.Response response,
  ) {
    developer.log(
      '$method $pathWithQuery\nstatus: ${response.statusCode}\nresponse: ${response.body}',
      name: 'LPT API',
    );
  }

  Map<String, dynamic> _decodeWriteResponse(http.Response response) {
    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid server response');
    }

    if (response.statusCode >= 500) {
      throw Exception(decoded['message']?.toString() ?? 'Server error');
    }

    return decoded;
  }

  Future<List<TemplateRecord>> getTemplateList({String status = 'All'}) async {
    final json = await _getJson(
      'get_lesson_plan_template_list?status=${Uri.encodeQueryComponent(status)}',
    );
    final data = json['data'];

    if (json['success'] == true && data is List) {
      log('get_lesson_plan_template_list Response body: $data');

      return TemplateRecord.fromApiRows(data);
    }

    throw Exception(json['message']?.toString() ?? 'Failed to load templates');
  }

  Future<List<TemplateClass>> getClasses({required String teacherId}) async {
    final json = await _getJson(
      'get_only_classes_allotted_to_teacher?teacher_id=${Uri.encodeQueryComponent(teacherId)}',
    );
    final data = json['data'];
    if (json['success'] == true && data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(TemplateClass.fromJson)
          .toList();
    }
    return [];
  }

  Future<List<TemplateSubject>> getSubjects({required int classId}) async {
    final json =
        await _getJson('get_subjects_according_class?class_id=$classId');
    final data = json['data'];
    if (json['success'] == true && data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(TemplateSubject.fromJson)
          .toList();
    }
    return [];
  }

  Future<List<TemplateChapter>> getChapters({
    required int classId,
    required int subjectId,
  }) async {
    final json = await _getJson(
      'get_chapter_info_class_sub_id?class_id=$classId&subject_id=$subjectId',
    );
    final data = json['data'];
    if (json['success'] == true && data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(TemplateChapter.fromJson)
          .toList();
    }
    return [];
  }

  Future<TemplateLookupResult> getTemplate({
    required int classId,
    required int subjectId,
    required int chapterId,
    required String regId,
  }) async {
    final json = await _getJson(
      'get_lesson_plan_template?class_id=$classId&subject_id=$subjectId&chapter_id=$chapterId&reg_id=${Uri.encodeQueryComponent(regId)}',
    );
    return TemplateLookupResult.fromJson(json);
  }

  Future<TemplateEditDetailsResult> getTemplateById({
    required int classId,
    required int subjectId,
    required int chapterId,
    required int templateId,
  }) async {
    final json = await _getJson(
      'get_lesson_plan_template_id?class_id=$classId&subject_id=$subjectId&chapter_id=$chapterId&les_pln_temp_id=$templateId',
    );
    final data = json['data'];
    if (json['success'] == true && data is List && data.isNotEmpty) {
      final first = data.first;
      if (first is Map<String, dynamic>) {
        return TemplateEditDetailsResult.fromJson(first);
      }
    }
    throw Exception(
      json['message']?.toString() ?? 'Failed to load template details',
    );
  }

  Future<List<TemplateHeading>> getNonDailyHeadings() async {
    final json = await _getJson('get_lesson_plan_heading_non_daily');
    final data = json['data'];
    if (json['success'] == true && data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(TemplateHeading.fromJson)
          .toList();
    }
    throw Exception(json['message']?.toString() ?? 'Failed to load headings');
  }

  Future<String> deleteTemplate({required int templateId}) async {
    final json = await _deleteJson('delete_lesson_plan_template/$templateId');
    if (json['success'] == true) {
      return json['message']?.toString() ?? 'Lesson plan template deleted.';
    }
    throw Exception(json['message']?.toString() ?? 'Failed to delete template');
  }

  Future<String> saveTemplate({
    required int classId,
    required int subjectId,
    required int chapterId,
    required List<Map<String, dynamic>> descriptions,
    required bool publish,
  }) async {
    final endpoint =
        publish ? 'savenpublish_lessonplantemplate' : 'save_lessonplantemplate';
    final json = await _postJson(endpoint, {
      'class_id': classId,
      'subject_id': subjectId,
      'chapter_id': chapterId,
      'descriptions': descriptions,
    });

    if (json['success'] == true) {
      return json['message']?.toString() ??
          'Lesson Plan Template Created Successfully!';
    }
    throw Exception(json['message']?.toString() ?? 'Failed to save template');
  }

  Future<String> updateTemplate({
    required int templateId,
    required int classId,
    required int subjectId,
    required int chapterId,
    required List<Map<String, dynamic>> descriptions,
    required bool publish,
  }) async {
    final endpoint = publish
        ? 'updatepublish_lessonplan_template/$templateId'
        : 'update_lessonplan_template/$templateId';
    final json = await _putJson(endpoint, {
      'class_id': classId,
      'subject_id': subjectId,
      'chapter_id': chapterId,
      'descriptions': descriptions,
    });

    if (json['success'] == true) {
      return json['message']?.toString() ??
          'Lesson Plan Template Updated Successfully!';
    }
    throw Exception(json['message']?.toString() ?? 'Failed to update template');
  }
}
