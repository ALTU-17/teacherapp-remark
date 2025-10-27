import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/homework/models/homework_publish_body.dart';
import 'package:teacherapp/features/homework/models/models.dart';
import 'package:teacherapp/providers/provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/academic_year_provider.dart';
import '../../leave_application/models/auth_data.dart';
import '../services/services.dart';
part 'homework_provider.g.dart';

@Riverpod(keepAlive: false)
class HomeWorkP extends _$HomeWorkP {
  late HomeworkService _homeworkService;
  @override
  //user check here
  Future<List<Homework>> build() async {
    final authData = _getAuthData();
    if (!authData.isValid) return [];

    final api = await ref.read(apiClientProvider.future);

    _homeworkService = HomeworkService(api, authData.url);
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    return _homeworkService.getHomework(
      authData.regId,
      acdYear,
      authData.shortName,
    );
  }

  Future<void> refreshHomework() async {
    state = const AsyncLoading();
    final authData = _getAuthData();
    if (!authData.isValid) return;

    try {
      final api = await ref.read(apiClientProvider.future);
      _homeworkService = HomeworkService(api, authData.url);
      final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;

      final hw = await _homeworkService.getHomework(
        authData.regId,
        acdYear,
        authData.shortName,
      );

      state = AsyncData(hw);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
  Future<bool> deleteHomeWork(Homework homework) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final b = HomeworkDeleteBody.fromJson(
      {...homework.toJson(), 'academic_yr': acdYear},
    );
    final res = await _homeworkService.deleteHomeWork(b);
    ref.invalidateSelf();
    return res;
  }

  Future<int> getCommentCount(String homeworkId) async {
    final authData = _getAuthData();
    if (!authData.isValid) return 0;

    try {
      return await _homeworkService.getCommentCount(homeworkId);
    } catch (e) {
      Utils.debLog('Error fetching comment count: $e');
      return 0;
    }
  }

  Future<List<String>> getDocument(Homework homework) async {
    final authData = _getAuthData();
    final h = DocHomeworkBody(
      homeworkId: homework.homeworkId ?? '',
      homeworkDate: homework.startDate?.split(' ').first ?? '',
      shortName: authData.shortName,
    );
    // Utils.debLog(h.toJson());
    final res = await _homeworkService.getDocument(h);

    if (res == null) {
      return [];
    }
    final x =
        res.images?.map((e) => "${res.url}/${e.imageName}").toList() ?? [];
    Utils.debLog(x);
    return x;
  }

  Future<bool> deleteDocument(Homework homework, String filename) async {
    final authData = _getAuthData();
    final d = DeleteDocumentBody(
      docTypeFolder: 'homework',
      filename: filename,
      uploadDate: DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(homework.startDate?.split(' ').first ?? '')),
      randomNo: '1',
      shortName: authData.shortName,
    );
    // Utils.debLog(h.toJson());
    final res = await _homeworkService.deleteDocument(d);

    if (!authData.isValid) return false;
    state = AsyncLoading();
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final h = CreateHomeworkBody.fromJson(homework.toJson()).copyWith(
      publish: 'N',
      loginType: 'T',
      randomNo: '1',
      academicYr: acdYear,
      teacherId: authData.regId,
      //startDate: DateTime.now().toString(),
      shortName: authData.shortName,
      operation: 'edit',
      deleteimagelist: [filename],
    );
    await _homeworkService.updateHomework(h);

    ref.invalidateSelf();
    return res;
  }

  Future<bool> createHomework(CreateHomeworkBody homework) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;
    state = AsyncLoading();
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final h = homework.copyWith(
        publish: 'N',
        loginType: 'T',
        randomNo: '1',
        academicYr: acdYear,
      
        teacherId: authData.regId,
        startDate: DateTime.now().toString(),
        shortName: authData.shortName);
    // Utils.debLog(h.toJson());
    final res = await _homeworkService.createHomework(h);
    ref.invalidateSelf();
    return res;
    // return false;
  }

  Future<bool> publishHomework(Homework homework) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;

    // Don't set state to AsyncLoading here - that causes white screen
    // state = const AsyncLoading();

    try {
      // prepare payload
      final d = HomeworkPublishBody.fromJson(homework.toJson());
      final temp = d.copyWith(
        publish: 'Y',
        loginType: 'T',
        shortName: authData.shortName,
      );

      // call API
      final res = await _homeworkService.publishHomework(temp);

      if (res) {
        // ✅ Refresh homework list after publish
        await refreshHomework();
        Utils.debLog("Homework published successfully");
        return true;
      } else {
        Utils.debLog("Failed to publish homework");
        return false;
      }
    } catch (e, st) {
      Utils.debLog("Error publishing homework: $e");
      return false;
    }
  }


  Future<bool> updateHomework(CreateHomeworkBody homework) async {
    final authData = _getAuthData();
    if (!authData.isValid) return false;
    state = const AsyncLoading();

    try {
      print('=== UPDATE HOMEWORK PROVIDER ===');
      print('Body files count: ${homework.files?.length ?? 0}');
      final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
      final h = homework.copyWith(
        publish: 'N',
        loginType: 'T',
        randomNo: homework.homeworkId,
        academicYr: acdYear,
        teacherId: authData.regId,
        startDate: DateTime.now().toString(),
        shortName: authData.shortName,
        operation: 'edit',
        files: homework.files,
      );

      final res = await _homeworkService.updateHomework(h);

      if (res) {
        // ✅ Update locally
        state = AsyncData([
          for (final hw in state.value ?? [])
            if (hw.homeworkId == h.homeworkId)
              hw.copyWith(
                // title: h.title,
                description: h.description,
                publish: 'N',
              )
            else
              hw,
        ]);
      }

      // ✅ Force refresh from server (to sync)
      ref.invalidateSelf();

      return res;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return false;
    }
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
