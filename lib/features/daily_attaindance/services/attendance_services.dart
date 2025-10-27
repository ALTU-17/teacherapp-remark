import 'package:dio/dio.dart';
import 'package:teacherapp/config/utils.dart';
import 'dart:convert';

import '../models/models.dart';

class AttendanceService {
  final Dio apiClient;
  final String baseUrl;
  const AttendanceService(this.apiClient, this.baseUrl);

  Future<List<Students>> getStudents(StudentBody body) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_attendance_students',
        data: FormData.fromMap(body.toJson()),
        // data: FormData.fromMap({
        //   'academic_yr': '2024-2025', //TODO NEED TO FECT IT FROM THE SETTINGS
        //   'class_id': body.classID,
        //   'section_id': body.sectionID,
        //   'only_date': body.onlyDate,
        //   'short_name': body.shortName

        // }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == true) {
          final List<dynamic> data = jsonResponse['students'];
          return data.map((item) => Students.fromJson(item)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load students applications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<bool> deleteAttendance({
    required String academicYr,
    required String classId,
    required String sectionId,
    required String onlyDate,
    required String shortName,
    required String teacherId,
    required Map<String, dynamic> attendanceData,
  }) async {
    try {
      final data = {
        'academic_yr': academicYr,
        'class_id': classId,
        'section_id': sectionId,
        'only_date': onlyDate,
        'short_name': shortName,
        'teacher_id': teacherId,
        'data': jsonEncode(attendanceData),
        "login_type": "T",
        "operation": "delete_attendance"
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/mark_attendance',
        data: FormData.fromMap(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return jsonResponse['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      Utils.debLog(e);
      return false;
    }
  }

  Future<bool> updateAttendance({
    required String academicYr,
    required String classId,
    required String sectionId,
    required String onlyDate,
    required String shortName,
    required String teacherId,
    required Map<String, dynamic> attendanceData,
  }) async {
    try {
      final data = {
        'academic_yr': academicYr,
        'class_id': classId,
        'section_id': sectionId,
        'only_date': onlyDate,
        'short_name': shortName,
        'teacher_id': teacherId,
        'data': jsonEncode(attendanceData),
        "login_type": "T",
        "operation": "check_insert"
      };

      final response = await apiClient.post(
        '${baseUrl}AdminApi/mark_attendance',
        data: FormData.fromMap(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        return jsonResponse['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      Utils.debLog(e);
      return false;
    }
  }
}
