import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../notice_board_screens/library_pending.dart';
import '../notice_board_screens/notice_board.dart';
import '../notice_board_screens/pending_fees.dart';
import '../notice_board_screens/pending_lesson_plans.dart';
import '../notice_board_screens/today_homework.dart';
import '../notice_board_screens/upcoming_birthdays.dart';
import '../views/dashboard_view.dart';
import '../views/teacher_id.dart';

class StaffApiService {
  final String baseUrl;

  StaffApiService(this.baseUrl);
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getBirthdays() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final res = await http.get(
      Uri.parse('${baseUrl}students/birthdays'),
      headers: {'Authorization': 'Bearer $token'},
    );
    print("birthdays => ${res.body}");

    if (res.statusCode != 200) {
      throw Exception("Failed to load birthdays");
    }

    final data = jsonDecode(res.body)['data'];

    List<BirthdayStudent> parseStudents(List list) =>
        list.map((e) => BirthdayStudent.fromJson(e)).toList();

    List<BirthdayStaff> parseStaff(List list) =>
        list.map((e) => BirthdayStaff.fromJson(e)).toList();

    final s = data["studentBirthDays"];
    final t = data["staffBirthDays"];

    return {
      "students": {
        "yesterday": parseStudents(s["yesterday"] ?? []),
        "today": parseStudents(s["today"] ?? []),
        "tomorrow": parseStudents(s["tomorrow"] ?? []),
      },
      "staff": {
        "yesterday": parseStaff(t["yesterday"] ?? []),
        "today": parseStaff(t["today"] ?? []),
        "tomorrow": parseStaff(t["tomorrow"] ?? []),
      }
    };
  }

  Future<void> logout() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final url = Uri.parse("${baseUrl}logout");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Logout failed");
    }
  }


  Future<int> getTeacherLateCountMonthly() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final url = "${baseUrl}get_teacherlatecountmonthly";

    print("LATE COUNT API => $url");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("LATE COUNT RESPONSE => ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch late count");
    }

    final json = jsonDecode(response.body);

    if (json["success"] != true) {
      throw Exception(json["message"] ?? "Unknown error");
    }

    final List data = json["data"] ?? [];

    if (data.isEmpty) return 0;

    return data.first["late_days"] ?? 0;
  }


  Future<List<TeacherReminder>> getTeacherReminders() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final res = await http.get(
      Uri.parse("${baseUrl}get_remark_of_teacher"),
      headers: {"Authorization": "Bearer $token"},
    );
    print("get_remark_of_teacher => ${res.body}");
    final json = jsonDecode(res.body)["data"] as List;

    return json.map((e) => TeacherReminder.fromJson(e)).toList();
  }

  Future<void> markReminderRead(int id) async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    await http.post(
      Uri.parse("${baseUrl}save_acknowledgeteacher/${id.toString()}"),
      // body: {"t_remark_id": id.toString()},
      headers: {"Authorization": "Bearer $token"},
    );
  }


  Future<List<DashboardNoticeConfig>> getTeacherMobileDashboard() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final res = await http.get(
      Uri.parse('${baseUrl}get_teachermobiledashboard'),
      headers: {'Authorization': 'Bearer $token'},
    );

    print("get_teachermobiledashboard => ${res.body}");

    final json = jsonDecode(res.body);
    final list = json['data'] as List;

    return list
        .map((e) => DashboardNoticeConfig.fromJson(e))
        .toList();
  }

  // Future<Map<String, dynamic>> getTeacherClassesExams() async {
  //   final response = await dio.post(
  //     "get_teacherclassesexams",
  //   );
  //
  //   if (response.statusCode == 200 && response.data["success"] == true) {
  //     return response.data;
  //   } else {
  //     throw Exception("Failed to fetch exam timetable");
  //   }
  // }


  Future<List<dynamic>> getTeacherTaughtClassesExams() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final url = "${baseUrl}get_teachertaughtclassesexams";

    print("TEACHER EXAMS => $url");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("TEACHER EXAMS RESPONSE => ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch teacher exams");
    }

    final json = jsonDecode(response.body);

    if (json["success"] != true) {
      throw Exception(json["message"] ?? "Unknown error");
    }

    // 👇 return raw data list
    return json["data"] as List<dynamic>;
  }
  Future<List<dynamic>> getTeacherClassesExams() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final url = "${baseUrl}get_teacherclassesexams";

    print("TEACHER EXAMS => $url");

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("TEACHER EXAMS RESPONSE => ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch teacher exams");
    }

    final json = jsonDecode(response.body);

    if (json["success"] != true) {
      throw Exception(json["message"] ?? "Unknown error");
    }

    // 👇 return raw data list
    return json["data"] as List<dynamic>;
  }


  Future<Map<String, List<TeacherClassExam>>> getTodayTomorrowExams() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final res = await http.get(
      Uri.parse('${baseUrl}get_teachertaughtclassesexams'),
      headers: {'Authorization': 'Bearer $token'},
    );


    print("get_teachertaughtclassesexams => ${res.body}");
    print("get_teachertaughtclassesexams => $token");

    final json = jsonDecode(res.body);
    final list = json["data"] as List;

    final today = DateTime.now();
    final tomorrow = today.add(Duration(days: 1));

    List<TeacherClassExam> todayExams = [];
    List<TeacherClassExam> tomorrowExams = [];

    for (var cls in list) {
      final className = cls["class_name"];
      final sectionName = cls["sections"][0]["section_name"];

      for (var exam in cls["exams"]) {
        final examName = exam["exam_name"];

        for (var slot in exam["timetable"]) {
          final examSlot = ExamSlot.fromJson(slot);

          // ADD ALL EXAM SLOTS INCLUDING STUDY LEAVE
          if (true) {
            if (_isSameDate(examSlot.date, today)) {
              todayExams.add(TeacherClassExam(
                className: className,
                sectionName: sectionName,
                examName: examName,
                timetable: [examSlot],
              ));
            }

            if (_isSameDate(examSlot.date, tomorrow)) {
              tomorrowExams.add(TeacherClassExam(
                className: className,
                sectionName: sectionName,
                examName: examName,
                timetable: [examSlot],
              ));
            }

          }
        }
      }
    }

    return {
      "today": todayExams,
      "tomorrow": tomorrowExams,
    };
  }

  bool _isSameDate(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;



  Future<List<PendingLibraryBook>> getPendingBooksForReturn() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final url = "${baseUrl}get_pendingbookforreturn";

    final res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );
    print("get_pendingbookforreturn => ${res.body}");
    if (res.statusCode != 200) {
      throw Exception("Failed to load pending library books");
    }

    final list = jsonDecode(res.body)["data"] as List;

    return list.map((e) => PendingLibraryBook.fromJson(e)).toList();
  }


  Future<List<WeeklyLessonPending>> getWeeklyLessonPending() async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final url = "${baseUrl}list_of_lesson_plan_not_created";

    final res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"},
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to load lesson pending list");
    }

    final list = jsonDecode(res.body)["list"] as List;

    return list.map((e) => WeeklyLessonPending.fromJson(e)).toList();
  }



  Future<List<PendingFeeGroup>> getPendingFees() async {
    try {
      final baseUrl = await getLaravelBaseUrl();
      final token = await getLaravelToken();

      if (baseUrl == null || baseUrl.isEmpty) {
        print("PENDING FEES ERROR: Base URL is null or empty");
        return [];
      }

      if (token == null || token.isEmpty) {
        print("PENDING FEES ERROR: Token is null or empty");
        return [];
      }

      final url = "${baseUrl}teachers/class-teacher/defaulter-students";
      print("PENDING FEES URL => $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );

      print("PENDING FEES Status: ${response.statusCode}");
      print("PENDING FEES Body: ${response.body}");

      if (response.statusCode != 200) {
        print("PENDING FEES ERROR: HTTP ${response.statusCode}");
        return [];
      }

      final jsonResponse = jsonDecode(response.body);

      // Handle different response structures
      if (jsonResponse["status"] == false) {
        print("PENDING FEES: API returned false - ${jsonResponse["message"]}");
        return [];
      }

      // Handle case where data might be directly in response
      List studentsData;
      if (jsonResponse.containsKey("students")) {
        studentsData = jsonResponse["students"] as List? ?? [];
      } else if (jsonResponse.containsKey("data")) {
        studentsData = jsonResponse["data"] as List? ?? [];
      } else if (jsonResponse is List) {
        studentsData = jsonResponse;
      } else {
        print("PENDING FEES: Unexpected response format");
        return [];
      }

      if (studentsData.isEmpty) {
        print("PENDING FEES: No students data found");
        return [];
      }

      // Convert to model with error handling for each student
      final List<PendingFeeStudent> all = [];
      for (var item in studentsData) {
        try {
          all.add(PendingFeeStudent.fromJson(item));
        } catch (e) {
          print("Error parsing student data: $e");
          continue; // Skip invalid entries
        }
      }

      if (all.isEmpty) {
        print("PENDING FEES: No valid student data after parsing");
        return [];
      }

      // Group by studentId
      final Map<int, List<PendingFeeStudent>> grouped = {};

      for (var s in all) {
        grouped.putIfAbsent(s.studentId, () => []);
        grouped[s.studentId]!.add(s);
      }

      // Convert to PendingFeeGroup
      final result = grouped.values.map((installments) {
        final first = installments.first;

        return PendingFeeGroup(
          studentId: first.studentId,
          fullName: first.fullName,
          rollNo: first.rollNo,
          installments: installments,
        );
      }).toList();

      result.sort((a, b) => a.rollNo.compareTo(b.rollNo));

      print("PENDING FEES: Found ${result.length} students with pending fees");
      return result;

    } catch (e, stackTrace) {
      print("PENDING FEES EXCEPTION: $e");
      print("Stack trace: $stackTrace");
      return []; // Return empty list instead of throwing
    }
  }


  Future<List<PendingHomeworkStudent>> getTodayPendingHomework({
    required String classId,
    required String sectionId,
  }) async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    final url = '${baseUrl}homeworks/pending/today?class_id=$classId&section_id=$sectionId';

    print('Todays Homework: $url');
    final res = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (res.statusCode != 200) {

      print('Todays Homework: body ${res.body}');
      print('Todays Homework:> body $res');

      throw Exception('Failed to fetch homework');
    }

    final jsonData = jsonDecode(res.body)['data'] as List;
    print('Todays Homework:> $jsonData');
    List<PendingHomeworkStudent> list = jsonData
        .map((e) => PendingHomeworkStudent.fromJson(e))
        .toList();

    // Sort by roll no
    list.sort((a, b) => a.rollNo.compareTo(b.rollNo));

    return list;
  }


  Future<Teacher> getTeacher({
    required String regId,
    required String token,
  }) async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();

    print('token: ${token}');
    print('baseUrl: ${'${baseUrl}teachersdata/$regId'}');

    final res = await http.get(
      Uri.parse('${baseUrl}teachersdata/$regId'),
      headers: {
        'Authorization': 'Bearer $token'},
    );
    print('Response body: ${regId}');
    print('Response body: ${res.body}');

    if (res.statusCode != 200) {
      throw Exception('Failed to load teacher');
    }

    final json = jsonDecode(res.body);
    return Teacher.fromJson(json['teacher']);
  }

  Future<void> updateTeacher({
    required String regId,
    required String token,
    required Map<String, dynamic> body,
  }) async {
    final baseUrl = await getLaravelBaseUrl();
    final token = await getLaravelToken();
    print('baseUrl: ${'${baseUrl}update_teacherdetails/$regId'}');
    print('baseUrl: ${'${baseUrl}update_teacherdetails/$token'}');

    final res = await http.put(
      Uri.parse('${baseUrl}update_teacherdetails/$regId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );
    print('update_teacherdetails: $res');

    if (res.statusCode != 200) {
      throw Exception('Update failed');
    }
  }
}