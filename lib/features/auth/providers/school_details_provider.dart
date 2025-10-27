
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import '../../../providers/provider.dart';
import '../models/school_details.dart';
import '../services/services.dart';
part 'school_details_provider.g.dart';

@Riverpod(keepAlive: false)
class SchoolP extends _$SchoolP {
  late final AuthService _authService;
  @override
  //user check here
  Future<SchoolDetails?> build() async {
    final auth = await ref.read(authProvider.future);
    final api = await ref.read(apiClientProvider.future);
    _authService = AuthService(api);
    return await _authService.getSchoolDetails();
  }
}
