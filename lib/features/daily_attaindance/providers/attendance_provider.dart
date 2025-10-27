import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/providers/api_client_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/academic_year_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../models/models.dart';
import '../services/services.dart';

part 'attendance_provider.g.dart';

@Riverpod(keepAlive: false)
class AttendanceP extends _$AttendanceP {
  late AttendanceService _attendanceService;

  @override
  Future<AttendanceState> build(StudentBody param) async {
    final authData = _getAuthData();
    if (!authData.isValid) return AttendanceState();

    final api = await ref.read(apiClientProvider.future);

    _attendanceService = AttendanceService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final data = param.copyWith(
      shortName: authData.shortName,
      academicYr: acdYear,
    );

    final students = await _attendanceService.getStudents(data);
    return AttendanceState(students: students);
  }

  toggleStudentSelection(Students student) {
    final selectedStudents =
    List<Students>.from(state.requireValue.selectedStudents);
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
    state = AsyncData(
        state.requireValue.copyWith(selectedStudents: selectedStudents));
  }

  bool isStudentSelected(Students student) {
    return state.requireValue.selectedStudents.contains(student);
  }

  Future updateAttendance(StudentBody body) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    final currentState = state.requireValue;
    final selectedStudents = currentState.selectedStudents;
    final allStudents = currentState.students;

    // Prepare students data based on selection
    final studentsToUpdate = selectedStudents.isEmpty
        ? _markAllStudentsPresent(allStudents)
        : _mergeSelectedStudents(allStudents, selectedStudents);
    state = AsyncLoading();
    // Create attendance data and make API call
    final success = await _updateAttendanceData(
      body: body,
      students: studentsToUpdate,
      authData: authData,
      markAllPresent: selectedStudents.isEmpty,
    );

    if (success) {
      state = AsyncData(AttendanceState(
        students: studentsToUpdate,
        selectedStudents: [],
      ));
      ref.invalidateSelf();
    } else {
      state = AsyncData(currentState);
    }
  }

  Future deleteAttendance() async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    final currentState = state.requireValue;
    final students = currentState.students;

    state = AsyncLoading();

    final attendanceData = _createAttendanceData(
      students: students,
      body: param,
      authData: authData,
      attendanceStatus: "0",
    );

    final success = await _deleteAttendanceData(
      body: param,
      attendanceData: attendanceData,
      authData: authData,
    );

    if (success) {
      state = AsyncData(AttendanceState(
        students: students,
        selectedStudents: [],
      ));
      ref.invalidateSelf();
    } else {
      state = AsyncData(currentState);
    }
  }

  // Helper methods for optimization
  List<Students> _markAllStudentsPresent(List<Students> students) {
    return students
        .map((student) => student.copyWith(attendanceStatus: "0"))
        .toList();
  }

  List<Students> _mergeSelectedStudents(
      List<Students> allStudents, List<Students> selectedStudents) {
    final updatedStudentsMap = {
      for (var student in selectedStudents) student.studentId: student
    };
    return allStudents.map((oldStudent) {
      return updatedStudentsMap[oldStudent.studentId] ?? oldStudent;
    }).toList();
  }

  List<Att> _createAttObjects(List<Students> students, StudentBody body,
      AuthData authData, String attendanceStatus) {
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;

    return students
        .where((s) => attendanceStatus == "1" || s.markAttendance != "0")
        .map((s) => Att(
      attendanceStatus:
      attendanceStatus == "1" ? "1" : (s.attendanceStatus ?? "0"),
      fName: s.firstName,
      lName: s.lastName,
      rollNo: s.rollNo?.toString(),
      studentId: s.studentId,
      classId: body.classID ?? s.classId,
      sectionId: body.sectionID ?? s.sectionId?.toString(),
      date: body.onlyDate ?? s.date?.toString(),
      onlyDate: body.onlyDate ?? s.onlyDate?.toString(),
      teacherId: authData.regId,
      academicYr: acdYear,
    ))
        .toList()
        .toSet()
        .toList();
  }

  Map<String, dynamic> _createAttendanceData({
    required List<Students> students,
    required StudentBody body,
    required AuthData authData,
    required String attendanceStatus,
  }) {
    final attObjects =
    _createAttObjects(students, body, authData, attendanceStatus);
    return {"arraylist": attObjects.map((e) => e.toJson()).toList()};
  }

  Future<bool> _updateAttendanceData({
    required StudentBody body,
    required List<Students> students,
    required AuthData authData,
    required bool markAllPresent,
  }) async {
    final api = await ref.read(apiClientProvider.future);
    _attendanceService = AttendanceService(api, authData.url);

    final attendanceData = _createAttendanceData(
      students: students,
      body: body,
      authData: authData,
      attendanceStatus: markAllPresent ? "0" : "1",
    );

    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    return await _attendanceService.updateAttendance(
      academicYr: acdYear,
      classId: body.classID ?? "",
      sectionId: body.sectionID ?? "",
      onlyDate: body.onlyDate ?? "",
      shortName: authData.shortName,
      teacherId: authData.regId,
      attendanceData: attendanceData,
    );
  }

  Future<bool> _deleteAttendanceData({
    required StudentBody body,
    required Map<String, dynamic> attendanceData,
    required AuthData authData,
  }) async {
    final api = await ref.read(apiClientProvider.future);
    _attendanceService = AttendanceService(api, authData.url);

    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    return await _attendanceService.deleteAttendance(
      academicYr: acdYear,
      classId: body.classID ?? "",
      sectionId: body.sectionID ?? "",
      onlyDate: body.onlyDate ?? "",
      shortName: authData.shortName,
      teacherId: authData.regId,
      attendanceData: attendanceData,
    );
  }

  AuthData _getAuthData() {
    final auth = ref.read(authProvider).requireValue;
    return AuthData(
      shortName: auth.teacherVerification?.shortName ?? '',
      url: auth.teacherVerification?.teacherapkUrl ?? '',
      regId: auth.regId ?? '',
      academicYr: auth.academicYr ?? '',
    );
  }
}