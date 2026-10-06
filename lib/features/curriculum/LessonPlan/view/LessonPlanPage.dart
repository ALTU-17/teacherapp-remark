// lib/features/curriculum/LessonPlan/lesson_plan_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/features/curriculum/LessonPlan/view/manage_tab_viewmodel.dart';
import 'package:teacherapp/features/curriculum/LessonPlan/view/plan_tab_viewmodel.dart';

import '../models/lesson_plan_models.dart';
import '../../../auth/providers/auth_provider.dart';
import 'edit_lesson_plan_screen.dart' hide TeachingPointData;

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
        toolbarHeight: 40.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lesson Plan",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFE91E63),
                const Color(0xFF3F51B5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
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
              await _viewModel.deleteLessonPlan(record.unqId);
              if (!mounted) return;
              if (_viewModel.deleteSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text(_viewModel.deleteMessage),
                      ],
                    ),
                    backgroundColor: const Color(0xFF2E7D32),
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                              // Row 1: Class + Subject (side by side)
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Select Class', required: false),
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
                                          isExpanded: true,
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildLabel('Select Subject', required: false),
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),

                              // Row 2: Sub-Subject + Browse Button (side by side)
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Empty label for alignment
                                        const SizedBox(height: 22),
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton.icon(
                                            onPressed: () => _viewModel.browseLessonPlans(),
                                            icon: const Icon(Icons.search),
                                            label: _viewModel.isLoading
                                                ? const SizedBox(
                                              height: 25,
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              if (_viewModel.error != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  _viewModel.error!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),

                      // Search Bar
                      // Card(
                      //   elevation: 2,
                      //   child: TextField(
                      //     onChanged: (v) => _viewModel.updateSearchQuery(v),
                      //     decoration: InputDecoration(
                      //       hintText: 'Search...',
                      //       prefixIcon: const Icon(Icons.search, size: 20),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(24),
                      //         borderSide: BorderSide.none,
                      //       ),
                      //       contentPadding: const EdgeInsets.symmetric(
                      //         horizontal: 16,
                      //         vertical: 10,
                      //       ),
                      //       fillColor: Colors.white,
                      //       filled: true,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 5),

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
              lessonPlanId: record.unqId,
              status: newValue,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                        child: Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Icon(Icons.playlist_add_rounded, color: Colors.blue.shade700, size: 20.w),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    'Create Lesson Plan',
                                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                                  ),
                                ],
                              ),
                              SizedBox(height: 14.h),
                              // Replace the first Row (Class + Subject) with:
                              _buildMultiClassSelector(),
                              SizedBox(height: 10.h),
                              _buildStyledDropdown<SubjectData>(
                                value: _viewModel.selectedSubject,
                                hint: 'Select Subject',
                                items: _viewModel.subjects,
                                displayValue: (item) => item?.name ?? '',
                                onChanged: (value) => _viewModel.selectSubject(value),
                                isRequired: true,
                              ),
                              SizedBox(height: 10.h),
// Keep Chapter + Browse row as-is
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildStyledDropdown<ChapterData>(
                                      value: _viewModel.selectedChapter,
                                      hint: 'Select Chapter',
                                      items: _viewModel.chapters,
                                      displayValue: (item) =>
                                      item != null ? '${item.chapterNo}. ${item.name}' : '',
                                      onChanged: (value) => _viewModel.selectChapter(value),
                                      isRequired: true,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: SizedBox(
                                        height: 50.h,
                                        child: ElevatedButton.icon(
                                          onPressed: _viewModel.selectedClasses.isNotEmpty &&
                                              _viewModel.selectedSubject != null
                                              ? () => _viewModel.browse()
                                              : null,
                                          icon: _viewModel.isLoading
                                              ? SizedBox(
                                            width: 18.w,
                                            height: 18.h,
                                            child: const CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                              AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                              : Icon(Icons.search_rounded, size: 18.w),
                                          label: Text(_viewModel.isLoading ? 'Loading...' : 'Browse'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue.shade700,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.r)),
                                            disabledBackgroundColor: Colors.grey.shade400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Add inside the Card, after the Chapter + Browse row:
                              if (_viewModel.error != null)
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(12.w),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade50,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(color: Colors.red.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.info_outline_rounded,
                                            color: Colors.red.shade700, size: 18.w),
                                        SizedBox(width: 8.w),
                                        if(_viewModel.error == 'Lesson Plan Template is not created!!!')
                                          Expanded(
                                            child: Text(
                                              _viewModel.error!,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.red.shade700,
                                              ),
                                            ),
                                          ) else  Expanded(
                                          child: Text(
                                            'Chapters not created',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.red.shade700,
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
                      if (_viewModel.isFormVisible) _buildFormContent(),
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

  Widget _buildMultiClassSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Select Class',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: _viewModel.classSelectionError != null
                  ? Colors.red
                  : Colors.grey.shade300,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Selected chips ────────────────────────
              if (_viewModel.selectedClasses.isNotEmpty)
                Padding(
                  padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 0),
                  child: Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children: _viewModel.selectedClasses.map((cls) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              cls.fullClassName,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            GestureDetector(
                              onTap: () =>
                                  _viewModel.toggleClassSelection(cls),
                              child: Icon(
                                Icons.close_rounded,
                                size: 14.w,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

              // ── Dropdown row ──────────────────────────
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<TeacherClassData>(
                          value: null, // always null so hint shows
                          hint: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Text(
                              _viewModel.selectedClasses.isEmpty
                                  ? 'Select Class'
                                  : 'Add another section',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          isExpanded: true,
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.grey.shade600,
                          ),
                          items: _viewModel.classes.map((cls) {
                            final isSelected = _viewModel.selectedClasses
                                .any((c) => c.sectionId == cls.sectionId);
                            return DropdownMenuItem<TeacherClassData>(
                              value: cls,
                              child: Row(
                                children: [
                                  if (isSelected)
                                    Icon(Icons.check_rounded,
                                        size: 16.w,
                                        color: Colors.blue.shade700),
                                  if (isSelected) SizedBox(width: 6.w),
                                  Text(
                                    cls.fullClassName,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: isSelected
                                          ? Colors.blue.shade700
                                          : Colors.black87,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              _viewModel.toggleClassSelection(value);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  // Clear all button
                  if (_viewModel.selectedClasses.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () => _viewModel.clearClassSelection(),
                        child: Icon(
                          Icons.close_rounded,
                          size: 18.w,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        // ── Validation error ──────────────────────────
        if (_viewModel.classSelectionError != null)
          Padding(
            padding: EdgeInsets.only(top: 6.h, left: 4.w),
            child: Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    size: 14.w, color: Colors.red.shade700),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    _viewModel.classSelectionError!,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
  Widget _buildStyledDropdown<T>({
    required T? value,
    required String hint,
    required List<T> items,
    required String Function(T?) displayValue,
    required void Function(T?) onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: hint,
            style: TextStyle(fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700),
            children: isRequired
                ? [
              TextSpan(text: ' *', style: TextStyle(color: Colors.red.shade700))
            ]
                : [],
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            hint: Text('Select $hint',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500)),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w, vertical: 8.h),
              isDense: true,
            ),
            isExpanded: true,
            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(
                  displayValue(item),
                  style: TextStyle(fontSize: 13.sp, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: onChanged,
            icon: Icon(
                Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }

  Widget _buildFormContent() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            SizedBox(height: 16.h),

            // Periods & Date
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildTextField(
                    controller: _viewModel.periodsController,
                    label: 'No. of Periods *',
                    hint: 'Enter number',
                    keyboardType: TextInputType.number,
                    errorText: _viewModel.periodsError,
                    icon: Icons.numbers_rounded,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 3,
                  child: _buildDatePickerField(
                    controller: _viewModel.dateController,
                    label: 'Week Date *',
                    hint: 'Select week',
                    errorText: _viewModel.dateError,
                    onTap: () async {
                      final result = await showWeekPickerDialog(context);
                      if (result != null) {
                        // ✅ Store week range + start/end dates in viewmodel
                        _viewModel.setSelectedWeek(result.label, result.start, result.end);
                      }

                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Teaching Details
            _buildTeachingDetails(),
            SizedBox(height: 16.h),

            // Teaching Points
            _buildTeachingPoints(),
            SizedBox(height: 16.h),

            // Action Buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? errorText,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
        ),
        SizedBox(height: 4.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            prefixIcon: icon != null ? Icon(icon, size: 18.w, color: Colors.grey.shade500) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.blue.shade700, width: 2),
            ),
            errorText: errorText,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            isDense: true,
            fillColor: Colors.white,
            filled: true,
          ),
          style: TextStyle(fontSize: 14.sp),
          onChanged: (_) => _viewModel.clearFieldErrors(),
        ),
      ],
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? errorText,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey.shade700),
        ),
        SizedBox(height: 4.h),
        TextField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            suffixIcon: Icon(Icons.calendar_today_rounded, size: 18.w, color: Colors.grey.shade500),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: errorText != null ? Colors.red : Colors.blue.shade700, width: 2),
            ),
            errorText: errorText,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            isDense: true,
            fillColor: Colors.white,
            filled: true,
          ),
          style: TextStyle(fontSize: 14.sp),
          onTap: onTap,
        ),
      ],
    );
  }

  // Widget _buildInfoChip(String label, Color color) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
  //     decoration: BoxDecoration(
  //       color: color.withOpacity(0.1),
  //       borderRadius: BorderRadius.circular(20.r),
  //       border: Border.all(color: color.withOpacity(0.3)),
  //     ),
  //     child: Text(
  //       label,
  //       style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: color.shade700),
  //     ),
  //   );
  // }

  Widget _buildTeachingDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book_rounded, color: Colors.blue.shade700, size: 18.w),
            SizedBox(width: 8.w),
            Text('Teaching Details', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 140.w, child: Text('Field', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: Colors.blue.shade700))),
                    Expanded(child: Text('Content', style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w700, color: Colors.blue.shade700))),
                  ],
                ),
              ),
              // Rows
              ..._viewModel.lessonPlanFields.map((field) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140.w,
                        child: Row(
                          children: [
                            Icon(_headingIcon(field.lessonPlanHeadingsId), size: 16.w, color: Colors.blue.shade700),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Text(
                                field.headingName,
                                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: field.controller,
                          maxLines: null, // ✅ allows unlimited lines
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                            hintText: '• Enter details...',
                            isDense: true,
                          ),
                          style: TextStyle(fontSize: 12.sp),
                          onChanged: (value) {
                            // Auto-add bullet when typing starts or new line added
                            if (value.isNotEmpty) {
                              _applyBulletFormatting(field.controller);
                            }
                          },
                          onTap: () {
                            // Add first bullet when field is tapped and empty
                            if (field.controller.text.isEmpty) {
                              field.controller.value = const TextEditingValue(
                                text: '• ',
                                selection: TextSelection.collapsed(offset: 2),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTeachingPoints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.list_alt_rounded, color: Colors.blue.shade700, size: 18.w),
            SizedBox(width: 8.w),
            Text('Teaching Points',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            const Spacer(),
            FloatingActionButton.small(
              onPressed: () => _viewModel.addTeachingPoint(),
              backgroundColor: Colors.blue.shade700,
              child: Icon(Icons.add_rounded, color: Colors.white, size: 18.w),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width - 32.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Dynamic Header ────────────────────────
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                      ),
                      child: Row(
                        children: [
                          // Fixed: Start Date column
                          SizedBox(
                            width: 140.w,
                            child: Text(
                              'Start Date*',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          // Dynamic: one column per daily heading
                          ..._viewModel.dailyHeadingsList.map((h) => SizedBox(
                            width: 180.w, // Fixed width for each day column
                            child: Text(
                              '${    h.name}*',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue.shade700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )),
                          // Fixed: Action column
                          SizedBox(
                            width: 50.w,
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue.shade700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ── Rows ─────────────────────────────────
                    ..._viewModel.teachingPoints.asMap().entries.map(
                          (e) => _buildTeachingRow(
                        e.key, e.value, _viewModel.dailyHeadingsList,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTeachingRow(
      int index, TeachingPointData point, List<LessonPlanHeadingDaily> headings) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: index < _viewModel.teachingPoints.length - 1
              ? BorderSide(color: Colors.grey.shade200)
              : BorderSide.none,
        ),
        color: index.isEven ? Colors.white : Colors.grey.shade50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Start Date ──────────────────────────────
          SizedBox(
            width: 140.w,
            child: TextField(
              controller: point.dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'DD/MM/YYYY',
                hintStyle: TextStyle(fontSize: 11.sp),
                suffixIcon: Icon(Icons.calendar_today_rounded, size: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                      color: point.dateError != null
                          ? Colors.red
                          : Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                      color: point.dateError != null
                          ? Colors.red
                          : Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                      color: point.dateError != null
                          ? Colors.red
                          : Colors.blue.shade700,
                      width: 2),
                ),
                errorText: point.dateError,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                isDense: true,
                errorStyle: TextStyle(fontSize: 10.sp),
              ),
              style: TextStyle(fontSize: 12.sp),
              onTap: () async {
                if (_viewModel.selectedWeekStart == null ||
                    _viewModel.selectedWeekEnd == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Row(children: [
                        Icon(Icons.warning_amber_rounded,
                            color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text('Please select a week first'),
                      ]),
                      backgroundColor: const Color(0xFFC62828),
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                final date = await showDatePicker(
                  context: context,
                  initialDate: _viewModel.selectedWeekStart!,
                  firstDate: _viewModel.selectedWeekStart!,
                  lastDate: _viewModel.selectedWeekEnd!,
                );

                if (date != null) {
                  point.dateController.text =
                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                  point.dateError = null;
                  _viewModel.clearFieldErrors();
                  setState(() {});
                }
              },
            ),
          ),
          SizedBox(width: 8.w),

          // ── Dynamic columns per daily heading ───────
          ...headings.map((heading) {
            final ctrl = point.dynamicControllers[heading.lessonPlanHeadingsId];
            if (ctrl == null) return const SizedBox.shrink();

            final isFirstHeading =
                heading.lessonPlanHeadingsId == headings.first.lessonPlanHeadingsId;

            return SizedBox(
              width: 180.w,
              child: Padding(
                padding: EdgeInsets.only(
                    right: heading == headings.last ? 0 : 8.w),
                child: TextField(
                  controller: ctrl,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 2,
                  decoration: InputDecoration(
                    hintText: '• ${heading.name}...',
                    hintStyle: TextStyle(fontSize: 11.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: isFirstHeading && point.pointError != null
                              ? Colors.red
                              : Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: isFirstHeading && point.pointError != null
                              ? Colors.red
                              : Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(
                          color: isFirstHeading && point.pointError != null
                              ? Colors.red
                              : Colors.blue.shade700,
                          width: 2),
                    ),
                    errorText: isFirstHeading ? point.pointError : null,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                    isDense: true,
                    errorStyle: TextStyle(fontSize: 10.sp),
                  ),
                  style: TextStyle(fontSize: 12.sp),
                  onTap: () {
                    if (ctrl.text.isEmpty) {
                      ctrl.value = const TextEditingValue(
                        text: '• ',
                        selection: TextSelection.collapsed(offset: 2),
                      );
                    }
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) _applyBulletFormatting(ctrl);
                    if (isFirstHeading) {
                      point.pointError = null;
                      _viewModel.clearFieldErrors();
                    }
                  },
                ),
              ),
            );
          }),

          // ── Delete ──────────────────────────────────
          SizedBox(
            width: 50.w,
            child: Center(
              child: IconButton(
                onPressed: () => _viewModel.removeTeachingPoint(index),
                icon: Icon(Icons.delete_outline_rounded,
                    size: 22.w, color: Colors.red.shade700),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                splashRadius: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: () async {
              // Validate fields
              final periodsEmpty = _viewModel.periodsController.text.trim().isEmpty;
              final dateEmpty = _viewModel.dateController.text.trim().isEmpty;
              final teachingPointsInvalid = _viewModel.teachingPoints.any((p) => p.dateController.text.trim().isEmpty);

              final teachingPointsInvalid2 = _viewModel.teachingPoints.any((p) {
                if (_viewModel.dailyHeadingsList.isEmpty) return false;
                final firstHeadingId = _viewModel.dailyHeadingsList.first.lessonPlanHeadingsId;
                final ctrl = p.dynamicControllers[firstHeadingId];
                return ctrl == null || ctrl.text.trim().isEmpty;
              });

              if (periodsEmpty || dateEmpty || teachingPointsInvalid || teachingPointsInvalid2) {
                _viewModel.saveLessonPlan();

                String msg = 'Please fill all required fields';
                if (periodsEmpty && dateEmpty) msg = 'Please fill No. of Periods and select a Week';
                else if (periodsEmpty) msg = 'Please fill No. of Periods';
                else if (dateEmpty) msg = 'Please select a Week';
                else if (teachingPointsInvalid) msg = 'Start date is mandatory for all periods.';
                else if (teachingPointsInvalid2) msg = 'Please add teaching points before saving';

                _showSnackBar(msg, isSuccess: false);
                return;
              }

              await _viewModel.saveLessonPlan();
              if (!mounted) return;

              if (_viewModel.saveSuccess) {
                _showSnackBar(_viewModel.saveMessage, isSuccess: true);
                _viewModel.clearSaveState();
                _viewModel.resetAll();
                widget.onNavigateToManage?.call();
              } else if (_viewModel.error != null) {
                _showSnackBar(_viewModel.error!, isSuccess: false);
              }
            },
            icon: Icon(Icons.save_rounded, size: 18.w),
            label: Text('Save Lesson Plan'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _viewModel.resetForm(),
            icon: Icon(Icons.refresh_rounded, size: 18.w),
            label: Text('Reset'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.orange.shade700,
              side: BorderSide(color: Colors.orange.shade700),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _viewModel.hideForm(),
            icon: Icon(Icons.close_rounded, size: 18.w),
            label: Text('Close'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey.shade600,
              side: BorderSide(color: Colors.grey.shade400),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
            ),
          ),
        ),
      ],
    );
  }
  void _showSnackBar(String message, {required bool isSuccess}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error_outline,
              color: Colors.white,
              size: 20.w,
            ),
            SizedBox(width: 10.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isSuccess ? Colors.green.shade700 : Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        duration: Duration(seconds: 2),
      ),
    );
  }

  IconData _headingIcon(int headingId) {
    switch (headingId) {
      case 2: return Icons.track_changes_rounded;
      case 3: return Icons.menu_book_rounded;
      case 4: return Icons.edit_rounded;
      case 5: return Icons.military_tech_rounded;
      case 6: return Icons.groups_rounded;
      case 7: return Icons.home_work_rounded;
      case 8: return Icons.notes_rounded;
      case 9: return Icons.emoji_events_rounded;
      case 88: return Icons.format_list_bulleted_rounded;
      case 90: return Icons.calendar_view_month_rounded;
      case 93: return Icons.map_outlined;
      case 95: return Icons.format_list_numbered_rounded;
      default: return Icons.article_outlined;
    }
  }
}

// Auto-bullet: ensures every non-empty line starts with "• "
void _applyBulletFormatting(TextEditingController controller) {
  final text = controller.text;
  final selection = controller.selection;

  final lines = text.split('\n');
  final formattedLines = lines.map((line) {
    if (line.isEmpty) return line;
    if (line == '• ') return line; // don't double-bullet empty bullet lines
    if (line.startsWith('• ')) return line;
    return '• $line';
  }).toList();

  final newText = formattedLines.join('\n');

  if (newText != text) {
    // Calculate new cursor position accounting for added "• " prefixes
    int cursorPos = selection.baseOffset;

    // Count how many "• " were added before cursor
    int addedChars = 0;
    int charCount = 0;
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final lineEnd = charCount + line.length;

      if (cursorPos <= lineEnd) break;

      // This line is fully before cursor
      if (line.isNotEmpty && !line.startsWith('• ')) {
        addedChars += 2; // added "• "
      }
      charCount += line.length + 1; // +1 for '\n'
    }

    // Check if current line (where cursor is) also got a bullet added
    final currentLineStart = text.lastIndexOf('\n', cursorPos - 1) + 1;
    final currentLine = text.substring(currentLineStart,
        text.indexOf('\n', cursorPos) == -1 ? text.length : text.indexOf('\n', cursorPos));
    if (currentLine.isNotEmpty && !currentLine.startsWith('• ')) {
      addedChars += 2;
    }

    final newCursor = (cursorPos + addedChars).clamp(0, newText.length);

    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursor),
    );
  }
}

// Called on Enter key — adds bullet on new line
void _handleBulletEnter(TextEditingController controller) {
  final text = controller.text;
  final selection = controller.selection;
  if (!selection.isValid) return;

  final cursorPos = selection.baseOffset;
  final newText = '${text.substring(0, cursorPos)}\n• ${text.substring(cursorPos)}';
  final newCursor = cursorPos + 3; // '\n• ' = 3 chars

  controller.value = TextEditingValue(
    text: newText,
    selection: TextSelection.collapsed(offset: newCursor.clamp(0, newText.length)),
  );
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

