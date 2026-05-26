// lib/features/curriculum/LessonPlan/lesson_plan_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacherapp/features/curriculum/LessonPlan/view/manage_tab_viewmodel.dart';
import 'package:teacherapp/features/curriculum/LessonPlan/view/plan_tab_viewmodel.dart';

import '../models/lesson_plan_models.dart';
import '../../../auth/providers/auth_provider.dart';
import 'edit_lesson_plan_screen.dart';

class LessonPlanPage extends StatefulWidget {
  const LessonPlanPage({super.key});

  @override
  State<LessonPlanPage> createState() => _LessonPlanPageState();
}

class _LessonPlanPageState extends State<LessonPlanPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Plan'),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 2.5,
          tabs: const [
            Tab(text: 'Manage'),
            Tab(text: 'Plan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const ManageTab(),
          PlanTab(onNavigateToManage: () => _tabController.animateTo(0)),
        ],
      ),
    );
  }
}

// Manage Tab
class ManageTab extends ConsumerStatefulWidget {
  const ManageTab({super.key});

  @override
  ConsumerState<ManageTab> createState() => _ManageTabState();
}

class _ManageTabState extends ConsumerState<ManageTab> {
  late ManageTabViewModel _viewModel;
  // final String unqId = '44259';

  @override
  void initState() {
    super.initState();

    final auth = ref.read(authProvider).requireValue;

    final String regId = auth.regId ?? '';
    _viewModel = ManageTabViewModel();
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.loadClasses(teacherId: regId);
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _confirmDelete(BuildContext context, LessonPlanData record) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Color(0xFFE53935), size: 24),
            SizedBox(width: 8),
            Text('Delete Lesson Plan', style: TextStyle(fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Are you sure you want to delete this lesson plan?'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('LessonPlan Id: ${record.lessonPlanId}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                  Text('Chapter: ${record.name}',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600)),
                  Text('Subject: ${record.subName}',
                      style: const TextStyle(fontSize: 12)),
                  Text('Class: ${record.fullClassName}',
                      style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
            // const SizedBox(height: 8),
            // const Text(
            //   'This action cannot be undone.',
            //   style: TextStyle(
            //       fontSize: 12,
            //       color: Color(0xFFE53935),
            //       fontWeight: FontWeight.w500),
            // ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel',
                style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await _viewModel.deleteLessonPlan(record.lessonPlanId);
              if (!mounted) return;
              if (_viewModel.deleteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text(_viewModel.deleteMessage),
                      ],
                    ),
                    backgroundColor: const Color(0xFF2E7D32),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(seconds: 2),
                  ),
                );
                _viewModel.clearDeleteState();
              } else if (_viewModel.error != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_viewModel.error!),
                    backgroundColor: const Color(0xFFC62828),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _openEdit(BuildContext context, LessonPlanData record) async {
    final refreshNeeded = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => EditLessonPlanScreen(record: record),
      ),
    );

    // Refresh list if update was successful
    if (refreshNeeded == true && mounted) {
      _viewModel.browseLessonPlans();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Card
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Select Class', required: true),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<TeacherClassData>(
                                value: _viewModel.selectedClass,
                                hint: const Text('Select Class'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                isExpanded: true, // Add this to make dropdown take full width
                                items: _viewModel.classes.map((classData) {
                                  return DropdownMenuItem(
                                    value: classData,
                                    child: Text(
                                      classData.fullClassName,
                                      style: const TextStyle(color: Colors.black),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) => _viewModel.selectClass(value),
                              ),
                              const SizedBox(height: 14),
                              _buildLabel('Select Subject'),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<SubjectData>(
                                value: _viewModel.selectedSubject,
                                hint: const Text('Select Subject'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                items: _viewModel.subjects.map((subject) {
                                  return DropdownMenuItem(
                                    value: subject,
                                    child: Text(subject.name),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    _viewModel.selectSubject(value),
                              ),
                              const SizedBox(height: 14),
                              _buildLabel('Select Sub-Subject'),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: null,
                                hint: const Text('Select'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                items: const [],
                                onChanged: null,
                              ),
                              const SizedBox(height: 16),
                              if (_viewModel.error != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Text(
                                    _viewModel.error!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              // In the ManageTab build method, update the Browse button

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => _viewModel.browseLessonPlans(), // Changed to use browse method
                                  icon: const Icon(Icons.search),
                                  label: _viewModel.isLoading
                                      ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                      : const Text('Browse'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1976D2),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),

// Also add a "Show All" button next to the dropdowns (optional)
// Add this after the Sub-Subject dropdown

                              // const SizedBox(height: 8),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: TextButton.icon(
                              //         onPressed: () => _viewModel.clearFilters(),
                              //         icon: const Icon(Icons.clear_all, size: 16),
                              //         label: const Text('Show All Lesson Plans'),
                              //         style: TextButton.styleFrom(
                              //           foregroundColor: const Color(0xFF1976D2),
                              //           padding: const EdgeInsets.symmetric(vertical: 8),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Search Bar
                      Card(
                        elevation: 2,
                        child: TextField(
                          onChanged: (v) => _viewModel.updateSearchQuery(v),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: const Icon(Icons.search, size: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Horizontal Scroll Table
                      if (_viewModel.lessonPlans.isNotEmpty)
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Table Header
                                Container(
                                  color: const Color(0xFFE3F2FD),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 14,
                                  ),
                                  child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          'Class',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Subject',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          'Chapter',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Week',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 95,
                                        child: Text(
                                          'Status',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 70,
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Table Body
                                ..._viewModel.filteredLessonPlans
                                    .asMap()
                                    .entries
                                    .map((entry) => _buildTableRow(
                                    entry.value, entry.key)),
                              ],
                            ),
                          ),
                        )
                      else if (!_viewModel.isLoading &&
                          _viewModel.selectedClass != null &&
                          _viewModel.selectedSubject != null)
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.storage_outlined,
                                  size: 32,
                                  color: Colors.black26,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'No data available in table',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(LessonPlanData record, int index) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Class ───────────────────────────────────
          SizedBox(
            width: 60,
            child: Text(record.fullClassName,
                style: const TextStyle(fontSize: 13)),
          ),

          // ── Subject ─────────────────────────────────
          SizedBox(
            width: 80,
            child: Text(record.subName,
                style: const TextStyle(fontSize: 13)),
          ),

          // ── Chapter ─────────────────────────────────
          SizedBox(
            width: 120,
            child: Text(record.name,
                style: const TextStyle(fontSize: 13)),
          ),

          // ── Week ────────────────────────────────────
          SizedBox(
            width: 90,
            child: Text(record.weekDate,
                style: const TextStyle(fontSize: 13)),
          ),

          // ── Status Dropdown ──────────────────────────
          SizedBox(
            width: 100,
            child: _buildStatusDropdown(record),
          ),

          // ── Edit ────────────────────────────────────
          SizedBox(
            width: 70,
            child: IconButton(
              onPressed: () => _openEdit(context, record),
              icon: const Icon(Icons.edit, size: 18, color: Color(0xFF1976D2)),
              padding: const EdgeInsets.all(6),
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFFE3F2FD),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),

          // ── Delete ───────────────────────────────────
          SizedBox(
            width: 70,
            child: IconButton(
              onPressed: () => _confirmDelete(context, record),
              icon: const Icon(Icons.delete, size: 18, color: Color(0xFFE53935)),
              padding: const EdgeInsets.all(6),
              constraints: const BoxConstraints(),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFFFFEBEE),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }

// ── Status Dropdown Widget ────────────────────────────────────────
  Widget _buildStatusDropdown(LessonPlanData record) {
    // Map API value → dropdown value
    // null/"" → null, "C" → "C", "I" → "I"
    final String? currentValue = (record.status == 'C' || record.status == 'I')
        ? record.status
        : null;

    Color borderColor;
    Color bgColor;
    Color textColor;

    switch (currentValue) {
      case 'C':
        borderColor = Colors.green.shade400;
        bgColor = Colors.green.withOpacity(0.08);
        textColor = Colors.green[800]!;
        break;
      case 'I':
        borderColor = Colors.orange.shade400;
        bgColor = Colors.orange.withOpacity(0.08);
        textColor = Colors.orange[800]!;
        break;
      default:
        borderColor = Colors.grey.shade400;
        bgColor = Colors.grey.withOpacity(0.06);
        textColor = Colors.black54;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: currentValue,
          isDense: true,
          icon: Icon(Icons.keyboard_arrow_down,
              size: 16, color: textColor),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
          items: const [
            DropdownMenuItem<String?>(
              value: null,
              child: Text(
                'Select',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ),
            DropdownMenuItem<String?>(
              value: 'I',
              child: Text(
                'Incomplete',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            DropdownMenuItem<String?>(
              value: 'C',
              child: Text(
                'Complete',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
          onChanged: (newValue) async {
            await _viewModel.updateLessonPlanStatus(
              lessonPlanId: record.lessonPlanId,
              status: newValue, // null for "Select", "C" or "I" otherwise
            );
            if (!mounted) return;
            if (_viewModel.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.white, size: 20),
                      const SizedBox(width: 10),
                      Text(_viewModel.error!),
                    ],
                  ),
                  backgroundColor: const Color(0xFFC62828),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(Icons.check_circle,
                          color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text('Status updated successfully'),
                    ],
                  ),
                  backgroundColor: const Color(0xFF2E7D32),
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// Plan Tab
// Updated PlanTab class - replace the DropdownButtonFormField sections

class PlanTab extends ConsumerStatefulWidget {
  final VoidCallback? onNavigateToManage;
  const PlanTab({super.key, this.onNavigateToManage});

  @override
  ConsumerState<PlanTab> createState() => _PlanTabState();
}

class _PlanTabState extends ConsumerState<PlanTab> {
  late PlanTabViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final auth = ref.read(authProvider).requireValue;

    final String regId = auth.regId ?? '';
    _viewModel = PlanTabViewModel();
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.loadClasses(teacherId: regId);
  }

  void _onViewModelChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Select Class', required: true),
                              const SizedBox(height: 6),
                              // FIXED: Changed from ClassData to TeacherClassData
                              DropdownButtonFormField<TeacherClassData>(
                                value: _viewModel.selectedClass,
                                hint: const Text('Select Class'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                items: _viewModel.classes.map((classData) {
                                  return DropdownMenuItem<TeacherClassData>(
                                    value: classData,
                                    child: Text(
                                      classData.fullClassName,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    _viewModel.selectClass(value),
                              ),
                              const SizedBox(height: 14),
                              _buildLabel('Select Subject', required: true),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<SubjectData>(
                                value: _viewModel.selectedSubject,
                                hint: const Text('Select Subject'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                items: _viewModel.subjects.map((subject) {
                                  return DropdownMenuItem<SubjectData>(
                                    value: subject,
                                    child: Text(subject.name),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    _viewModel.selectSubject(value),
                              ),
                              const SizedBox(height: 14),
                              _buildLabel('Select Chapter', required: true),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<ChapterData>(
                                value: _viewModel.selectedChapter,
                                hint: const Text('Select Chapter'),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 12,
                                  ),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                ),
                                items: _viewModel.chapters.map((chapter) {
                                  return DropdownMenuItem<ChapterData>(
                                    value: chapter,
                                    child: Text(
                                      '${chapter.chapterNo}. ${chapter.name}',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) => _viewModel.selectChapter(value),
                              ),
                              const SizedBox(height: 14),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _viewModel.selectedClass != null &&
                                      _viewModel.selectedSubject != null
                                      ? () => _viewModel.browse()
                                      : null,
                                  icon: const Icon(Icons.search),
                                  label: _viewModel.isLoading
                                      ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    ),
                                  )
                                      : const Text('Browse'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1976D2),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (_viewModel.isFormVisible) ...[
                        const SizedBox(height: 10),

                        // ── Info chips + Periods / Date ──────────────────────────────
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Wrap(
                                //   spacing: 6,
                                //   runSpacing: 6,
                                //   children: [
                                //     _infoChip('Class: ${_viewModel.selectedClass?.fullClassName ?? ''}'),
                                //     _infoChip('Subject: ${_viewModel.selectedSubject?.name ?? ''}'),
                                //     _infoChip('Chapter: ${_viewModel.selectedChapter?.name ?? ''}'),
                                //   ],
                                // ),
                                // const SizedBox(height: 14),
                                Row(
                                  children: [
                                    Expanded(
                                      flex:3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(child: _buildLabel('No. of Periods', required: true)),
                                          const SizedBox(height: 6),
                                          TextField(
                                            controller: _viewModel.periodsController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: '0',
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: _viewModel.periodsError != null
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: _viewModel.periodsError != null
                                                      ? Colors.red
                                                      : Colors.grey,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: _viewModel.periodsError != null
                                                      ? Colors.red
                                                      : const Color(0xFF1976D2),
                                                  width: 2,
                                                ),
                                              ),
                                              errorText: _viewModel.periodsError,
                                              contentPadding: const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 12),
                                              isDense: true,
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            onChanged: (_) => _viewModel.clearFieldErrors(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex:8,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(child: _buildLabel('Date (Week)', required: true)),
                                          const SizedBox(height: 6),
                                          TextField(
                                            controller: _viewModel.dateController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              hintText: 'Select week',
                                              suffixIcon: const Icon(Icons.calendar_today, size: 16),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: _viewModel.dateError != null ? Colors.red : Colors.grey,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: _viewModel.dateError != null ? Colors.red : Colors.grey,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: _viewModel.dateError != null
                                                      ? Colors.red
                                                      : const Color(0xFF1976D2),
                                                  width: 2,
                                                ),
                                              ),
                                              errorText: _viewModel.dateError,
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                                              isDense: true,
                                              fillColor: Colors.white,
                                              filled: true,
                                            ),
                                            onTap: () async {
                                              final weekRange = await showWeekPickerDialog(context);
                                              if (weekRange != null) {
                                                _viewModel.dateController.text = weekRange;
                                                _viewModel.clearFieldErrors();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // ── Teaching Details (dynamic from API, horizontal table) ────
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Teaching Details',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 12),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Header row
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE3F2FD),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                          ),
                                          child: const Row(
                                            children: [
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  'Field',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF1565C0),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 200,
                                                child: Text(
                                                  'Content',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF1565C0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Dynamic rows from API
                                        ..._viewModel.lessonPlanFields.map((field) {
                                          return _buildDynamicDetailRow(
                                            field.headingName,
                                            _headingIcon(field.lessonPlanHeadingsId),
                                            field.controller,
                                          );
                                        }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // ── Teaching Points (static, horizontal table) ───────────────
                        Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Teaching Points',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    FloatingActionButton.small(
                                      onPressed: () => _viewModel.addTeachingPoint(),
                                      backgroundColor: const Color(0xFF1976D2),
                                      child: const Icon(Icons.add, color: Colors.white, size: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Header row
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 12),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE3F2FD),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                          ),
                                          child: const Row(
                                            children: [
                                              SizedBox(
                                                width: 130,
                                                child: Text(
                                                  'Start Date*',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF1565C0),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 160,
                                                child: Text(
                                                  'Teaching Points*',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF1565C0),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                                child: Text(
                                                  'Action',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xFF1565C0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Teaching point rows
                                        ..._viewModel.teachingPoints.asMap().entries.map(
                                              (e) => _buildTeachingRow(e.key, e.value),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // ── Action Buttons ────────────────────────────────────────────
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final periodsEmpty = _viewModel.periodsController.text.trim().isEmpty;
                                  final dateEmpty = _viewModel.dateController.text.trim().isEmpty;
                                  final teachingPointsInvalid = _viewModel.teachingPoints.any((p) => p.dateController.text.trim().isEmpty);
                                  final teachingPointsInvalid2 = _viewModel.teachingPoints.any((p) =>
                                  p.pointController.text.trim().isEmpty);

                                  if (periodsEmpty || dateEmpty || teachingPointsInvalid|| teachingPointsInvalid2 ) {
                                    _viewModel.saveLessonPlan(); // triggers _validateForm() to show red borders

                                    String msg = 'Please fill all required fields';
                                    if (periodsEmpty && dateEmpty) {
                                      msg = 'Please fill No. of Periods and select a Week';
                                    } else if (periodsEmpty) {
                                      msg = 'Please fill No. of Periods';
                                    } else if (dateEmpty) {
                                      msg = 'Please select a Week';
                                    } else if (teachingPointsInvalid) {
                                      msg = 'Start date is mandatory for all periods.';
                                    } else if (teachingPointsInvalid2) {
                                      msg = 'Please add teaching points before saving';
                                    }

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            const Icon(Icons.warning_amber_rounded,
                                                color: Colors.white, size: 20),
                                            const SizedBox(width: 10),
                                            Expanded(child: Text(msg)),
                                          ],
                                        ),
                                        backgroundColor: const Color(0xFFC62828),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }

                                  await _viewModel.saveLessonPlan();
                                  if (!mounted) return;

                                  if (_viewModel.saveSuccess) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            const Icon(Icons.check_circle, color: Colors.white, size: 20),
                                            const SizedBox(width: 10),
                                            Text(_viewModel.saveMessage),
                                          ],
                                        ),
                                        backgroundColor: const Color(0xFF2E7D32),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                    _viewModel.clearSaveState();
                                    _viewModel.resetAll();
                                    widget.onNavigateToManage?.call();
                                  } else if (_viewModel.error != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Row(
                                          children: [
                                            const Icon(Icons.error_outline, color: Colors.white, size: 20),
                                            const SizedBox(width: 10),
                                            Expanded(child: Text(_viewModel.error!)),
                                          ],
                                        ),
                                        backgroundColor: const Color(0xFFC62828),
                                        behavior: SnackBarBehavior.floating,
                                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        duration: const Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Save'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1976D2),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _viewModel.resetForm(),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Reset'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF44336),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _viewModel.hideForm(),
                                icon: const Icon(Icons.close),
                                label: const Text('Close'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF9800),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
// Dynamic detail row for API-driven headings
  Widget _buildDynamicDetailRow(
      String title, IconData icon, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Icon(icon, size: 16, color: const Color(0xFF1565C0)),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 210,
            child: TextField(
              controller: controller,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                hintText: 'Enter details...',
                isDense: true,
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

// Maps heading ID to a relevant icon (fallback to notes icon)
  IconData _headingIcon(int headingId) {
    switch (headingId) {
      case 2: return Icons.track_changes;      // Learning Objectives
      case 3: return Icons.menu_book;          // Teaching Method
      case 4: return Icons.edit;               // Teaching Aids
      case 5: return Icons.military_tech;      // Learning Outcomes
      case 6: return Icons.groups;             // Students Activity
      case 7: return Icons.home_work;          // Homework / Assessment
      case 8: return Icons.notes;              // Notes
      case 9: return Icons.emoji_events;       // Activity (Quiz/Projects)
      case 88: return Icons.format_list_bulleted; // lesson plan edit non daily
      case 90: return Icons.calendar_view_month;  // Chapter Planning
      case 93: return Icons.map_outlined;         // Chapter plan
      case 95: return Icons.format_list_numbered; // test sequence
      default: return Icons.article_outlined;
    }
  }
  Widget _buildTeachingRow(int index, TeachingPointData point) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Start Date ──────────────────────────────
          SizedBox(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: point.dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'DD/MM/YYYY',
                    hintStyle: const TextStyle(fontSize: 10),
                    suffixIcon: const Icon(Icons.calendar_today, size: 14),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: point.dateError != null ? Colors.red : Colors.grey,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: point.dateError != null ? Colors.red : Colors.grey,
                      ),
                    ),
                    errorText: point.dateError,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 8),
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 12),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      point.dateController.text =
                      '${date.day}/${date.month}/${date.year}';
                      point.dateError = null;
                      _viewModel.clearFieldErrors();
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // ── Teaching Point ──────────────────────────
          SizedBox(
            width: 150,
            child: TextField(
              controller: point.pointController,
              decoration: InputDecoration(
                hintText: 'Enter teaching point...',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: point.pointError != null ? Colors.red : Colors.grey,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: point.pointError != null ? Colors.red : Colors.grey,
                  ),
                ),
                errorText: point.pointError,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 8),
                isDense: true,
              ),
              style: const TextStyle(fontSize: 12),
              maxLines: 2,
              onChanged: (_) {
                point.pointError = null;
                _viewModel.clearFieldErrors();
              },
            ),
          ),

          // ── Delete ──────────────────────────────────
          SizedBox(
            width: 60,
            child: IconButton(
              onPressed: () => _viewModel.removeTeachingPoint(index),
              icon: const Icon(Icons.delete_outline,
                  size: 20, color: Color(0xFFE53935)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1565C0),
        ),
      ),
    );
  }
}

// Shared Helpers
Widget _buildLabel(String text, {bool required = false}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0.3,
      ),
      children: required
          ? const [
        TextSpan(
          text: ' *',
          style: TextStyle(color: Color(0xFFE53935)),
        ),
      ]
          : [],
    ),
  );
}

Widget _buildDropdown({
  required String? value,
  required String hint,
  required List<String> items,
  required void Function(String?) onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    hint: Text(
      hint,
      style: const TextStyle(fontSize: 14, color: Colors.black54),
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      isDense: true,
      fillColor: Colors.white,
      filled: true,
    ),
    items: items
        .map((e) => DropdownMenuItem(
      value: e,
      child: Text(e, style: const TextStyle(fontSize: 14)),
    ))
        .toList(),
    onChanged: onChanged,
  );
}