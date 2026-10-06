import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacherapp/config/utils.dart';
import 'dart:convert';

import '../models/models.dart';

class AttendanceService {
  final Dio apiClient;
  final String baseUrl;
  const AttendanceService(this.apiClient, this.baseUrl);

  Future<List<Students>> getStudents(StudentBody body) async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('Laravel base URL is missing');
    }

    if (token == null || token.isEmpty) {
      throw Exception('Laravel token is missing');
    }

    try {
      final uri = Uri.parse(
        '${baseUrl}get_students_by_class_section',
      ).replace(
        queryParameters: {
          'class_id': body.classID ?? '',
          'section_id': body.sectionID ?? '',
        },
      );

      print('Attendance Students URL: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print(
        'Attendance Students Response: ${response.body}',
      );

      if (response.statusCode != 200) {
        print(
          'Attendance Students Status: ${response.statusCode}',
        );

        throw Exception(
          'Failed to load students: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> jsonResponse =
      jsonDecode(response.body);

      // Laravel success check
      if (jsonResponse['success'] != true) {
        print(
          'Attendance API failed: '
              '${jsonResponse['message']}',
        );

        return [];
      }

      // Laravel returns students inside "data"
      final List<dynamic> data =
          jsonResponse['data'] as List? ?? [];

      if (data.isEmpty) {
        print('Attendance Students: No students found');
        return [];
      }

      final List<Students> students = [];

      for (final item in data) {
        try {
          students.add(
            Students.fromJson(
              Map<String, dynamic>.from(item),
            ),
          );
        } catch (e) {
          print(
            'Error parsing attendance student: $e\n'
                'Student data: $item',
          );
        }
      }

      print(
        'Attendance Students Loaded: ${students.length}',
      );

      return students;
    } catch (e) {
      Utils.debLog(
        'Attendance getStudents Error: $e',
      );

      throw Exception(
        'Error fetching attendance students: $e',
      );
    }
  }

  Future<List<Students>> getAttendanceByDate({
    required String classId,
    required String sectionId,
    required String onlyDate,
  }) async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    if (baseUrl == null || baseUrl.isEmpty) {
      throw Exception('Laravel base URL is missing');
    }

    if (token == null || token.isEmpty) {
      throw Exception('Laravel token is missing');
    }

    try {
      final uri = Uri.parse(
        '${baseUrl}get_att_class_section_day',
      ).replace(
        queryParameters: {
          'class_id': classId,
          'section_id': sectionId,
          'dateatt': _formatDateForAttendanceGet(onlyDate),
        },
      );

      Utils.debLog(
        'GET ATTENDANCE URL => $uri',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      Utils.debLog(
        'GET ATTENDANCE RESPONSE => ${response.body}',
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load attendance: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> jsonResponse =
      jsonDecode(response.body);

      if (jsonResponse['success'] != true) {
        return [];
      }

      final List<dynamic> data =
          jsonResponse['data'] as List? ?? [];

      return data.map((item) {
        return Students.fromJson(
          Map<String, dynamic>.from(item),
        );
      }).toList();
    } catch (e) {
      Utils.debLog(
        'GET ATTENDANCE ERROR => $e',
      );

      throw Exception(
        'Error fetching attendance: $e',
      );
    }
  }
  String _formatDateForAttendanceGet(String date) {
    if (date.isEmpty) {
      return '';
    }

    final parts = date.split('-');

    if (parts.length != 3) {
      return date;
    }

    // DD-MM-YYYY -> YYYY-MM-DD
    if (parts[0].length == 2) {
      return '${parts[2]}-${parts[1]}-${parts[0]}';
    }

    return date;
  }
  Future<String?> getLaravelToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String?> getLaravelBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('laravel_base_url');
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
      final baseUrl = await getLaravelBaseUrl();
      final token = await getLaravelToken();

      if (baseUrl == null || baseUrl.isEmpty) {
        Utils.debLog('Laravel base URL is missing');
        return false;
      }

      if (token == null || token.isEmpty) {
        Utils.debLog('Laravel token is missing');
        return false;
      }

      final uri = Uri.parse(
        '${baseUrl}delete_markattendance',
      ).replace(
        queryParameters: {
          'class_id': classId,
          'section_id': sectionId,
          'only_date': onlyDate,
        },
      );

      Utils.debLog(
        'DELETE ATTENDANCE URL => $uri',
      );

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      Utils.debLog(
        'DELETE ATTENDANCE RESPONSE => ${response.body}',
      );

      if (response.statusCode != 200) {
        Utils.debLog(
          'DELETE ATTENDANCE STATUS => ${response.statusCode}',
        );
        return false;
      }

      final Map<String, dynamic> jsonResponse =
      jsonDecode(response.body);

      return jsonResponse['success'] == true;
    } catch (e) {
      Utils.debLog(
        'DELETE ATTENDANCE ERROR => $e',
      );
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
      final baseUrl = await getLaravelBaseUrl();
      final token = await getLaravelToken();

      if (baseUrl == null || baseUrl.isEmpty) {
        Utils.debLog('Laravel base URL is missing');
        return false;
      }

      if (token == null || token.isEmpty) {
        Utils.debLog('Laravel token is missing');
        return false;
      }

      final uri = Uri.parse(
        '${baseUrl}save_markattendance',
      );

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(attendanceData),
      );

      Utils.debLog(
        'SAVE ATTENDANCE RESPONSE => ${response.body}',
      );

      if (response.statusCode != 200) {
        Utils.debLog(
          'SAVE ATTENDANCE STATUS => ${response.statusCode}',
        );
        return false;
      }

      final Map<String, dynamic> jsonResponse =
      jsonDecode(response.body);

      return jsonResponse['success'] == true;
    } catch (e) {
      Utils.debLog(
        'SAVE ATTENDANCE ERROR => $e',
      );
      return false;
    }
  }

  Future<bool> deleteStudentAttendance({
    required String attendanceId,
  }) async {
    try {
      final baseUrl = await getLaravelBaseUrl();
      final token = await getLaravelToken();

      if (baseUrl == null || baseUrl.isEmpty) {
        return false;
      }

      if (token == null || token.isEmpty) {
        return false;
      }

      final uri = Uri.parse(
        '${baseUrl}delete_studentmarkattendance',
      ).replace(
        queryParameters: {
          'attendance_id': attendanceId,
        },
      );

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        return false;
      }

      final jsonResponse = jsonDecode(response.body);

      return jsonResponse['success'] == true;
    } catch (e) {
      Utils.debLog(
        'Delete student attendance error: $e',
      );
      return false;
    }
  }

}
