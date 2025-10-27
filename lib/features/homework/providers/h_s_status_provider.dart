import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/providers/provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/academic_year_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../models/models.dart';
import '../services/services.dart';
part 'h_s_status_provider.g.dart';

@Riverpod(keepAlive: true)
class HSStatus extends _$HSStatus {
  late HomeworkService _homeworkService;
  @override
  Future<List<HomeworkStudentStatus>> build(Homework? homework) async {
    if (homework == null) return [];
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);

    _homeworkService = HomeworkService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final b = HSStatusBody(
      homeworkId: homework.homeworkId,
      academicYr: acdYear,
      shortName: authData.shortName,
      teacherId: authData.regId,
    );
    final x = await _homeworkService.studentWithHomeworkStatus(b);
    return x;
  }

  Future<bool> updateHomeWork(List<HomeworkStatus> data) async {
    final authData = _getAuthData();
    final x =
        await _homeworkService.updateHomeWorkStatus(data, authData.shortName);
    // ref.invalidateSelf();
    return x;
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
