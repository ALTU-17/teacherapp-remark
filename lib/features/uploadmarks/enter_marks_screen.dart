// enter_marks_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/features/uploadmarks/uploadmarksdashboard.dart';
import 'package:flutter/services.dart';

class _StudentMarkData {
  final StudentData student;
  final Map<int, TextEditingController> controllers;
  final Map<int, bool> componentPresence;
  final Map<int, FocusNode> focusNodes;
  final Map<int, String?> componentErrors;   // ✅ NEW — per-component error
  bool isPresent;

  _StudentMarkData({
    required this.student,
    required this.controllers,
    required this.componentPresence,
    required this.focusNodes,
    required this.componentErrors,           // ✅ NEW
    this.isPresent = true,
  });

  void dispose() {
    for (var c in controllers.values) {
      c.dispose();
    }
    for (var f in focusNodes.values) {
      f.dispose();
    }
  }
}

class EnterMarksScreen extends StatefulWidget {
  final String className;
  final String subjectName;
  final String examName;
  final List<StudentData> students;
  final List<ExamComponent> components;

  const EnterMarksScreen({
    super.key,
    required this.className,
    required this.subjectName,
    required this.examName,
    required this.students,
    required this.components,
  });

  @override
  State<EnterMarksScreen> createState() => _EnterMarksScreenState();
}

class _EnterMarksScreenState extends State<EnterMarksScreen> {
  int _currentIndex = 0;
  bool _isSaving = false;
  final PageController _pageController = PageController();

  late List<_StudentMarkData> _studentsData;

  int? _focusedComponentId;

  @override
  void initState() {
    super.initState();
    _studentsData = widget.students.map((student) {
      final Map<int, TextEditingController> ctrls = {};
      final Map<int, bool> presence = {};
      final Map<int, FocusNode> focusNodes = {};

      final Map<int, String?> errors = {};

      for (var comp in widget.components) {
        ctrls[comp.id] = TextEditingController();
        presence[comp.id] = true;
        errors[comp.id] = null;

        final node = FocusNode();
        node.addListener(() {
          if (!mounted) return;
          setState(() {
            if (node.hasFocus) {
              _focusedComponentId = comp.id;
            } else if (_focusedComponentId == comp.id) {
              _focusedComponentId = null;
            }
          });
        });
        focusNodes[comp.id] = node;

        // ✅ Live validation: block any value > maxMarks
        ctrls[comp.id]!.addListener(() {
          _validateComponentValue(comp, ctrls[comp.id]!);
        });
      }

      return _StudentMarkData(
        student: student,
        controllers: ctrls,
        componentPresence: presence,
        focusNodes: focusNodes,
        componentErrors: errors,                 // ✅ NEW
      );
    }).toList();
  }



  /// Validates live input for a component and stores error text.
  void _validateComponentValue(ExamComponent comp, TextEditingController controller) {
    if (!mounted) return;

    // find the student data that owns this controller
    _StudentMarkData? owner;
    for (final s in _studentsData) {
      if (s.controllers[comp.id] == controller) {
        owner = s;
        break;
      }
    }
    if (owner == null) return;

    final isPresent = owner.componentPresence[comp.id] ?? true;
    if (!isPresent) {
      if (owner.componentErrors[comp.id] != null) {
        setState(() => owner!.componentErrors[comp.id] = null);
      }
      return;
    }

    final raw = controller.text.trim();
    String? error;

    if (raw.isNotEmpty) {
      final value = double.tryParse(raw);
      if (value == null) {
        error = 'Invalid number';
      } else if (value < 0) {
        error = 'Cannot be negative';
      } else if (value > comp.maxMarks) {
        error = 'Max allowed is ${comp.maxMarks}';
      }
    }

    if (owner.componentErrors[comp.id] != error) {
      setState(() => owner!.componentErrors[comp.id] = error);

      // ✅ Show snackbar once when the user crosses the max
      if (error != null && error.startsWith('Max allowed')) {
        _showError(
          '"${comp.title}" cannot exceed ${comp.maxMarks} marks',
        );
      }
    }
  }
  @override
  void dispose() {
    _pageController.dispose();
    for (var s in _studentsData) {
      s.dispose();
    }
    super.dispose();
  }

  void _nextStudent() {
    if (_currentIndex < _studentsData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevStudent() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showJumpDialog() {
    final TextEditingController jumpCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Jump to Roll No', style: TextStyle(fontSize: 16.sp)),
        content: TextField(
          controller: jumpCtrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Enter Roll No'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final roll = int.tryParse(jumpCtrl.text);
              if (roll != null && roll > 0 && roll <= _studentsData.length) {
                Navigator.pop(context);
                _pageController.jumpToPage(roll - 1);
              }
            },
            child: const Text('Go'),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAllMarks() async {
    setState(() => _isSaving = true);

    // Build payload — each component now reports its own is_present
    // [
    //   {
    //     "roll_no": 1,
    //     "marks": {
    //       "1": { "is_present": true,  "obtained": "4" },
    //       "2": { "is_present": false, "obtained": null },
    //       "3": { "is_present": true,  "obtained": "43" }
    //     }
    //   }
    // ]

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() => _isSaving = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All marks submitted successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
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
            '${widget.className} • ${widget.subjectName}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Info Strip
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              //   child: Text(
              //     widget.examName,
              //     style: TextStyle(
              //       color: Colors.white.withOpacity(0.9),
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w500,
              //     ),
              //   ),
              // ),

              // Swipeable Cards
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() {
                    _currentIndex = idx;
                    _focusedComponentId = null; // ✅ reset highlight on student change
                  }),
                  itemCount: _studentsData.length,
                  itemBuilder: (context, index) {
                    return _buildStudentCard(_studentsData[index]);
                  },
                ),
              ),

              // Bottom Bar
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(_StudentMarkData data) {
    final student = data.student;

    return SingleChildScrollView(
      padding: EdgeInsets.all(14.w),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Info Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.w,
                    backgroundColor: Colors.blue.shade50,
                    child: Text(
                      '${student.rollNo}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      student.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Divider(height: 30.h),

              // Absent Toggle
              Row(
                children: [
                  Center(
                    child: Text(
                          widget.examName,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.9),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  ),
                  const Spacer(),
                ],
              ),
              // Only show the global "Mark Attendance" chip for single-component exams
              if (widget.components.length == 1)
                Row(
                  children: [
                    Text(
                      'Mark Attendance',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const Spacer(),
                    FilterChip(
                      label: Text(
                        data.isPresent ? 'Present' : 'Absent',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: data.isPresent
                              ? Colors.green.shade800
                              : Colors.red.shade800,
                        ),
                      ),
                      selected: data.isPresent,
                      onSelected: (val) {
                        setState(() => data.isPresent = val);
                      },
                      selectedColor: Colors.green.shade100,
                      checkmarkColor: Colors.green.shade800,
                    ),
                  ],
                ),
              SizedBox(height: 10.h),

              // Dynamic Inputs
              if (widget.components.length == 1)
                _buildSingleInput(data, widget.components.first)
              else
                _buildMultipleInputs(data),
            ],
          ),
        ),
      ),
    );
  }

  // Case A: 1 Input (Periodic)
  Widget _buildSingleInput(_StudentMarkData data, ExamComponent comp) {
    final controller = data.controllers[comp.id]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${comp.title} (${comp.maxMarks})',
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          enabled: data.isPresent,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: '00',
            suffixText: '/ ${comp.maxMarks}',
            suffixStyle: TextStyle(fontSize: 16.sp, color: Colors.grey),
            filled: true,
            fillColor: data.isPresent ? Colors.white : Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // Case B: Multiple Inputs (Term)
  // Case B: Multiple Inputs (Term)
  Widget _buildMultipleInputs(_StudentMarkData data) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ Subject header
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.menu_book_rounded,
                  size: 18.w, color: Colors.blue.shade700),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  widget.subjectName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue.shade800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${widget.components.length} components',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.blue.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        // Vertical list of component inputs
        ...widget.components.asMap().entries.map((entry) {
          final idx = entry.key;
          final comp = entry.value;
          final controller = data.controllers[comp.id]!;
          final isPresent = data.componentPresence[comp.id] ?? true;
          final focusNode = data.focusNodes[comp.id]!;
          final isLast = idx == widget.components.length - 1;

          // ✅ highlight only for the currently focused field
          final isFocused = _focusedComponentId == comp.id && isPresent;

          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(
                horizontal: isFocused ? 10.w : 0,
                vertical: isFocused ? 8.h : 0,
              ),
              decoration: BoxDecoration(
                // soft halo when focused
                color: isFocused ? Colors.blue.shade50.withOpacity(0.6) : null,
                borderRadius: BorderRadius.circular(12.r),
                border: isFocused
                    ? Border.all(color: Colors.blue.shade400, width: 1.6)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ---- Label ----
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comp.title,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: isFocused
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: isFocused
                                    ? Colors.blue.shade800
                                    : Colors.grey.shade800,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Max: ${comp.maxMarks}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: isFocused
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isFocused
                                    ? Colors.blue.shade600
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // ---- P / A toggle ----
                      _buildPAButton(
                        isPresent: isPresent,
                        onChanged: (val) {
                          setState(() {
                            data.componentPresence[comp.id] = val;
                            if (!val) {
                              controller.clear();
                              if (_focusedComponentId == comp.id) {
                                FocusScope.of(context).unfocus();
                              }
                            }
                          });
                        },
                      ),
                      SizedBox(width: 8.w),

                      // ---- Input ----
                      SizedBox(
                        width: 78.w,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: isFocused
                                ? [
                              BoxShadow(
                                color: Colors.blue.shade200
                                    .withOpacity(0.55),
                                blurRadius: 10,
                                spreadRadius: 1,
                              )
                            ]
                                : null,
                          ),
                          child: TextField(
                            controller: controller,
                            focusNode: focusNode,
                            enabled: isPresent,
                            keyboardType:
                            const TextInputType.numberWithOptions(
                                decimal: true),
                            textInputAction: isLast
                                ? TextInputAction.done
                                : TextInputAction.next,
                            onSubmitted: (_) {
                              if (!isLast) {
                                final nextComp = widget.components[idx + 1];
                                FocusScope.of(context)
                                    .requestFocus(data.focusNodes[nextComp.id]);
                              } else {
                                FocusScope.of(context).unfocus();
                              }
                            },
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: isFocused
                                  ? Colors.blue.shade900
                                  : Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: isPresent ? '00' : 'AB',
                              hintStyle: TextStyle(
                                color: isPresent
                                    ? Colors.grey.shade400
                                    : Colors.red.shade300,
                                fontWeight: FontWeight.w600,
                              ),
                              filled: true,
                              fillColor: !isPresent
                                  ? Colors.red.shade50
                                  : isFocused
                                  ? Colors.white
                                  : Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 8.w),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide(
                                  color: isPresent
                                      ? (isFocused
                                      ? Colors.blue.shade600
                                      : Colors.blue.shade300)
                                      : Colors.red.shade200,
                                  width: isFocused ? 2.4 : 1.5,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide(
                                    color: Colors.red.shade200, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide(
                                  color: Colors.blue.shade700,
                                  width: 2.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  /// Validates current component input and jumps to the next one.
  void _goToNextComponent(_StudentMarkData data, int currentIdx) {
    final comp = widget.components[currentIdx];
    final controller = data.controllers[comp.id]!;
    final isPresent = data.componentPresence[comp.id] ?? true;

    // Validate if present — marks must be entered & within max
    if (isPresent) {
      final raw = controller.text.trim();
      if (raw.isEmpty) {
        _showError('Please enter marks for "${comp.title}" or mark Absent');
        return;
      }
      final value = double.tryParse(raw);
      if (value == null) {
        _showError('Invalid marks entered for "${comp.title}"');
        return;
      }
      if (value < 0 || value > comp.maxMarks) {
        _showError(
            'Marks for "${comp.title}" must be between 0 and ${comp.maxMarks}');
        return;
      }
    }

    // Jump focus to the next component
    final nextComp = widget.components[currentIdx + 1];
    FocusScope.of(context).requestFocus(data.focusNodes[nextComp.id]);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyle(fontSize: 13.sp)),
          backgroundColor: Colors.red.shade600,
          duration: const Duration(seconds: 2),
        ),
      );
  }
  Widget _buildPAButton({
    required bool isPresent,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: EdgeInsets.all(2.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _paSegment(
            label: 'P',
            active: isPresent,
            activeColor: Colors.green.shade600,
            activeBg: Colors.green.shade50,
            onTap: () => onChanged(true),
          ),
          SizedBox(width: 2.w),
          _paSegment(
            label: 'A',
            active: !isPresent,
            activeColor: Colors.red.shade600,
            activeBg: Colors.red.shade50,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }

  Widget _paSegment({
    required String label,
    required bool active,
    required Color activeColor,
    required Color activeBg,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 28.w,
        height: 28.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: active
              ? Border.all(color: activeColor, width: 1.4)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: active ? activeColor : Colors.grey.shade500,
          ),
        ),
      ),
    );
  }
  Widget _buildBottomBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Student ${_currentIndex + 1} of ${_studentsData.length}',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              ElevatedButton(
                onPressed: _currentIndex > 0 ? _prevStudent : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: _showJumpDialog,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue.shade700,
                    side: BorderSide(color: Colors.blue.shade300),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: const Text('Jump To'),
                ),
              ),
              SizedBox(width: 8.w),
              if (_currentIndex == _studentsData.length - 1)
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _submitAllMarks,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                      width: 18, height: 18,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                        : const Text('SUBMIT ALL', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              else
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _nextStudent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                    child: const Text('NEXT', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}