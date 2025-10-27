import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/features/auth/auth.dart';
import 'package:teacherapp/providers/api_client_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../services/curriculumservice.dart';
import '../models/curriculum_role_info.dart';

part 'curriculum_role_provider.g.dart';

@Riverpod(keepAlive: false)
class CurriculumRoleP extends _$CurriculumRoleP {
  late CurriculumService _curriculumService;

  @override
  Future<CurriculumRoleInfo?> build() async { // <-- async here!
    final authData = _getAuthData();
    if (!authData.isValid) return null;

    final api = await ref.read(apiClientProvider.future);

    _curriculumService = CurriculumService(api, authData.url);
    return await _curriculumService.getRoleInfo(); // <-- await here!


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