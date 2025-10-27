import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/features/home/services/services.dart';

import '../../../providers/provider.dart';
import '../../auth/providers/providers.dart';
import '../../leave_application/models/models.dart';
import '../models/models.dart';
part 'calender_provider.g.dart';

@Riverpod(keepAlive: false)
class CalenderP extends _$CalenderP {
  late CalenderService _calenderService;

  @override
  Future<Calender?> build(CalenderBody cal) async {
    final authData = _getAuthData();

    final api = await ref.read(apiClientProvider.future);
    //.url is base url
    _calenderService = CalenderService(api, authData.url);
    //  final _calenderService = CalenderService();
    return await _calenderService.getAllPublishedEvents(cal);
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
