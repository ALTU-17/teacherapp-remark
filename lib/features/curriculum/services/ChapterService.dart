import 'dart:convert';

import 'package:dio/dio.dart';
import '../models/chapter.dart';
import '../models/create_chapter_request.dart';

class ChapterService {
  final Dio apiClient;
  final String baseUrl;

  ChapterService(this.apiClient, this.baseUrl);

  Future<List<Chapter>> fetchChapters({
    required String shortName,
    required String teacherId,
    required String academicYr,
  }) async {
    final response = await apiClient.post(
      '${baseUrl}CurriculumApi/get_chapters',
      data: {
        'short_name': shortName,
        'academic_yr': academicYr,
        "reg_id": teacherId,
      },
    );

    final data = response.data;
    if (response.statusCode == 200 &&
        data is Map &&
        data['status'] == true &&
        data['chapters_list'] is List) {
      return (data['chapters_list'] as List)
          .map<Chapter>((json) => Chapter.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    throw Exception("Failed to load chapters");
  }

  Future<List<Map<String, String>>> getClasses({
    required String shortName,
    required String regId,
    required String academicYr,
  }) async {
    final res = await apiClient.post(
      '${baseUrl}CurriculumApi/get_class',
      data: {
        'short_name': shortName,
        'reg_id': regId,
        'academic_yr': academicYr,
      },
    );

    if (res.statusCode == 200 && res.data['status'] == true) {
      return (res.data['classes'] as List)
          .map((c) => {
        'class_id': c['class_id'].toString(),
        'class_name': c['class_name'].toString(),
      })
          .toList();
    }
    return [];
  }

  /// Fetch subjects for given class
  Future<List<Map<String, String>>> getSubjects({
    required String shortName,
    required String regId,
    required String academicYr,
    required String classId,
  }) async {
    final res = await apiClient.post(
      '${baseUrl}CurriculumApi/getSub_by_Class_teacheralloted',
      data: {
        'short_name': shortName,
        'reg_id': regId,
        'academic_yr': academicYr,
        'class_id': classId,
      },
    );

    if (res.statusCode == 200 && res.data['status'] == true) {
      return (res.data['classes'] as List)
          .map((s) => {
        'sm_id': s['sm_id'].toString(),
        'name': s['name'].toString(),
      })
          .toList();
    }
    return [];
  }

  /// Create or Save & Publish chapter
  Future<Map<String, dynamic>> createChapter({
    required String shortName,
    required String classId,
    required String lessonNumber,
    required String name,
    required String loginType,
    required String description,
    required String regId,
    required String smId,
    required bool publish,
    required String academicYr,
    String subSubject = '',
  }) async {
    final res = await apiClient.post(
      '${baseUrl}CurriculumApi/chapters',
      data: {
        'short_name': shortName,
        'class_id': classId,
        'chapter_no': lessonNumber,
        'name': name,
        'login_type': loginType,
        'description': description,
        'reg_id': regId,
        'sm_id': smId,
        'operation': publish ? 'savenpublish' : 'create',
        'acd_yr': academicYr,
        'sub_subject': subSubject,
      },
    );
    return res.data;
  }

  Future<Map<String, dynamic>> editChapter({
    required String shortName,
    required String classId,
    required String chapterNo,
    required String chapterId,
    required String name,
    required String loginType,
    required String description,
    required String regId,
    required String smId,
    required String academicYr,
    String subSubject = '',
  }) async {
    final res = await apiClient.post(
      '${baseUrl}CurriculumApi/chapters',
      data: FormData.fromMap({
        'short_name': shortName,
        'class_id': classId,
        'chapter_no': chapterNo,
        'chapter_id': chapterId,
        'name': name,
        'login_type': loginType,
        'description': description,
        'reg_id': regId,
        'sm_id': smId,
        'operation': 'edit',
        'acd_yr': academicYr,
        'sub_subject': subSubject,
      }),
    );
    return res.data;
  }

  Future<Map<String, dynamic>> publishChapters({
    required String shortName,
    required String selectedChapterIds, // comma-separated IDs
    String operation = 'publish',
    String loginType = 'T',
  }) async {
    final res = await apiClient.post(
      '${baseUrl}CurriculumApi/chapters',
      data: {
        'short_name': shortName,
        'operation': operation,
        'login_type': loginType,
        'checkbxpublish': selectedChapterIds,
      },
    );
    return res.data;
  }

  Future<bool> deleteChapter({
    required String shortName,
    required String chapterId,
    String operation = 'delete',
    String loginType = 'T',
  }) async {
    try {
      final res = await apiClient.post(
        '${baseUrl}CurriculumApi/chapters',
        data: {
          'short_name': shortName,
          'operation': operation,
          'login_type': loginType,
          'chapter_id': chapterId,
        },
      );
      final data = res.data is String ? json.decode(res.data) : res.data;
      return data['status'] == true;
    } catch (e) {
      return false;
    }
  }
}
