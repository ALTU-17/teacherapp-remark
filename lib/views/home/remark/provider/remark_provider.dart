import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/auth/providers/auth_provider.dart';
import '../../../../providers/api_client_provider.dart';
import '../model/ClassSubStudentModel.dart';
import '../service/remark_service.dart';
import '../model/remark.dart';
import 'package:tuple/tuple.dart';

// Service provider
final remarkServiceProvider = Provider<RemarkService>((ref) {
  final auth = ref.read(authProvider).requireValue;
  final dio = ref.read(apiClientProvider).requireValue;
  return RemarkService(dio, auth.teacherVerification?.teacherapkUrl ?? '');
});

final classSectionProvider = FutureProvider<List<ClassSection>>((ref) async {
  final auth = ref.read(authProvider).requireValue;
  final svc = ref.read(remarkServiceProvider);
  return svc.getClassSections(
    auth.academicYr ?? "",
    auth.regId ?? "",
    auth.teacherVerification?.shortName ?? "",
  );
});

// Use .family for param-based subjects
final subjectProvider = FutureProvider.family<List<Subject>, Tuple2<String, String>>((ref, tuple) async {
  final auth = ref.read(authProvider).requireValue;
  final svc = ref.read(remarkServiceProvider);
  return svc.getSubjects(
    auth.academicYr ?? "",
    auth.regId ?? "",
    tuple.item1, // classId
    tuple.item2, // sectionId
    auth.teacherVerification?.shortName ?? "",
  );
});

// Students provider .family style
final studentProvider = FutureProvider.family<List<Student>, Tuple2<String, String>>((ref, tuple) async {
  final auth = ref.read(authProvider).requireValue;
  final svc = ref.read(remarkServiceProvider);
  return svc.getStudents(
    auth.academicYr ?? "",
    tuple.item1, // classId
    tuple.item2, // sectionId
    auth.teacherVerification?.shortName ?? "",
  );
});

final remarkListProvider = FutureProvider<List<Remark>>((ref) async {
  final auth = ref.read(authProvider).requireValue;
  final svc = ref.read(remarkServiceProvider);
  return svc.getRemarks(
    academicYr: auth.academicYr ?? '',
    regId: auth.regId ?? '',
    shortName: auth.teacherVerification?.shortName ?? '',
  );
});

// Add this extension for refresh capability
extension on AutoDisposeFutureProviderRef<List<Remark>> {
  void refresh() {
    invalidate(remarkListProvider);
  }
}
