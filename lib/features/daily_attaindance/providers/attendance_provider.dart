import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/providers/api_client_provider.dart';

import '../../../config/utils.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/academic_year_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../models/models.dart';
import '../services/services.dart';

part 'attendance_provider.g.dart';

@Riverpod(keepAlive: false)
class AttendanceP extends _$AttendanceP {
  late AttendanceService _attendanceService;

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Future<AttendanceState> build(StudentBody param) async {
    final authData = _getAuthData();

    if (!authData.isValid) {
      return AttendanceState();
    }

    final api = await ref.read(
      apiClientProvider.future,
    );

    _attendanceService = AttendanceService(
      api,
      authData.url,
    );

    final acdYear =
        ref.read(academicYearProvider)
            .requireValue
            .selectedYear;

    final data = param.copyWith(
      shortName: authData.shortName,
      academicYr: acdYear,
    );

    // ----------------------------------------------------------
    // 1. Get ALL students
    // ----------------------------------------------------------

    final students =
    await _attendanceService.getStudents(data);

    // ----------------------------------------------------------
    // 2. Get attendance for THIS class + section + date
    // ----------------------------------------------------------

    final attendance =
    await _attendanceService.getAttendanceByDate(
      classId: data.classID ?? '',
      sectionId: data.sectionID ?? '',
      onlyDate: data.onlyDate ?? '',
    );

    // ----------------------------------------------------------
    // 3. Create attendance map
    // ----------------------------------------------------------

    final attendanceMap = <String, Students>{};

    for (final record in attendance) {
      final studentId = record.studentId?.toString();

      if (studentId != null && studentId.isNotEmpty) {
        attendanceMap[studentId] = record;
      }
    }

    // ----------------------------------------------------------
    // 4. Detect whether this date is already marked
    // ----------------------------------------------------------

    final bool isAttendanceMarked =
        attendance.isNotEmpty;

    // ----------------------------------------------------------
    // 5. Merge
    // ----------------------------------------------------------

    final mergedStudents = students.map((student) {
      final studentId = student.studentId?.toString();

      final attendanceRecord =
      studentId == null
          ? null
          : attendanceMap[studentId];

      // Student has NO attendance record for this date.
      // Therefore Select must be OFF and Absent must be OFF/disabled.
      if (attendanceRecord == null) {
        return student.copyWith(
          attendanceId: null,
          attendanceStatus: "0",
          markAttendance: "1",
        );
      }

      // Student HAS an attendance record.
      // Select ON and Absent follows saved attendance.
      return student.copyWith(
        attendanceId: attendanceRecord.attendanceId,
        attendanceStatus:
        attendanceRecord.attendanceStatus ?? "0",
        markAttendance: "1",
      );
    }).toList();

    return AttendanceState(
      students: mergedStudents,
    );
  }

  // ============================================================
  // STUDENT SELECTION
  // ============================================================

  void toggleStudentSelection(Students updatedStudent) {
    state = state.whenData((data) {
      final updatedList = data.students.map((student) {
        return student.studentId == updatedStudent.studentId
            ? updatedStudent
            : student;
      }).toList();

      return data.copyWith(
        students: updatedList,
      );
    });
  }

  bool isStudentSelected(Students student) {
    return state.requireValue.selectedStudents.contains(student);
  }

  // ============================================================
  // UPDATE ATTENDANCE
  // ============================================================

  Future<bool> updateAttendance(
      StudentBody body,
      ) async {
    final authData = _getAuthData();

    if (!authData.isValid) {
      return false;
    }

    final currentState = state.requireValue;

    final students = currentState.students;

    state = const AsyncLoading();

    try {
      final success = await _updateAttendanceData(
        body: body,
        students: students,
        authData: authData,
      );

      if (success) {
        // Laravel is the source of truth.
        // Reload students + date attendance.
        ref.invalidateSelf();

        return true;
      }

      state = AsyncData(currentState);

      return false;
    } catch (e) {
      state = AsyncData(currentState);

      Utils.debLog(
        'Update attendance error => $e',
      );

      return false;
    }
  }

  // ============================================================
  // PREPARE STUDENTS
  // ============================================================

  List<Students> _prepareStudentsForUpdate(
      List<Students> allStudents,
      List<Students> selectedStudents,
      ) {
    /*
     * If no students are explicitly absent,
     * mark ALL students as PRESENT.
     */
    if (selectedStudents.isEmpty) {
      return allStudents
          .map(
            (student) => student.copyWith(
          attendanceStatus: "0",
          markAttendance: "1",
        ),
      )
          .toList();
    }

    /*
     * Get IDs of students currently marked absent.
     */
    final selectedStudentIds = selectedStudents
        .map((student) => student.studentId)
        .toSet();

    /*
     * Rebuild the complete student list.
     */
    return allStudents.map((student) {
      if (selectedStudentIds.contains(student.studentId)) {
        /*
         * Student is absent.
         */
        final selectedStudent = selectedStudents.firstWhere(
              (selected) =>
          selected.studentId == student.studentId,
        );

        return student.copyWith(
          attendanceStatus:
          selectedStudent.attendanceStatus,
          markAttendance:
          selectedStudent.markAttendance,
        );
      }

      /*
       * Student is not absent -> PRESENT.
       */
      return student.copyWith(
        attendanceStatus: "0",
        markAttendance: "1",
      );
    }).toList();
  }

  // ============================================================
  // CREATE LARAVEL UPDATE PAYLOAD
  // ============================================================

  Map<String, dynamic> _createLaravelAttendanceData({
    required List<Students> students,
    required StudentBody body,
  }) {
    final List<String> checkbox = [];
    final Map<String, dynamic> data = {};

    for (final student in students) {
      final studentId = student.studentId?.toString();

      if (studentId == null || studentId.isEmpty) {
        continue;
      }

      // ----------------------------------------------------------
      // SELECT STUDENTS CHECKBOX
      //
      // Only selected students are included.
      // ----------------------------------------------------------

      if (student.markAttendance != "1") {
        continue;
      }

      checkbox.add(studentId);

      // ----------------------------------------------------------
      // ABSENT CHECKBOX
      //
      // attendanceStatus "1" = ABSENT
      //
      // Web portal sends present_<studentId> = "1"
      // only for absent students.
      // ----------------------------------------------------------

      if (student.attendanceStatus == "1") {
        data['present_$studentId'] = "1";
      }
    }

    data['countOfStudents'] = checkbox.length.toString();
    data['class_id'] = body.classID ?? '';
    data['section_id'] = body.sectionID ?? '';
    data['dateatt'] = _formatSaveAttendanceDate(
      body.onlyDate ?? '',
    );
    data['checkbox'] = checkbox;

    return data;
  }
  // ============================================================
  // FORMAT DATE FOR SAVE API
  // ============================================================

  String _formatSaveAttendanceDate(String date) {
    if (date.isEmpty) {
      return '';
    }

    final parts = date.split('-');

    if (parts.length != 3) {
      return date;
    }

    /*
     * If current date is:
     *
     * 2026-08-24
     *
     * convert to:
     *
     * 24-08-2026
     */
    if (parts[0].length == 4) {
      return '${parts[2]}-${parts[1]}-${parts[0]}';
    }

    /*
     * Already DD-MM-YYYY.
     */
    return date;
  }

  // ============================================================
  // UPDATE API
  // ============================================================

  Future<bool> _updateAttendanceData({
    required StudentBody body,
    required List<Students> students,
    required AuthData authData,
  }) async {
    final api = await ref.read(
      apiClientProvider.future,
    );

    _attendanceService = AttendanceService(
      api,
      authData.url,
    );

    /*
     * Create NEW Laravel payload.
     *
     * This is NOT the old:
     *
     * {
     *   "arraylist": [...]
     * }
     *
     * Instead it creates:
     *
     * {
     *   "countOfStudents": "37",
     *   "class_id": "154",
     *   "section_id": "587",
     *   "dateatt": "24-08-2026",
     *   "checkbox": [...],
     *   "present_24112": "1",
     *   "present_24154": "1"
     * }
     */
    final attendanceData =
    _createLaravelAttendanceData(
      students: students,
      body: body,
    );

    print(
      'SAVE ATTENDANCE DATA => $attendanceData',
    );

    return await _attendanceService.updateAttendance(
      academicYr: ref
          .read(academicYearProvider)
          .requireValue
          .selectedYear,
      classId: body.classID ?? '',
      sectionId: body.sectionID ?? '',
      onlyDate: body.onlyDate ?? '',
      shortName: authData.shortName,
      teacherId: authData.regId,
      attendanceData: attendanceData,
    );
  }

  // ============================================================
  // DELETE ATTENDANCE
  // ============================================================

  Future<bool> deleteAttendance() async {
    final authData = _getAuthData();

    if (!authData.isValid) {
      return false;
    }

    final currentState = state.requireValue;

    final students = currentState.students;

    state = const AsyncLoading();

    try {
      final success = await _deleteAttendanceData(
        body: param,
        authData: authData,
      );

      if (success) {
        state = AsyncData(
          AttendanceState(
            students: students,
            selectedStudents: [],
          ),
        );

        ref.invalidateSelf();

        return true;
      }

      state = AsyncData(currentState);

      return false;
    } catch (e) {
      state = AsyncData(currentState);

      return false;
    }
  }

  // ============================================================
  // DELETE API
  // ============================================================

  Future<bool> _deleteAttendanceData({
    required StudentBody body,
    required AuthData authData,
  }) async {
    final api = await ref.read(
      apiClientProvider.future,
    );

    _attendanceService = AttendanceService(
      api,
      authData.url,
    );

    /*
     * Laravel DELETE API only requires:
     *
     * class_id
     * section_id
     * only_date
     *
     * No attendanceData is required anymore.
     */
    return await _attendanceService.deleteAttendance(
      academicYr: ref
          .read(academicYearProvider)
          .requireValue
          .selectedYear,
      classId: body.classID ?? '',
      sectionId: body.sectionID ?? '',
      onlyDate: _formatDeleteAttendanceDate(
        body.onlyDate ?? '',
      ),
      shortName: authData.shortName,
      teacherId: authData.regId,
      attendanceData: {},
    );
  }

  Future<bool> deleteStudentAttendance(
      String attendanceId,
      ) async {
    final authData = _getAuthData();

    if (!authData.isValid) {
      return false;
    }

    try {
      final api = await ref.read(
        apiClientProvider.future,
      );

      _attendanceService = AttendanceService(
        api,
        authData.url,
      );

      final success =
      await _attendanceService.deleteStudentAttendance(
        attendanceId: attendanceId,
      );

      if (success) {
        /*
       * Refresh GET API so the row immediately reflects
       * the deleted attendance.
       */
        ref.invalidateSelf();

        return true;
      }

      return false;
    } catch (e) {
      Utils.debLog(
        'DELETE STUDENT ATTENDANCE ERROR => $e',
      );

      return false;
    }
  }

  // ============================================================
  // FORMAT DATE FOR DELETE API
  // ============================================================

  String _formatDeleteAttendanceDate(String date) {
    if (date.isEmpty) {
      return '';
    }

    final parts = date.split('-');

    if (parts.length != 3) {
      return date;
    }

    /*
     * DELETE API expects:
     *
     * 2026-08-24
     *
     * So if date is already YYYY-MM-DD,
     * return it unchanged.
     */
    if (parts[0].length == 4) {
      return date;
    }

    /*
     * If somehow date is DD-MM-YYYY,
     * convert it to YYYY-MM-DD.
     */
    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  // ============================================================
  // AUTH DATA
  // ============================================================

  AuthData _getAuthData() {
    final auth = ref.read(
      authProvider,
    ).requireValue;

    return AuthData(
      shortName:
      auth.teacherVerification?.shortName ?? '',
      url:
      auth.teacherVerification?.teacherapkUrl ?? '',
      regId:
      auth.regId ?? '',
      academicYr:
      auth.academicYr ?? '',
    );
  }
}