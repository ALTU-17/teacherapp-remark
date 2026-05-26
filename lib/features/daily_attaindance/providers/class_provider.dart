import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/features/auth/auth.dart';
import 'package:teacherapp/features/auth/models/models.dart';

import '../../../providers/api_client_provider.dart';
import '../../home/providers/academic_year_provider.dart';
import '../../leave_application/models/models.dart';
import '../services/services.dart';

part 'class_provider.g.dart';

@Riverpod(keepAlive: false)
class ClassP extends _$ClassP {
  late ClasssService _classsService;

  @override
  Future<List<ClassInfo>> build() async {
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);

    _classsService = ClasssService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final auth = ref.read(authProvider).requireValue;
    return await _classsService.getClasses(auth.academicYr ?? '');
  }

  Future getStudents() async {}
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
