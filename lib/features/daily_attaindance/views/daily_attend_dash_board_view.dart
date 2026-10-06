import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/auth/models/models.dart';
import 'package:teacherapp/features/daily_attaindance/providers/class_provider.dart';
import 'package:teacherapp/features/daily_attaindance/providers/providers.dart';

import '../models/student.dart';
import '../models/student_body.dart';

class DailyAttendDashboardView extends HookConsumerWidget {
  const DailyAttendDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateController = useTextEditingController();
    final selectedDate = useState<String?>(null);
    final selectedClass = useState<ClassInfo?>(null);
    final classes = ref.watch(classPProvider).value;

    void selectDate() async {
      DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
      );

      if (picked != null) {
        final formattedDate =
            "${picked.day.toString().padLeft(2, '0')}-"
            "${picked.month.toString().padLeft(2, '0')}-"
            "${picked.year}";

        selectedDate.value = formattedDate;
        dateController.text = formattedDate;
      }
    }


    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(

        title: const Text(
          "Daily Attendance",
          style: TextStyle(color: Colors.white,fontSize: 18),
        ),
        backgroundColor: const Color.fromARGB(255, 226, 25, 99),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(1.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Class & Date Selection
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   "*Class",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          // SizedBox(height: 5.h),
                          FormBuilderDropdown<ClassInfo>(
                            name: 'class_selection',
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            hint: const Text("Select Class"),
                            items: classes
                                ?.map((cls) => DropdownMenuItem(
                              value: cls,
                              child: Text(
                                "${cls.className} ${cls.sectionName}",
                              ),
                            ))
                                .toList() ??
                                [],
                            onChanged: (value) {
                              selectedClass.value = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   "*Select Date",
                          //   style: TextStyle(
                          //     fontSize: 16,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          // SizedBox(height: 5.h),
                          TextFormField(
                            controller: dateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: "Select Date",
                              prefixIcon: const Icon(Icons.calendar_today),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            onTap: selectDate,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              (selectedClass.value != null && selectedDate.value != null)
                  ? Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: StudentList(
                        selectedClass.value!,
                        selectedDate.value!,
                      ),
                    ),
                  ],
                ),
              )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentList extends HookConsumerWidget {
  final ClassInfo classInfo;
  final String date;

  const StudentList(this.classInfo, this.date, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentBody = StudentBody(
      classID: classInfo.classId,
      sectionID: classInfo.sectionId,
      onlyDate: date,
    );
    final students = ref.watch(attendancePProvider(studentBody));
    final studentsP = ref.read(attendancePProvider(studentBody).notifier);

    onDelete() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Delete Attendance"),
          content:
          const Text("Are you sure you want to delete this attendance?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false), // Cancel
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true), // Confirm
              child: const Text("Yes",style: TextStyle(color: Colors.red),),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await studentsP.deleteAttendance();
        if (context.mounted) {
          context.pop(); // navigate back
        }
      }
    }

    onUpdate() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Update Attendance"),
          content: const Text("Do you want to update this attendance?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false), // Cancel
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true), // Confirm
              child: const Text("Yes",style: TextStyle(color: Colors.green),),
            ),
          ],
        ),
      );

      if (confirmed == true) {
        await studentsP.updateAttendance(studentBody);
        if (context.mounted) {
          Utils.toast("Attendance Updated Successfully", true);
          context.pop(); // navigate back
        }
      }
    }

    return students.when(
      data: (d) {
        if (d.students.isEmpty) {
          return const Center(child: Text("No data"));
        }

        final sortedStudents = List<Students>.from(d.students)
          ..sort((a, b) {
            final rollA = int.tryParse(a.rollNo ?? '0') ?? 0;
            final rollB = int.tryParse(b.rollNo ?? '0') ?? 0;
            return rollA.compareTo(rollB);
          });

        final bool isAttendanceMarked =
        sortedStudents.any(
              (student) =>
          student.attendanceId != null &&
              student.attendanceId!.isNotEmpty,
        );
        return Column(
          children: [
            if (isAttendanceMarked)
              Text(
                "Already marked for this date",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                ),
              ),

            // In StudentList build method, add this after the "Already marked" text:
            Text(
              "Present: ${sortedStudents.where((s) => s.attendanceStatus != "1").length} | "
                  "Absent: ${sortedStudents.where((s) => s.attendanceStatus == "1").length} | "
                  "Total: ${sortedStudents.length}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),

            /// Heading Row
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 1.w),
                color: const Color.fromARGB(255, 233, 219, 236),
                child: Row(
                  children: const [
                    Expanded(

                      child: Center(
                        child: Text(
                          "Select",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(

                      child: Center(
                        child: Text(
                          "Roll No",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      // flex: 1,
                      child: Center(
                        child: Text(
                          "Absent",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      // flex: 1,
                      child: Center(
                        child:Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 5),
            /// Student List
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                  itemCount: sortedStudents.length,
                  itemBuilder: (BuildContext context, int index) {
                    final student = sortedStudents[index];
                    return StudentTile(
                      studentBody: studentBody,
                      student: student,
                    );
                  },
                ),
              ),
            ),

            /// Buttons Row (Update on left, Delete on right if available)
            /// Buttons Row (Update on left, Delete on right if available)
            Padding(
              padding: const EdgeInsets.only(top: 1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 26, 134, 222),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h, // smaller height
                        ),
                      ),
                      onPressed: onUpdate,
                      child: const Text(
                        "Update",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  if (isAttendanceMarked)
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 220, 53, 69),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h, // smaller height
                          ),
                        ),
                        onPressed: onDelete,
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) =>
      const Center(child: Text("Error loading data")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}


class StudentTile extends HookConsumerWidget {
  final StudentBody studentBody;
  final Students student;

  const StudentTile({
    super.key,
    required this.studentBody,
    required this.student,
  });

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final isSelected = useState(
      student.markAttendance == "1",
    );

    final isAbsent = useState(
      student.attendanceStatus == "1",
    );

    final studentsP = ref.read(
      attendancePProvider(studentBody).notifier,
    );

    // ==========================================================
    // SELECT / UNSELECT STUDENT
    // ==========================================================

    void updateStudentSelection(bool? value) {
      final selected = value ?? false;

      isSelected.value = selected;

      final updatedStudent = student.copyWith(
        markAttendance: selected ? "1" : "0",

        // When deselected:
        // reset absent to present/off.
        attendanceStatus:
        selected
            ? (isAbsent.value ? "1" : "0")
            : "0",

        // Once deselected this is no longer an
        // existing attendance record in the current edit.
        attendanceId:
        selected
            ? student.attendanceId
            : null,
      );

      if (!selected) {
        isAbsent.value = false;
      }

      studentsP.toggleStudentSelection(
        updatedStudent,
      );
    }

    // ==========================================================
    // ABSENT
    // ==========================================================

    void updateAbsentSelection(bool? value) {
      // Safety check
      if (!isSelected.value) {
        return;
      }

      final absent = value ?? false;

      isAbsent.value = absent;

      final updatedStudent = student.copyWith(
        attendanceStatus:
        absent ? "1" : "0",
        markAttendance: "1",
      );

      studentsP.toggleStudentSelection(
        updatedStudent,
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 2.h,
      ),
      height: 52.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          // ====================================================
          // SELECT
          // ====================================================

          Expanded(
            flex: 1,
            child: Center(
              child: Checkbox(
                value: isSelected.value,
                onChanged: updateStudentSelection,
              ),
            ),
          ),

          // ====================================================
          // ROLL NO
          // ====================================================

          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                student.rollNo?.toString() ?? "-",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),

          // ====================================================
          // NAME
          // ====================================================

          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${student.firstName ?? ''} "
                      "${student.lastName ?? ''}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isAbsent.value
                        ? Colors.red
                        : Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // ====================================================
          // ABSENT
          // ====================================================

          Expanded(
            flex: 1,
            child: Center(
              child: Checkbox(
                value: isSelected.value
                    ? isAbsent.value
                    : false,

                // DISABLED until Select is checked.
                onChanged: isSelected.value
                    ? updateAbsentSelection
                    : null,
              ),
            ),
          ),

          // ====================================================
          // DELETE
          // ====================================================

          Expanded(
            flex: 1,
            child: Center(
              child:
              student.attendanceId != null &&
                  student.attendanceId!.isNotEmpty
                  ? IconButton(
                padding: EdgeInsets.zero,
                constraints:
                const BoxConstraints(),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 22.sp,
                ),
                onPressed: () =>
                    _confirmDeleteStudentAttendance(
                      context,
                      ref,
                      student,
                    ),
              )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteStudentAttendance(
      BuildContext context,
      WidgetRef ref,
      Students student,
      ) async {
    final attendanceId =
        student.attendanceId;

    if (attendanceId == null ||
        attendanceId.isEmpty) {
      Utils.toast(
        "Attendance ID not found",
        false,
      );
      return;
    }

    final confirmed =
    await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            "Confirm Delete",
          ),
          content: Text(
            "Are you sure you want to delete "
                "attendance for "
                "${student.firstName ?? ''} "
                "${student.lastName ?? ''}?",
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                    ctx,
                    false,
                  ),
              child: const Text(
                "Cancel",
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () =>
                  Navigator.pop(
                    ctx,
                    true,
                  ),
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    final provider = ref.read(
      attendancePProvider(
        studentBody,
      ).notifier,
    );

    final success =
    await provider.deleteStudentAttendance(
      attendanceId,
    );

    if (!context.mounted) {
      return;
    }

    Utils.toast(
      success
          ? "Attendance deleted successfully"
          : "Failed to delete attendance",
      success,
    );
  }
}