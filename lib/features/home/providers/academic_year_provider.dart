import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../providers/provider.dart';
import '../../auth/auth.dart';
import '../../leave_application/models/models.dart';
import '../models/models.dart';
import '../services/services.dart';

part 'academic_year_provider.g.dart';

@Riverpod(keepAlive: true)
class AcademicYear extends _$AcademicYear {
  @override
  Future<AcdState> build() async {
    final authData = _getAuthData();

    final api = await ref.read(apiClientProvider.future);
    final ac = await AcademicYearService(api, authData.url)
        .getAllAcademicYears(authData.shortName);

    return AcdState(
      academicYrs: ac,
      selectedYear: authData.academicYr, // ✅ current active year
    );
  }

  void changeYear(String? year) async {
    if (year == null) return;
    final old = state.requireValue;

    state = AsyncValue.data(old.copyWith(selectedYear: year));
    try {
      await ref.read(authProvider.notifier).refreshUser();
    } catch (_) {}
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
