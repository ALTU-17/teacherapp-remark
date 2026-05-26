import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../views/home/remark/model/ClassSubStudentModel.dart';
import '../../../views/home/remark/provider/remark_provider.dart';
import '../../auth/providers/auth_provider.dart';
import '../views/teacher_id.dart';

class PendingHomeworkStudent {
  final int homeworkId;
  final String description;
  final String endDate;
  final String homeworkStatus;
  final String firstName;
  final String midName;
  final String lastName;
  final String rollNo;
  final String subjectName;
  final String className;
  final String sectionName;

  PendingHomeworkStudent({
    required this.homeworkId,
    required this.description,
    required this.endDate,
    required this.homeworkStatus,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.rollNo,
    required this.subjectName,
    required this.className,
    required this.sectionName,
  });

  String get fullName =>
      [firstName, lastName].where((e) => e.isNotEmpty).join(' ');

  factory PendingHomeworkStudent.fromJson(Map<String, dynamic> json) {
    return PendingHomeworkStudent(
      homeworkId: json['homework_id'] ?? 0,
      description: (json['description'] ?? '').toString(),
      endDate: (json['end_date'] ?? '').toString(),
      homeworkStatus: (json['homework_status'] ?? '').toString(),
      firstName: (json['first_name'] ?? '').toString(),
      midName: (json['mid_name'] ?? '').toString(),
      lastName: (json['last_name'] ?? '').toString(),
      rollNo: (json['roll_no'] ?? '').toString(),
      subjectName: (json['subject_name'] ?? '').toString(),
      className: (json['class_name'] ?? '').toString(),
      sectionName: (json['section_name'] ?? '').toString(),
    );
  }
}

final todayHomeworkProvider = FutureProvider.autoDispose
    .family<List<PendingHomeworkStudent>, Map<String, String>>(
      (ref, params) async {
    final service = ref.watch(staffApiProvider);
    try {
      return await service.getTodayPendingHomework(
        classId: params['class_id']!,
        sectionId: params['section_id']!,
      );
    } catch (e, stack) {
      print('Error fetching homework: $e');
      print('Stack trace: $stack');
      rethrow;
    }
  },
);

class TodayHomeworkScreen extends HookConsumerWidget {
  const TodayHomeworkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClassSection = useState<ClassSection?>(null);

    final classSectionsAsync = ref.watch(classSectionProvider);

    // Use useMemoized to prevent recreating params on every build
    final params = useMemoized(() {
      if (selectedClassSection.value == null) return null;
      return {
        'class_id': selectedClassSection.value!.classId.toString(),
        'section_id': selectedClassSection.value!.sectionId.toString(),
      };
    }, [selectedClassSection.value]);

    // Watch the provider only when params exist
    final hwAsync = params != null
        ? ref.watch(todayHomeworkProvider(params))
        : const AsyncValue.loading();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE91E63), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Header Section (Same as library/birthday screen)
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        // Back Button
                        Container(
                          width: 45.w,
                          height: 48.h,

                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 24.w,
                            ),
                            padding: EdgeInsets.zero,
                            splashRadius: 20.w,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Homework Icon
                        Container(
                          width: 45.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Icon(
                            Icons.assignment_outlined,
                            color: Colors.white,
                            size: 24.w,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pending Homework",
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Today's not submitted homework",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),

            // Main Content
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),

                      // Class/Section Selection Card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: classSectionsAsync.when(
                              loading: () => Container(
                                height: 56.h,
                                child: Center(
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFFE91E63),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              error: (e, _) => Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: Colors.red.shade100),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline,
                                        color: Colors.red.shade400,
                                        size: 20.w
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        "Failed to load classes",
                                        style: TextStyle(
                                          color: Colors.red.shade700,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              data: (classSections) {
                                return DropdownButtonFormField<ClassSection>(
                                  value: selectedClassSection.value,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade50,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(color: Colors.grey.shade300),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                        color: Color(0xFFE91E63),
                                        width: 2,
                                      ),
                                    ),
                                    labelText: "Select Class/Section",
                                    labelStyle: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.class_outlined,
                                      color: Color(0xFFE91E63),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 16.h,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Color(0xFFE91E63),
                                    size: 28.w,
                                  ),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  items: classSections
                                      .map((cs) => DropdownMenuItem(
                                    value: cs,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 4.h),
                                      child: Text(
                                        "${cs.className} - ${cs.sectionName}",
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (val) {
                                    selectedClassSection.value = val;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Content Section
                      Expanded(
                        child: selectedClassSection.value == null
                            ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.school_outlined,
                                size: 80.w,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "Select a Class/Section",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Choose a class to view pending homework",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        )
                            : hwAsync.when(
                          loading: () => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  height: 40.h,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFE91E63),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  "Loading Homework...",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          error: (error, stackTrace) {
                            print('Error in UI: $error');
                            print('Stack trace: $stackTrace');
                            return Center(
                              child: Container(
                                margin: EdgeInsets.all(20.w),
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(color: Colors.red.shade300),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.error_outline_rounded,
                                      size: 48.w,
                                      color: Colors.red.shade400,
                                    ),
                                    SizedBox(height: 16.h),
                                    Text(
                                      "Failed to Load Data",
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Please check your connection and try again",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),
                                    // ElevatedButton.icon(
                                    //   onPressed: () {
                                    //     if (selectedClassSection.value != null) {
                                    //       ref.refresh(todayHomeworkProvider(params!));
                                    //     }
                                    //   },
                                    //   icon: Icon(Icons.refresh, size: 18.w),
                                    //   label: Text("Retry"),
                                    //   style: ElevatedButton.styleFrom(
                                    //     backgroundColor: Color(0xFFE91E63),
                                    //     foregroundColor: Colors.white,
                                    //     shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.circular(10.r),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                          data: (students) {
                            print('Data received: ${students.length} students');

                            if (students.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.not_interested,
                                      size: 80.w,
                                      color: Colors.red.shade400,
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      "No Data Found",
                                      style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      "No pending homework for today",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                children: [
                                  // Summary Card
                                  Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    color: Colors.white,
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12.w),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFE91E63),
                                                  Color(0xFF2196F3),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius: BorderRadius.circular(12.r),
                                            ),
                                            child: Icon(
                                              Icons.assignment_outlined,
                                              color: Colors.white,
                                              size: 28.w,
                                            ),
                                          ),
                                          SizedBox(width: 16.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Pending Homework",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  "${students.length} ${students.length == 1 ? 'Student' : 'Students'}",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12.w,
                                              vertical: 6.h,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF2196F3).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(20.r),
                                              border: Border.all(
                                                color: Color(0xFF2196F3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              "Today",
                                              style: TextStyle(
                                                color: Color(0xFF2196F3),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 16.h),

                                  // Student List
                                  Expanded(
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16.r),
                                      ),
                                      child: Column(
                                        children: [
                                          // Table Header
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 16.h,
                                              horizontal: 16.w,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF2196F3).withOpacity(0.05),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16.r),
                                                topRight: Radius.circular(16.r),
                                              ),
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey.shade200,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "Roll No",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Text(
                                                    "Student Name",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    "Subject",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Student List
                                          Expanded(
                                            child: ListView.separated(
                                              padding: EdgeInsets.zero,
                                              itemCount: students.length,
                                              separatorBuilder: (context, index) => Divider(
                                                height: 1,
                                                color: Colors.grey.shade100,
                                              ),
                                              itemBuilder: (context, index) {
                                                final s = students[index];
                                                return Container(
                                                  color: index.isEven
                                                      ? Colors.grey.shade50
                                                      : Colors.white,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Add onTap functionality here
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                          vertical: 14.h,
                                                          horizontal: 16.w,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Center(
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: 8.w,
                                                                    vertical: 4.h,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    color: Color(0xFFE91E63).withOpacity(0.1),
                                                                    borderRadius: BorderRadius.circular(6.r),
                                                                  ),
                                                                  child: Text(
                                                                    s.rollNo.toString(),
                                                                    style: TextStyle(
                                                                      color: Color(0xFFE91E63),
                                                                      fontWeight: FontWeight.w500,
                                                                      fontSize: 14.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 3,
                                                              child: Text(
                                                                s.fullName,
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.grey.shade800,
                                                                  fontSize: 15.sp,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 2,
                                                              child: Center(
                                                                child: Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: 12.w,
                                                                    vertical: 6.h,
                                                                  ),
                                                                  decoration: BoxDecoration(
                                                                    color: _getSubjectColor(s.subjectName).withOpacity(0.1),
                                                                    borderRadius: BorderRadius.circular(20.r),
                                                                    border: Border.all(
                                                                      color: _getSubjectColor(s.subjectName).withOpacity(0.3),
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                    s.subjectName,
                                                                    style: TextStyle(
                                                                      color: _getSubjectColor(s.subjectName),
                                                                      fontSize: 12.sp,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getSubjectColor(String subjectName) {
  final colors = {
    'Math': Colors.purple,
    'Science': Colors.green,
    'English': Colors.orange,
    'History': Colors.red,
    'Geography': Colors.blue,
    'Physics': Colors.cyan,
    'Chemistry': Colors.teal,
    'Hindi': Colors.brown,
    'Sanskrit': Colors.deepOrange,
    'Computer': Colors.indigo,
  };

  final key = subjectName.toLowerCase();
  for (final entry in colors.entries) {
    if (key.contains(entry.key.toLowerCase())) {
      return entry.value;
    }
  }

  return Color(0xFFE91E63);
}