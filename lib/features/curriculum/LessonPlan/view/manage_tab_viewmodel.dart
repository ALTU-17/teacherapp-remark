// lib/viewmodels/manage_tab_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:teacherapp/features/curriculum/LessonPlan/services/lp_api_service.dart';
import '../models/lesson_plan_models.dart';

class ManageTabViewModel extends ChangeNotifier {
  final ApiService _apiService;

  // State variables
  List<TeacherClassData> _classes = [];
  List<SubjectData> _subjects = [];
  List<LessonPlanData> _lessonPlans = [];
  List<LessonPlanData> _allLessonPlans = []; // Store all lesson plans
  bool _isLoading = false;
  String? _error;
  List<LessonPlanData> _filteredLessonPlans = [];

  // Selected values
  TeacherClassData? _selectedClass;
  SubjectData? _selectedSubject;
  String _searchQuery = '';

  ManageTabViewModel({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  // Getters
  List<TeacherClassData> get classes => _classes;
  List<SubjectData> get subjects => _subjects;
  List<LessonPlanData> get lessonPlans => _lessonPlans;
  bool get isLoading => _isLoading;
  String? get error => _error;
  TeacherClassData? get selectedClass => _selectedClass;
  SubjectData? get selectedSubject => _selectedSubject;
  String get searchQuery => _searchQuery;

  List<LessonPlanData> get filteredLessonPlans {
    if (_searchQuery.isEmpty) return _lessonPlans;
    return _lessonPlans.where((plan) =>
    plan.fullClassName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        plan.subName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        plan.name.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  // Add these state variables
  bool _deleteSuccess = false;
  String _deleteMessage = '';
  bool get deleteSuccess => _deleteSuccess;
  String get deleteMessage => _deleteMessage;

  void clearDeleteState() {
    _deleteSuccess = false;
    _deleteMessage = '';
    notifyListeners();
  }

  Future<void> deleteLessonPlan(int lessonPlanId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.deleteLessonPlan(
        lessonPlanId: lessonPlanId,
      );

      if (response['success'] == true) {
        _deleteSuccess = true;
        _deleteMessage = response['message'] ?? 'Deleted successfully';

        // ✅ Remove from local list immediately — no re-fetch needed
        _lessonPlans.removeWhere((p) => p.unqId == lessonPlanId);
        _applySearch(); // re-apply search filter on updated list
      } else {
        _error = response['message'] ?? 'Failed to delete';
      }
    } catch (e) {
      _error = e.toString();
      print('Error deleting lesson plan: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateLessonPlanStatus({
    required int lessonPlanId,
    required String? status,
  }) async {
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.updateLessonPlanStatus(
        lessonPlanId: lessonPlanId,
        status: status,
      );

      if (response['success'] == true) {
        // ✅ Update status in local list immediately — no re-fetch needed
        final index = _lessonPlans.indexWhere((p) => p.unqId == lessonPlanId);
        if (index != -1) {
          _lessonPlans[index] = _lessonPlans[index].copyWith(status: status);
          _applySearch(); // re-apply search filter on updated list
        }
      } else {
        _error = response['message'] ?? 'Failed to update status';
      }
    } catch (e) {
      _error = e.toString();
      print('Error updating lesson plan status: $e');
    } finally {
      notifyListeners();
    }
  }

// ── Helper to re-apply search on the current _lessonPlans list ──
  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredLessonPlans = List.from(_lessonPlans);
    } else {
      final q = _searchQuery.toLowerCase();
      _filteredLessonPlans = _lessonPlans.where((p) {
        return p.name.toLowerCase().contains(q) ||
            p.subName.toLowerCase().contains(q) ||
            p.fullClassName.toLowerCase().contains(q);
      }).toList();
    }
  }
  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applySearch(); // ✅ use the shared helper
    notifyListeners();
  }

  // Load classes using teacher ID
  Future<void> loadClasses({required String teacherId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getClassesByTeacherId(teacherId: teacherId);
      if (response.success && response.data.isNotEmpty) {
        _classes = response.data;
        print('Classes loaded in ManageTab: ${_classes.length}');

        // After loading classes, load all lesson plans by default
        await loadAllLessonPlans();
      } else {
        _error = response.message;
      }
    } catch (e) {
      _error = e.toString();
      print('Error loading classes in ManageTab: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load all lesson plans for all classes
  Future<void> loadAllLessonPlans() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      List<LessonPlanData> allPlans = [];

      // Loop through all classes to get lesson plans
      for (var classData in _classes) {
        try {
          // First get subjects for this class
          final subjectsResponse = await _apiService.getSubjectsByClassAndSections(
            classId: classData.classId,
            sectionIds: [classData.sectionId],
          );

          if (subjectsResponse.status == 200 && subjectsResponse.data.isNotEmpty) {
            // For each subject, get lesson plans
            for (var subject in subjectsResponse.data) {
              try {
                final lessonPlanResponse = await _apiService.getLessonPlan(
                  classId: classData.classId,
                  sectionId: classData.sectionId,
                  smId: subject.smId,
                );
                allPlans.addAll(lessonPlanResponse.data);
              } catch (e) {
                print('Error loading lesson plan for class ${classData.fullClassName}, subject ${subject.name}: $e');
              }
            }
          }
        } catch (e) {
          print('Error loading subjects for class ${classData.fullClassName}: $e');
        }
      }

      _allLessonPlans = allPlans;
      _lessonPlans = allPlans;
      print('Total lesson plans loaded: ${_lessonPlans.length}');

    } catch (e) {
      _error = e.toString();
      print('Error loading all lesson plans: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load subjects based on selected class
  Future<void> loadSubjects() async {
    if (_selectedClass == null) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getSubjectsByClassAndSections(
        classId: _selectedClass!.classId,
        sectionIds: [_selectedClass!.sectionId],
      );

      if (response.status == 200 && response.data.isNotEmpty) {
        _subjects = response.data;
        print('Subjects loaded in ManageTab: ${_subjects.length}');
      } else {
        _error = response.message;
      }
    } catch (e) {
      _error = e.toString();
      print('Error loading subjects in ManageTab: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load lesson plans based on selected class and subject
  Future<void> loadLessonPlans() async {
    if (_selectedClass == null || _selectedSubject == null) {
      // If no selection, show all lesson plans
      _lessonPlans = _allLessonPlans;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.getLessonPlan(
        classId: _selectedClass!.classId,
        sectionId: _selectedClass!.sectionId,
        smId: _selectedSubject!.smId,
      );

      _lessonPlans = response.data;
      print('Filtered lesson plans loaded: ${_lessonPlans.length}');
      _applySearch();
    } catch (e) {
      _error = e.toString();
      print('Error loading lesson plans in ManageTab: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectClass(TeacherClassData? classData) {
    _selectedClass = classData;
    _selectedSubject = null;
    _subjects = [];

    if (classData != null) {
      // If a class is selected, load its subjects
      loadSubjects();
    } else {
      // If no class selected, show all lesson plans
      _lessonPlans = _allLessonPlans;
      notifyListeners();
    }

    notifyListeners();
  }

  void selectSubject(SubjectData? subjectData) {
    _selectedSubject = subjectData;
    notifyListeners();
    // Don't auto-load, wait for browse button click
  }

  // Method to browse/filter lesson plans
  Future<void> browseLessonPlans() async {
    if (_selectedClass != null && _selectedSubject != null) {
      await loadLessonPlans();
    } else {
      // If no selection, show all
      _lessonPlans = _allLessonPlans;
      notifyListeners();
    }
  }


  void clearFilters() {
    _selectedClass = null;
    _selectedSubject = null;
    _subjects = [];
    _lessonPlans = _allLessonPlans;
    _searchQuery = '';
    _error = null;
    notifyListeners();
  }
}