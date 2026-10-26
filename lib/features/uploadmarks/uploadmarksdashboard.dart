// exam_marks_models.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'enter_marks_screen.dart';


// exam_marks_models.dart

class ClassData {
  final int id;
  final String name;
  ClassData({required this.id, required this.name});
}

class SubjectData {
  final int id;
  final String name;
  SubjectData({required this.id, required this.name});
}

class ExamData {
  final int id;
  final String name;
  ExamData({required this.id, required this.name});
}

// ✅ NEW: Defines the columns for the marks entry
class ExamComponent {
  final int id;
  final String title; // e.g., "Periodic Test", "Portfolio", "SE", "Term"
  final int maxMarks; // e.g., 40, 5, 5, 80

  ExamComponent({
    required this.id,
    required this.title,
    required this.maxMarks,
  });

  factory ExamComponent.fromJson(Map<String, dynamic> json) {
    return ExamComponent(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      maxMarks: int.tryParse(json['max_marks']?.toString() ?? '100') ?? 100,
    );
  }
}

// ✅ NEW: The actual student data
class StudentData {
  final int rollNo;
  final String name;

  StudentData({
    required this.rollNo,
    required this.name,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      rollNo: int.tryParse(json['roll_no']?.toString() ?? '0') ?? 0,
      name: json['student_name']?.toString() ?? '',
    );
  }
}

class EnterExamMarksScreen extends StatefulWidget {
  const EnterExamMarksScreen({super.key});

  @override
  State<EnterExamMarksScreen> createState() => _EnterExamMarksScreenState();
}

class _EnterExamMarksScreenState extends State<EnterExamMarksScreen> {
  // TODO: Load from API
  final List<ClassData> _classes = [
    ClassData(id: 1, name: 'Class 1'),
    ClassData(id: 2, name: 'Class 2'),
    ClassData(id: 7, name: 'Class 7'),
  ];
  final List<SubjectData> _subjects = [
    SubjectData(id: 1, name: 'English'),
    SubjectData(id: 2, name: 'Maths'),
  ];
  final List<ExamData> _exams = [
    ExamData(id: 1, name: 'Unit Test 1'),
    ExamData(id: 2, name: 'Term 1'),
  ];

  ClassData? _selectedClass;
  SubjectData? _selectedSubject;
  ExamData? _selectedExam;

  bool _isLoading = false;

  Future<void> _browse() async {
    if (_selectedClass == null ||
        _selectedSubject == null ||
        _selectedExam == null) {
      _showSnack('Please select Class, Subject and Examination', false);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Replace this delay with your actual API call
      // final response = await api.getStudentsForMarks(...);
      await Future.delayed(const Duration(milliseconds: 600));

      if (!mounted) return;

      // --- DUMMY DATA LOGIC (Replace with API Response) ---
      bool isTermExam = _selectedExam!.name.toLowerCase().contains('term');

      List<ExamComponent> components = isTermExam
          ? [
        ExamComponent(id: 1, title: 'Portfolio', maxMarks: 5),
        ExamComponent(id: 2, title: 'SE', maxMarks: 5),
        ExamComponent(id: 3, title: 'Term', maxMarks: 80),
        ExamComponent(id: 4, title: 'Internal', maxMarks: 20),
      ]
          : [
        ExamComponent(id: 1, title: 'Periodic Test', maxMarks: 40),
      ];

      List<StudentData> students = List.generate(
        10,
            (index) => StudentData(
          rollNo: index + 1,
          name: 'STUDENT NAME ${index + 1}',
        ),
      );
      // ----------------------------------------------------

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => EnterMarksScreen(
            className: _selectedClass!.name,
            subjectName: _selectedSubject!.name,
            examName: _selectedExam!.name,
            students: students,
            components: components,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _showSnack(e.toString(), false);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg, bool ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(ok ? Icons.check_circle : Icons.warning_amber_rounded,
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
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24.w),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Enter Exam Marks',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(14.w),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
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
                          child: Icon(Icons.edit_note_rounded,
                              color: Colors.blue.shade700, size: 20.w),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Select Parameters',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    _styledDropdown<ClassData>(
                      label: 'Select Class',
                      hint: 'Select',
                      value: _selectedClass,
                      items: _classes,
                      display: (c) => c.name,
                      onChanged: (v) => setState(() => _selectedClass = v),
                      required: true,
                    ),
                    SizedBox(height: 12.h),
                    _styledDropdown<SubjectData>(
                      label: 'Select Subject',
                      hint: 'Select',
                      value: _selectedSubject,
                      items: _subjects,
                      display: (s) => s.name,
                      onChanged: (v) => setState(() => _selectedSubject = v),
                      required: true,
                    ),
                    SizedBox(height: 12.h),
                    _styledDropdown<ExamData>(
                      label: 'Select Examination',
                      hint: 'Select',
                      value: _selectedExam,
                      items: _exams,
                      display: (e) => e.name,
                      onChanged: (v) => setState(() => _selectedExam = v),
                      required: true,
                    ),
                    SizedBox(height: 18.h),
                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _browse,
                        icon: _isLoading
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
                        label: Text(_isLoading ? 'Loading...' : 'Browse'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledDropdown<T>({
    required String label,
    required String hint,
    required T? value,
    required List<T> items,
    required String Function(T) display,
    required ValueChanged<T?> onChanged,
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
            children: required
                ? [
              TextSpan(
                text: ' *',
                style: TextStyle(color: Colors.red.shade700),
              ),
            ]
                : [],
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<T>(
            value: value,
            isExpanded: true,
            hint: Text(
              hint,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              isDense: true,
            ),
            items: items
                .map((e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                display(e),
                style: TextStyle(fontSize: 13.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ))
                .toList(),
            onChanged: onChanged,
            icon: Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}