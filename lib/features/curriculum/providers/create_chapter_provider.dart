import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../providers/api_client_provider.dart';
import '../services/ChapterService.dart';

/// Service provider
final chapterServiceProvider = Provider<ChapterService>((ref) {
  final auth = ref.read(authProvider).requireValue;
  final dio = ref.read(apiClientProvider).requireValue;
  return ChapterService(dio, auth.teacherVerification?.teacherapkUrl ?? '');
});

/// Classes provider
final classesProvider = FutureProvider<List<Map<String, String>>>((ref) async {
  final auth = ref.read(authProvider).requireValue;
  final svc = ref.read(chapterServiceProvider);
  return svc.getClasses(
    shortName: auth.teacherVerification?.shortName ?? '',
    regId: auth.regId ?? '',
    academicYr: auth.academicYr ?? '',
  );
});

/// Subjects provider - parameterised by classId
final subjectsProvider = FutureProvider.family<List<Map<String, String>>, String>((ref, classId) async {
  final auth = ref.read(authProvider).requireValue;
  final svc = ref.read(chapterServiceProvider);
  return svc.getSubjects(
    shortName: auth.teacherVerification?.shortName ?? '',
    regId: auth.regId ?? '',
    academicYr: auth.academicYr ?? '',
    classId: classId,
  );
});
