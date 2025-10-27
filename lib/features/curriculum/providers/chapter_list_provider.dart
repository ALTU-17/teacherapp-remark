import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/providers/api_client_provider.dart';
import 'package:teacherapp/features/auth/auth.dart';
import '../../leave_application/models/auth_data.dart';
import '../services/ChapterService.dart';
import '../models/chapter.dart';

part 'chapter_list_provider.g.dart';

@Riverpod(keepAlive: false)
class ChapterListP extends _$ChapterListP {
  late ChapterService _chapterService;

  @override
  Future<List<Chapter>> build() async {
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);
    _chapterService = ChapterService(api, authData.url);

    return await _chapterService.fetchChapters(
      shortName: authData.shortName,
      teacherId: authData.regId,
      academicYr: authData.academicYr,
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