import 'package:flutter/cupertino.dart';

import '../models/lesson_plan_models.dart';
import '../services/lp_api_service.dart';

import 'package:flutter/material.dart';

class PlanTabViewModel extends ChangeNotifier {
  final ApiService _apiService;

  List<TeacherClassData> _classes = [];
  List<TeacherClassData> _selectedClasses = [];
  TeacherClassData? get selectedClass =>
      _selectedClasses.isNotEmpty ? _selectedClasses.first : null;

  List<TeacherClassData> get selectedClasses => _selectedClasses;

  List<SubjectData> _subjects = [];
  List<ChapterData> _chapters = [];
  bool _isLoading = false;
  bool _isFormVisible = false;
  String? _error;

  TeacherClassData? _selectedClass;
  SubjectData? _selectedSubject;
  ChapterData? _selectedChapter;

  // Static controllers
  final periodsController = TextEditingController();
  final dateController = TextEditingController();

  // Dynamic lesson plan headings from API
  List<LessonPlanFieldData> lessonPlanFields = [];
  bool presentData = false;
  int unqId = 0;
  int lesPlnTempId = 0;

  bool _saveSuccess = false;
  String _saveMessage = '';

  bool get saveSuccess => _saveSuccess;
  String get saveMessage => _saveMessage;

  void clearSaveState() {
    _saveSuccess = false;
    _saveMessage = '';
    notifyListeners();
  }
// Add field
  List<LessonPlanHeadingDaily> dailyHeadings = [];

// Getter
  List<LessonPlanHeadingDaily> get dailyHeadingsList => dailyHeadings;

  final List<TeachingPointData> teachingPoints = [TeachingPointData()];

  // ── Constructor ───────────────────────────────────────────────
  PlanTabViewModel({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  // ── Getters ───────────────────────────────────────────────────
  List<TeacherClassData> get classes => _classes;
  List<SubjectData> get subjects => _subjects;
  List<ChapterData> get chapters => _chapters;
  bool get isLoading => _isLoading;
  bool get isFormVisible => _isFormVisible;
  String? get error => _error;
  // TeacherClassData? get selectedClass => _selectedClass;
  SubjectData? get selectedSubject => _selectedSubject;
  ChapterData? get selectedChapter => _selectedChapter;



  // ── Load Classes ──────────────────────────────────────────────
  Future<void> loadClasses({required String teacherId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
      await _apiService.getClassesByTeacherId(teacherId: teacherId);
      if (response.success && response.data.isNotEmpty) {
        _classes = response.data;
      } else {
        _error = response.message;
      }
    } catch (e) {
      _error = e.toString();
      print('Error loading classes: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Load Subjects ─────────────────────────────────────────────
  Future<void> loadSubjects() async {
    if (_selectedClasses.isEmpty) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getSubjectsByClassAndSections(
        classId: _selectedClasses.first.classId,
        sectionIds: _selectedClasses.map((c) => c.sectionId).toList(), // ✅ all sections
      );

      if (response.status == 200 && response.data.isNotEmpty) {
        _subjects = response.data;
      } else {
        _error = response.message;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Load Chapters ─────────────────────────────────────────────
// ── Load Chapters (Fixed) ─────────────────────────────────────
  Future<void> loadChapters() async {
    if (_selectedClasses.isEmpty || _selectedSubject == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getChapterInfoByClassAndSubject(
        classId: _selectedClasses.first.classId, //  Fixed: Reading from the active list
        subjectId: _selectedSubject!.smId,
      );

      if (response.success && response.data.isNotEmpty) {
        _chapters = response.data;
      } else {
        _chapters = [];
        _error = response.message;
      }
    } catch (e) {
      _error = e.toString();
      print('Error loading chapters: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> loadLessonPlanDetails() async {
    if (_selectedClasses.isEmpty ||
        _selectedSubject == null ||
        _selectedChapter == null) {
      _error = 'Please select Class, Subject and Chapter';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final targetClass = _selectedClasses.first;

      // ✅ Fetch both in parallel
      final results = await Future.wait([
        _apiService.getLessonPlanDetails(
          classId: targetClass.classId,
          sectionId: targetClass.sectionId,
          smId: _selectedSubject!.smId,
          chapterId: _selectedChapter!.chapterId,
        ),
        _apiService.getLessonPlanHeadingDaily(),
      ]);

      final response = results[0] as LessonPlanDetailsResponse;
      final dailyResponse = results[1] as LessonPlanHeadingDailyResponse;

      // ✅ Handle API-level failure
      if (!response.success || response.data == null) {
        _error = response.message.isNotEmpty
            ? response.message
            : 'Lesson plan template is not available for this selection.';
        _isFormVisible = false;
        notifyListeners();
        return;
      }

      presentData = response.data!.presentData;
      unqId = response.data!.unqId;
      lesPlnTempId = response.data!.lesPlnTempId;

      // ✅ Store daily headings
      dailyHeadings = dailyResponse.success ? dailyResponse.data : [];

      // After: dailyHeadings = dailyResponse.success ? dailyResponse.data : [];
// Init existing teaching points' dynamic controllers:
      for (var point in teachingPoints) {
        point.initDynamicControllers(dailyHeadings);
      }

      for (var field in lessonPlanFields) {
        field.dispose();
      }

      lessonPlanFields = response.data!.lessonPlanInfo1.map((heading) {
        return LessonPlanFieldData(
          lesPlnTempId: heading.lesPlnTempId,
          classId: heading.classId,
          subjectId: heading.subjectId,
          chapterId: heading.chapterId,
          regId: heading.regId,
          publish: heading.publish,
          academicYr: heading.academicYr,
          lesPlnTempdetailsId: heading.lesPlnTempdetailsId,
          lessonPlanHeadingsId: heading.lessonPlanHeadingsId,
          headingName: heading.headingName,
          controller: TextEditingController(text: heading.description ?? ''),
        );
      }).toList();

      _isFormVisible = true;
    } catch (e) {
      _error = e.toString();
      print('Error loading lesson plan details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ── Selection Handlers ────────────────────────────────────────
  void toggleClassSelection(TeacherClassData classData) {
    // If already selected, remove it
    if (_selectedClasses.any((c) => c.sectionId == classData.sectionId)) {
      _selectedClasses.removeWhere((c) => c.sectionId == classData.sectionId);
      _selectedSubject = null;
      _selectedChapter = null;
      _subjects = [];
      _chapters = [];
      _isFormVisible = false;
      notifyListeners();
      if (_selectedClasses.isNotEmpty) loadSubjects();
      return;
    }

    // Validate: all selected must share the same classId
    if (_selectedClasses.isNotEmpty &&
        _selectedClasses.first.classId != classData.classId) {
      _classSelectionError =
      'Please select sections from the same class only!';
      notifyListeners();
      return;
    }

    _classSelectionError = null;
    _selectedClasses.add(classData);
    _selectedSubject = null;
    _selectedChapter = null;
    _subjects = [];
    _chapters = [];
    _isFormVisible = false;
    notifyListeners();

    loadSubjects();
  }

  void clearClassSelection() {
    _selectedClasses = [];
    _selectedSubject = null;
    _selectedChapter = null;
    _subjects = [];
    _chapters = [];
    _isFormVisible = false;
    _classSelectionError = null;
    notifyListeners();
  }

  String? _classSelectionError;
  String? get classSelectionError => _classSelectionError;

  void selectSubject(SubjectData? subjectData) {
    _selectedSubject = subjectData;
    _selectedChapter = null;
    _chapters = [];
    _isFormVisible = false;
    notifyListeners();

    if (subjectData != null) loadChapters();
  }

  void selectChapter(ChapterData? chapterData) {
    _selectedChapter = chapterData;
    _isFormVisible = false;
    notifyListeners();
  }

  // ── Browse ────────────────────────────────────────────────────
  Future<void> browse() async {
    if (_selectedClasses.isEmpty ||
        _selectedSubject == null ||
        _selectedChapter == null) {
      _error = 'Please select Class, Subject and Chapter';
      notifyListeners();
      return;
    }
    await loadLessonPlanDetails();
  }

  // ── Teaching Points ───────────────────────────────────────────
  void addTeachingPoint() {
    final point = TeachingPointData();
    point.initDynamicControllers(dailyHeadings); // ✅ init with current headings
    teachingPoints.add(point);
    notifyListeners();
  }

  void removeTeachingPoint(int index) {
    if (teachingPoints.length > 1) {
      teachingPoints.removeAt(index);
      notifyListeners();
    }
  }

  // ── Reset / Hide ──────────────────────────────────────────────
  void resetForm() {
    dailyHeadings = [];
    periodsController.clear();
    dateController.clear();
    _periodsError = null;
    _dateError = null;
    for (var field in lessonPlanFields) {
      field.controller.clear();
    }
    teachingPoints.clear();
    teachingPoints.add(TeachingPointData());
    notifyListeners();
  }

  void hideForm() {
    _isFormVisible = false;
    for (var field in lessonPlanFields) {
      field.dispose();
    }
    lessonPlanFields = [];
    periodsController.clear();
    dateController.clear();
    teachingPoints.clear();
    teachingPoints.add(TeachingPointData());
    notifyListeners();
  }

  String? _periodsError;
  String? _dateError;

  String? get periodsError => _periodsError;
  String? get dateError => _dateError;

  // Add these fields in PlanTabViewModel
  DateTime? selectedWeekStart;
  DateTime? selectedWeekEnd;

// Update clearFieldErrors to also reset when week changes
  void setSelectedWeek(String weekRange, DateTime start, DateTime end) {
    dateController.text = weekRange;
    selectedWeekStart = start;
    selectedWeekEnd = end;

    // Reset teaching point dates since week changed
    for (var point in teachingPoints) {
      point.dateController.clear();
      point.dateError = null;
    }
    clearFieldErrors();
    notifyListeners();
  }


  void clearFieldErrors() {
    _periodsError = null;
    _dateError = null;
    for (var point in teachingPoints) {
      point.dateError = null;
      point.pointError = null;
    }
    notifyListeners();
  }

  void resetAll() {

    selectedWeekStart = null;
    selectedWeekEnd = null;

    // Reset selections
    // _selectedClass = null;

    _selectedClasses = [];
    _classSelectionError = null;

    _selectedSubject = null;
    _selectedChapter = null;
    _subjects = [];
    _chapters = [];
    _isFormVisible = false;
    _error = null;

    // Reset static fields
    periodsController.clear();
    dateController.clear();
    _periodsError = null;
    _dateError = null;

    // Reset dynamic heading fields
    for (var field in lessonPlanFields) {
      field.dispose();
    }
    lessonPlanFields = [];
    presentData = false;
    unqId = 0;
    lesPlnTempId = 0;

    // Reset teaching points
    for (var point in teachingPoints) {
      point.dispose();
    }
    teachingPoints.clear();
    teachingPoints.add(TeachingPointData());

    notifyListeners();
  }

  bool _validateForm() {
    bool valid = true;

    if (periodsController.text.trim().isEmpty) {
      _periodsError = 'Required';
      valid = false;
    } else {
      _periodsError = null;
    }

    if (dateController.text.trim().isEmpty) {
      _dateError = 'Required';
      valid = false;
    } else {
      _dateError = null;
    }

    for (var point in teachingPoints) {
      if (point.dateController.text.trim().isEmpty) {
        point.dateError = 'Required';
        valid = false;
      } else {
        point.dateError = null;
      }

      // ✅ Validate first dynamic heading's controller (not the detached getter)
      if (dailyHeadings.isNotEmpty) {
        final firstHeadingId = dailyHeadings.first.lessonPlanHeadingsId;
        final ctrl = point.dynamicControllers[firstHeadingId];
        if (ctrl == null || ctrl.text.trim().isEmpty) {
          point.pointError = 'Required';
          valid = false;
        } else {
          point.pointError = null;
        }
      }
    }

    notifyListeners();
    return valid;
  }

  // ── Save ──────────────────────────────────────────────────────
// ── Save ──────────────────────────────────────────────────────
  Future<void> saveLessonPlan() async {
    if (!_validateForm()) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final classId = _selectedClasses.first.classId.toString();
      final List<String> classIdArray = _selectedClasses
          .map((c) => '$classId^${c.sectionId}')
          .toList();
      final smId = _selectedSubject!.smId.toString();
      final chapterId = _selectedChapter!.chapterId.toString();

      // Build description fields
      final Map<String, dynamic> descriptions = {};
      for (var field in lessonPlanFields) {
        descriptions['description_${field.lessonPlanHeadingsId}_1'] =
            field.controller.text;
      }

      // Build teaching point arrays
      final List<String> startDates = [];
      final Map<String, dynamic> dcDescriptions = {};

      for (int i = 0; i < teachingPoints.length; i++) {
        final point = teachingPoints[i];
        final row = i + 1;

        // Convert DD/MM/YYYY → YYYY-MM-DD
        final rawDate = point.dateController.text;
        String formattedDate = rawDate;
        if (rawDate.contains('/')) {
          final parts = rawDate.split('/');
          if (parts.length == 3) {
            formattedDate =
            '${parts[2].padLeft(4, '0')}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
          }
        }
        startDates.add(formattedDate);

        // ✅ Dynamic: one key per daily heading per row
        for (var heading in dailyHeadings) {
          final ctrl = point.dynamicControllers[heading.lessonPlanHeadingsId];
          dcDescriptions['dc_description_${heading.lessonPlanHeadingsId}_$row'] =
              ctrl?.text ?? '';
        }
      }

      final payload = <String, dynamic>{
        'class_id': classId,
        'section_id': _selectedClasses
            .map((c) => c.sectionId.toString())
            .join(','),
        'sm_id': smId,
        'chapter_id': chapterId,
        'class_id_array': classIdArray,
        'no_of_periods': periodsController.text,
        'weeklyDatePicker': dateController.text,
        'les_pln_temp_id': lesPlnTempId,
        'approve': 'N',
        'lph_dc_row': teachingPoints.length.toString(),
        'start_date': startDates,
        ...descriptions,
        ...dcDescriptions,
      };

      print('save_lesson_plan payload: $payload');

      final response = await _apiService.saveLessonPlan(payload: payload);

      if (response['success'] == true) {
        _saveSuccess = true;
        _saveMessage = response['message'] ?? 'Lesson Plan saved successfully!';
      } else {
        _error = response['message'] ?? 'Failed to save lesson plan';
      }
    } catch (e) {
      _error = e.toString();
      print('Error saving lesson plan: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  // ── Dispose ───────────────────────────────────────────────────
  @override
  void dispose() {
    periodsController.dispose();
    dateController.dispose();
    for (var field in lessonPlanFields) {
      field.dispose();
    }
    for (var point in teachingPoints) {
      point.dispose();
    }
    super.dispose();
  }
}


Future<({String label, DateTime start, DateTime end})?> showWeekPickerDialog(
    BuildContext context) async {
  DateTime focusedDay = DateTime.now();
  final now = DateTime.now();

  // ✅ Dart's weekday starts at 1 (Monday) and ends at 7 (Sunday).
  // This correctly finds the Monday of the current week.
  DateTime selectedWeekStart = now.subtract(Duration(days: now.weekday - 1));

  return await showDialog<({String label, DateTime start, DateTime end})>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setDialogState) {
          final weekStart = selectedWeekStart;
          final weekEnd = weekStart.add(const Duration(days: 6));

          String _fmt(DateTime d) =>
              '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

          final firstDayOfMonth =
          DateTime(focusedDay.year, focusedDay.month, 1);
          final lastDayOfMonth =
          DateTime(focusedDay.year, focusedDay.month + 1, 0);

          // ✅ Align grid to start on Monday
          final gridStart = firstDayOfMonth
              .subtract(Duration(days: firstDayOfMonth.weekday - 1));

          final List<DateTime> days = [];
          DateTime cursor = gridStart;
          while (cursor.isBefore(lastDayOfMonth) ||
              cursor.month == lastDayOfMonth.month) {
            days.add(cursor);
            cursor = cursor.add(const Duration(days: 1));
            if (days.length >= 42) break;
          }

          bool isInSelectedWeek(DateTime d) =>
              !d.isBefore(weekStart) && !d.isAfter(weekEnd);

          final monthNames = [
            'January', 'February', 'March', 'April', 'May', 'June',
            'July', 'August', 'September', 'October', 'November', 'December'
          ];

          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Month Navigation ──────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: () => setDialogState(() {
                          focusedDay = DateTime(
                              focusedDay.year, focusedDay.month - 1, 1);
                        }),
                      ),
                      Text(
                        '${monthNames[focusedDay.month - 1]} ${focusedDay.year}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () => setDialogState(() {
                          focusedDay = DateTime(
                              focusedDay.year, focusedDay.month + 1, 1);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ── Day Headers (Updated to start on Monday) ──
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su']
                        .map((d) => SizedBox(
                      width: 36,
                      child: Center(
                        child: Text(d,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1565C0),
                            )),
                      ),
                    ))
                        .toList(),
                  ),
                  const SizedBox(height: 4),

                  // ── Calendar Grid ─────────────────────────────
                  ...List.generate((days.length / 7).ceil(), (rowIndex) {
                    final rowDays =
                    days.skip(rowIndex * 7).take(7).toList();

                    // ✅ Updated targeting for Mon -> Sun row layout
                    final rowMonday = rowDays.first;
                    final rowSunday = rowDays.last;
                    final isSelectedRow = isInSelectedWeek(rowMonday) ||
                        isInSelectedWeek(rowSunday);

                    return GestureDetector(
                      onTap: () => setDialogState(
                              () => selectedWeekStart = rowMonday),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: isSelectedRow
                              ? const Color(0xFFBBDEFB)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: rowDays.map((day) {
                            final isCurrentMonth =
                                day.month == focusedDay.month;
                            final isToday = day.year == now.year &&
                                day.month == now.month &&
                                day.day == now.day;

                            return SizedBox(
                              width: 36,
                              height: 36,
                              child: Center(
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isToday
                                        ? const Color(0xFF1976D2)
                                        : Colors.transparent,
                                    // (Rest of your original button styling remains unchanged...)
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isToday
                                            ? FontWeight.w700
                                            : FontWeight.normal,
                                        color: isToday
                                            ? Colors.white
                                            : isCurrentMonth
                                            ? Colors.black87
                                            : Colors.black26,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 12),

                  // ── Selected range display ────────────────────
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.date_range,
                            size: 16, color: Color(0xFF1565C0)),
                        const SizedBox(width: 6),
                        Text(
                          '${_fmt(weekStart)} / ${_fmt(weekEnd)}',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Confirm / Cancel ──────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(ctx).pop(null),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop((
                          label: '${_fmt(weekStart)} / ${_fmt(weekEnd)}',
                          start: weekStart,
                          end: weekEnd,
                          )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1976D2),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
// ── Supporting Classes ────────────────────────────────────────────

class LessonPlanFieldData {
  final int lesPlnTempId;
  final int classId;
  final int subjectId;
  final int chapterId;
  final int regId;
  final String publish;
  final String academicYr;
  final int lesPlnTempdetailsId;
  final int lessonPlanHeadingsId;
  final String headingName;
  final TextEditingController controller;

  LessonPlanFieldData({
    required this.lesPlnTempId,
    required this.classId,
    required this.subjectId,
    required this.chapterId,
    required this.regId,
    required this.publish,
    required this.academicYr,
    required this.lesPlnTempdetailsId,
    required this.lessonPlanHeadingsId,
    required this.headingName,
    required this.controller,
  });

  void dispose() => controller.dispose();
}

class TeachingPointData {
  final TextEditingController dateController = TextEditingController();
  // dynamic: keyed by lessonPlanHeadingsId
  final Map<int, TextEditingController> dynamicControllers = {};

  // Keep pointController for backward compat (heading_id=1 = Teaching Points)
// Replace the getter in TeachingPointData:
  TextEditingController? get pointController {
    if (dynamicControllers.isEmpty) return null;
    // Return first heading's controller (whatever ID it is)
    return dynamicControllers.values.first;
  }

  String? dateError;
  String? pointError;

  // Initialize dynamic controllers from daily headings
  void initDynamicControllers(List<LessonPlanHeadingDaily> headings) {
    for (var h in headings) {
      if (!dynamicControllers.containsKey(h.lessonPlanHeadingsId)) {
        dynamicControllers[h.lessonPlanHeadingsId] = TextEditingController();
      }
    }
  }

  void dispose() {
    dateController.dispose();
    for (var c in dynamicControllers.values) {
      c.dispose();
    }
  }
}