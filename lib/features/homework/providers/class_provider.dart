import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/providers/provider.dart';
import '../../auth/models/models.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/academic_year_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../services/services.dart';
part 'class_provider.g.dart';

@Riverpod(keepAlive: false)
class ClassP extends _$ClassP {
  late HomeworkService _homeworkService;
  @override
  //user check here
  Future<List<ClassInfo>> build() async {
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);

    _homeworkService = HomeworkService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    return _homeworkService.getClass(
      authData.regId,
      authData.academicYr,
      authData.shortName,
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
