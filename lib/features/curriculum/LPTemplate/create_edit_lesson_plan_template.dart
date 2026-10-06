// create_edit_lesson_plan_template.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'models.dart';

enum TemplateFormMode { create, edit }

class LessonPlanTemplateFormScreen extends StatefulWidget {
  final TemplateFormMode mode;
  final String className;
  final String subject;
  final String chapter;
  // For edit mode pass existing headings + values (from API)
  final List<TemplateFieldData>? existingFields;

  const LessonPlanTemplateFormScreen({
    super.key,
    required this.mode,
    required this.className,
    required this.subject,
    required this.chapter,
    this.existingFields,
  });

  @override
  State<LessonPlanTemplateFormScreen> createState() =>
      _LessonPlanTemplateFormScreenState();
}

class _LessonPlanTemplateFormScreenState
    extends State<LessonPlanTemplateFormScreen> {
  List<TemplateFieldData> _fields = [];
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _initFields();
  }

  void _initFields() {
    if (widget.existingFields != null && widget.existingFields!.isNotEmpty) {
      _fields = widget.existingFields!;
    } else {
      // TODO: fetch headings from API, e.g. getLessonPlanHeadingNonDaily()
      // Placeholder based on your web screenshot:
      _fields = [
        _f(1, 'demo'),
        _f(2, 'Learning Objectives'),
        _f(3, 'Teaching Method'),
        _f(4, 'Teaching Aids'),
        _f(5, 'Learning Outcomes'),
        _f(6, 'Students Activity'),
        _f(7, 'Homework/ Assessment'),
        _f(8, 'Notes'),
        _f(9, 'Activity ( Quiz/ Projects..)'),
      ];
    }
  }

  TemplateFieldData _f(int id, String name) => TemplateFieldData(
    headingId: id,
    headingName: name,
    controller: TextEditingController(),
  );

  @override
  void dispose() {
    for (var f in _fields) {
      f.dispose();
    }
    super.dispose();
  }

  bool get isEdit => widget.mode == TemplateFormMode.edit;

  Future<void> _onSave({required bool publish}) async {
    setState(() => _isSaving = true);
    try {
      // TODO: build payload from _fields + class/subject/chapter
      // e.g.
      // final payload = {
      //   'class_name': widget.className,
      //   'subject': widget.subject,
      //   'chapter': widget.chapter,
      //   'publish': publish ? 'Y' : 'N',
      //   for (var f in _fields) 'description_${f.headingId}_1': f.controller.text,
      // };
      await Future.delayed(const Duration(milliseconds: 400));

      if (!mounted) return;
      _showSnack(
        isEdit ? 'Template updated successfully' : 'Template saved successfully',
        true,
      );
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      _showSnack(e.toString(), false);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _reset() {
    setState(() {
      for (var f in _fields) {
        f.controller.clear();
      }
    });
  }

  void _showSnack(String msg, bool ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(ok ? Icons.check_circle : Icons.error_outline,
              color: Colors.white, size: 20.w),
          SizedBox(width: 10.w),
          Expanded(child: Text(msg)),
        ]),
        backgroundColor: ok ? Colors.green.shade700 : Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.white, size: 24.w),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: Text(
            isEdit ? 'Edit Lesson Plan Template' : 'Create Lesson Plan Template',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(14.w),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Info chips ──────────────────
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _chip(Icons.home_work_rounded, 'Class: ${widget.className}', Colors.purple),
                        _chip(Icons.menu_book_rounded, 'Subject: ${widget.subject}', Colors.blue),
                        _chip(Icons.edit_note_rounded, 'Chapter: ${widget.chapter}', Colors.orange),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // ── Horizontal table of dynamic headings ──
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // header row
                            Container(
                              color: Colors.grey.shade200,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 12.h),
                              child: Row(
                                children: _fields
                                    .map((f) => SizedBox(
                                  width: 190.w,
                                  child: Text(
                                    f.headingName,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ))
                                    .toList(),
                              ),
                            ),
                            // body row
                            Row(
                              children: _fields
                                  .map((f) => SizedBox(
                                width: 190.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: TextField(
                                    controller: f.controller,
                                    maxLines: 14,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(10.w),
                                      hintText: '',
                                    ),
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                              ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // ── Action buttons (match web) ──
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!isEdit) ...[
          _filledBtn(
            label: 'Save',
            color: Colors.blue,
            onTap: _isSaving ? null : () => _onSave(publish: false),
          ),
          SizedBox(width: 10.w),
          _filledBtn(
            label: 'Save & Publish',
            color: Colors.blue.shade700,
            onTap: _isSaving ? null : () => _onSave(publish: true),
          ),
          SizedBox(width: 10.w),
          _filledBtn(
            label: 'Reset',
            color: Colors.red,
            onTap: _isSaving ? null : _reset,
          ),
          SizedBox(width: 10.w),
          _filledBtn(
            label: 'Back',
            color: Colors.amber,
            onTap: _isSaving ? null : () => Navigator.of(context).pop(false),
          ),
        ] else ...[
          _filledBtn(
            label: 'Update',
            color: Colors.blue,
            onTap: _isSaving ? null : () => _onSave(publish: false),
          ),
          SizedBox(width: 10.w),
          _filledBtn(
            label: 'Update & Publish',
            color: Colors.blue.shade700,
            onTap: _isSaving ? null : () => _onSave(publish: true),
          ),
          SizedBox(width: 10.w),
          _filledBtn(
            label: 'Back',
            color: Colors.amber,
            onTap: _isSaving ? null : () => Navigator.of(context).pop(false),
          ),
        ],
      ],
    );
  }

  Widget _filledBtn({
    required String label,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 40.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: _isSaving && onTap == null
            ? SizedBox(
          width: 16.w,
          height: 16.h,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _chip(IconData icon, String label, MaterialColor color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.w, color: color.shade700),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: color.shade700,
            ),
          ),
        ],
      ),
    );
  }
}