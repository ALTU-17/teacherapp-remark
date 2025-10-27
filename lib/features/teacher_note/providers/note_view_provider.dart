import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/providers/provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../services/teacher_note_service.dart';
part 'note_view_provider.g.dart';

@Riverpod(keepAlive: true)
class NoteViewP extends _$NoteViewP {
  late TeacherNoteService _teacherNoteService;
  @override
  Future<List<NoteView>> build(Note? note) async {
    if (note == null) return [];
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);

    _teacherNoteService = TeacherNoteService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final b = NoteViewBody(
      acdYr: acdYear,
      shortName: authData.shortName,
      classId: note.classId,
      notesId: note.notesId,
      sectionId: note.sectionId,
    );
    final x = await _teacherNoteService.getNoteView(b);
    // final attachment = await _teacherNoteService.getDocument(DocHomeworkBody(
    //   homeworkId: note.notesId ?? "",
    //   homeworkDate: note.startDate ?? '',
    //   shortName: authData.shortName,
    // ));
    // Utils.debLog(attachment);
    return x;
  }

  // Future<bool> updateHomeWork(List<HomeworkStatus> data) async {
  //   final authData = _getAuthData();
  //   final x =
  //       await _homeworkService.updateHomeWorkStatus(data, authData.shortName);
  //   // ref.invalidateSelf();
  //   return x;
  // }

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
