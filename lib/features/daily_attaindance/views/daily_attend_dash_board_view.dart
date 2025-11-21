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
        selectedDate.value =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        dateController.text = selectedDate.value!;
      }
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          "Daily Attendance",
          style: TextStyle(color: Colors.white),
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
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Class & Date Selection
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "*Class",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5.h),
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
                        const Text(
                          "*Select Date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5.h),
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
              SizedBox(height: 15.h),
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
              child: const Text("Yes"),
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
              child: const Text("Yes"),
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
          ..sort((a, b) => (a.studentId).compareTo(b.studentId));

        return Column(
          children: [
            if (sortedStudents.first.deleteBtn == '1')
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              color: const Color.fromARGB(255, 233, 219, 236),
              child: Row(
                children: const [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Select",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        "Roll No",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
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
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Absent",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      minimumSize: Size(0, 40.h), // fix small height
                    ),
                    onPressed: onUpdate,
                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                if (sortedStudents.first.deleteBtn == '1')
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
                        minimumSize: Size(0, 40.h), // fix small height
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
  const StudentTile(
      {super.key, required this.studentBody, required this.student});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceStatus = useState(student.attendanceStatus == '1');
    final markAttendance = useState(student.markAttendance == '1');
    final studentsP = ref.read(attendancePProvider(studentBody).notifier);

    void updateStudentSelection(bool? v, bool isAbsentCheckbox) {
      if (isAbsentCheckbox) {
        attendanceStatus.value = v ?? false;
        // When marking absent, automatically mark for attendance
        final s = student.copyWith(
          attendanceStatus: attendanceStatus.value ? "1" : "0",
          markAttendance: "1", // Always mark for attendance when changing status
        );
        studentsP.toggleStudentSelection(s);
      } else {
        markAttendance.value = v ?? false;
        final s = student.copyWith(
          markAttendance: markAttendance.value ? "1" : "0",
          // If unmarking attendance, also set as present
          attendanceStatus: markAttendance.value ? (attendanceStatus.value ? "1" : "0") : "0",
        );
        studentsP.toggleStudentSelection(s);
      }
    }

    return Card(
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: markAttendance.value,
              onChanged: (v) => updateStudentSelection(v, false),
            ),
            CircleAvatar(
              child: student.rollNo != null
                  ? Text((student.rollNo).toString())
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${student.firstName} ${student.lastName}",
              style: TextStyle(
                color: attendanceStatus.value ? Colors.red : Colors.black,
              ),
            ),
            student.isActive == "N"
                ? const Text(
              "(Inactive)",
              style: TextStyle(color: Colors.red),
            )
                : const SizedBox.shrink()
          ],
        ),
        trailing: Checkbox(
          value: attendanceStatus.value,
          onChanged: (v) => updateStudentSelection(v, true),
        ),
      ),
    );
  }
}