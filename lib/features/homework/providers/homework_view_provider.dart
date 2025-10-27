import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/providers/provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../models/models.dart';
import '../services/services.dart';
part 'homework_view_provider.g.dart';

@Riverpod(keepAlive: true)
class HomeworkView extends _$HomeworkView {
  late HomeworkService _homeworkService;
  @override
  Future<List<HomeworkViewByParent>> build(Homework? homework) async {
    if (homework == null) return [];
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);

    _homeworkService = HomeworkService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final b = HomeWorkViewBody(
      homeworkId: homework.homeworkId,
      acdYr: acdYear,
      shortName: authData.shortName,
      classId: homework.classId,
      sectionId: homework.sectionId,
    );
    final x = await _homeworkService.getHomeWorkViews(b);
    final attachment = await _homeworkService.getDocument(DocHomeworkBody(
      homeworkId: homework.homeworkId ?? "",
      homeworkDate: homework.startDate ?? '',
      shortName: authData.shortName,
    ));
    Utils.debLog(attachment);
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
