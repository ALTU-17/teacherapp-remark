import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/providers/provider.dart';
import 'package:teacherapp/views/home/remark/service/editservice.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/academic_year_provider.dart';
import '../../homework/models/delete_documnet_body.dart';
import '../../leave_application/models/auth_data.dart';
import '../models/models.dart';
import '../services/services.dart';
import '../services/teacher_note_service.dart';
part 'note_provider.g.dart';

final editTeacherNoteServiceProvider = Provider<EditTeacherNoteService>((ref) {
  final auth = ref.read(authProvider).requireValue;
  final dio = ref.read(apiClientProvider).requireValue;
  return EditTeacherNoteService(apiClient: dio, baseUrl: auth.teacherVerification?.teacherapkUrl ?? '');
});

@Riverpod(keepAlive: false)
class TeacherNote extends _$TeacherNote {
  late TeacherNoteService _teacherNoteService;
  TeacherNoteService get teacherNoteService => _teacherNoteService;

  @override
  Future<List<Note>> build() async {
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);
    _teacherNoteService = TeacherNoteService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    return _teacherNoteService.getTeacherNote(
      authData.regId,
      acdYear,
      authData.shortName,
    );
  }

  Future<void> refreshNotes() async {
    state = const AsyncLoading();
    final authData = _getAuthData();
    if (!authData.isValid) return;

    try {
      final api = await ref.read(apiClientProvider.future);
      _teacherNoteService = TeacherNoteService(api, authData.url);
      final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;

      final notes = await _teacherNoteService.getTeacherNote(
        authData.regId,
        acdYear,
        authData.shortName,
      );

      state = AsyncData(notes);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }


  // ADD THESE NEW METHODS FOR FILE UPLOAD (following remark pattern)
  Future<bool> uploadTeacherNoteDocument({
    required String random_no,
    required String shortName,
    required List<int> fileBytes,
    required String uploadDate,
    required String filename,
  }) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    return _teacherNoteService.uploadTeacherNoteDocument(
      random_no: random_no,
      shortName: shortName,
      fileBytes: fileBytes,
      uploadDate: uploadDate,
      filename: filename,
    );
  }

  Future<bool> deleteTeacherNoteDocument({
    required String random_no,
    required String uploadDate,
    required String classId,
    required String sectionId,
    required String shortName,
    required String filename,
  }) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    return _teacherNoteService.deleteTeacherNoteDocument(
      random_no: random_no,
      uploadDate: uploadDate,
      classId: classId,
      sectionId: sectionId,
      shortName: shortName,
      filename: filename,
    );
  }

  Future<Map<String, dynamic>> createTeacherNoteWithFiles(CreateNoteBody teacherNote) async {
    final authData = _getAuthData();
    if (!authData.isValid) return {'status': false, 'error_msg': 'Invalid auth data'};

    state = AsyncLoading();
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;

    // Debug: Check what random number is coming in
    print("Incoming randomNo: ${teacherNote.randomNo}");

    final h = teacherNote.copyWith(
      publish: 'N',
      loginType: 'T',
      randomNo: teacherNote.randomNo, // Use the incoming random number
      academicYear: acdYear,
      teacherId: authData.regId,
      shortName: authData.shortName,
    );

    // Debug: Check what random number is going out
    print("Outgoing randomNo: ${h.randomNo}");

    Utils.debLog("======>>>>>>${h.toJson()}<<<<<<<<<<=======");
    final result = await _teacherNoteService.createNoteWithFiles(h);

    ref.invalidateSelf();
    return result;
  }

  Future<Map<String, dynamic>> updateTeacherNoteWithFiles(CreateNoteBody note) async {
    final authData = _getAuthData();
    if (!authData.isValid) return {'status': false, 'error_msg': 'Invalid auth data'};

    state = AsyncLoading();
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;

    final h = note.copyWith(
      publish: 'N',
      loginType: 'T',
      randomNo: '1',
      teacherId: authData.regId,
      shortName: authData.shortName,
      operation: 'edit',
      academicYear: acdYear,
    );

    final result = await _teacherNoteService.updateNoteWithFiles(h);
    ref.invalidateSelf();
    return result;
  }

  // KEEP YOUR EXISTING METHODS (they should remain unchanged)
  Future<bool> deleteNote(Note note) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    final b = NoteDeleteBody.fromJson(
      {...note.toJson(), 'short_name': authData.shortName},
    );
    final res = await _teacherNoteService.deleteNote(b);
    ref.invalidateSelf();
    return res;
  }

  Future<bool> deleteDocument(Note note, String filename) async {
    final authData = _getAuthData();
    final d = DeleteDocumentBody(
      docTypeFolder: 'daily_notes',
      filename: json.encode(filename),
      uploadDate: note.date,
      randomNo: '1',
      shortName: authData.shortName,
    );

    final res = await _teacherNoteService.deleteDocument(d);

    if (!authData.isValid) return false;
    state = AsyncLoading();
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final n = CreateNoteBody.fromJson(note.toJson()).copyWith(
      publish: 'N',
      loginType: 'T',
      randomNo: note?.notesId ?? '1234',
      academicYear: acdYear,
      teacherId: authData.regId,
      shortName: authData.shortName,
      operation: 'edit',
      deleteimagelist: [filename],
    );
    await _teacherNoteService.updateNote(n);
    ref.invalidateSelf();
    return res;
  }

  Future<List<String>> getDocument(Note note) async {
    final authData = _getAuthData();
    final h = DocNoteBody(
      noteId: note.notesId ?? '',
      dailynoteDate: note.date ?? '',
      shortName: authData.shortName,
    );

    final res = await _teacherNoteService.getDocument(h);
    if (res == null) {
      return [];
    }
    final x = res.images?.map((e) => "${res.url}/${e.imageName}").toList() ?? [];
    Utils.debLog(x);
    return x;
  }

  Future<bool> createTeacherNote(CreateNoteBody teacherNote) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;
    state = AsyncLoading();
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final h = teacherNote.copyWith(
      publish: 'N',
      loginType: 'T',
      randomNo: '1',
      academicYear: acdYear,
      teacherId: authData.regId,
      shortName: authData.shortName,
    );

    Utils.debLog("======>>>>>>${h.toJson()}<<<<<<<<<<=======");
    final res = await _teacherNoteService.createNote(h);
    ref.invalidateSelf();
    return res;
  }

  Future<bool> publishNote(Note note) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    // Don't set state to AsyncLoading here - that causes white screen
    // state = const AsyncLoading();

    try {
      final d = NotePublishBody.fromJson(note.toJson());
      final temp = d.copyWith(
        publish: 'Y',
        loginType: 'T',
        shortName: authData.shortName,
      );

      final res = await _teacherNoteService.publishNote(temp);

      if (res) {
        // ✅ Refresh notes after publish
        await refreshNotes();
        Utils.debLog("Note published successfully");
        return true;
      } else {
        Utils.debLog("Failed to publish note");
        return false;
      }
    } catch (e, st) {
      Utils.debLog("Error publishing note: $e");
      return false;
    }
  }


  Future<bool> updateNote(CreateNoteBody note) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;
    state = AsyncLoading();
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final h = note.copyWith(
      publish: 'N',
      loginType: 'T',
      randomNo: '1',
      teacherId: authData.regId,
      shortName: authData.shortName,
      operation: 'edit',
      academicYear: acdYear,
    );
    final res = await _teacherNoteService.updateNote(h);
    ref.invalidateSelf();
    return res;
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