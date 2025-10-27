import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/homework/models/models.dart';
import 'package:teacherapp/providers/provider.dart';
import '../../auth/models/models.dart';
import '../../auth/providers/auth_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../services/services.dart';
part 'subjects_provider.g.dart';

@Riverpod(keepAlive: false)
class SubjectP extends _$SubjectP {
  late HomeworkService _homeworkService;
  @override
  //user check here
  Future<List<Subject>> build() async {
    return [];
  }

  Future onChange(ClassInfo? classInfo) async {
    if (classInfo == null) return [];
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    _homeworkService = HomeworkService(api, authData.url);

    final b = SubjectsBody(
      academicYr: acdYear,
      classId: classInfo.classId ?? "",
      regId: authData.regId,
      sectionId: classInfo.sectionId ?? "",
      shortName: authData.shortName,
    );
    final x = await _homeworkService.getSubjects(b);
    state = AsyncData(x);
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
