import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:teacherapp/common/styles.dart';
import 'package:teacherapp/features/auth/providers/providers.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/config.dart';
import '../../../router/routers.dart';

class DashboardView extends ConsumerWidget {
  DashboardView({super.key});

  /// Activity List
  static final List<Map<String, dynamic>> _activities = [
    {'icon': 'assets/teacherNote.png', 'label': 'Teacher Note', 'page': const TeacherNoteRoute().location},
    {'icon': 'assets/homeWork.png', 'label': 'HomeWork', 'page': HomeWorkRoute().location},
    {'icon': 'assets/remarkPng.png', 'label': 'Remark', 'page': RemarkRoute().location},
    {'icon': 'assets/timeTable.png', 'label': 'Time Table', 'page': TimeTableRoute().location},
    {'icon': 'assets/calendar.png', 'label': 'Daily Attendance', 'page': DailyAttendanceRoute().location},
    {'icon': 'assets/leaveApp.png', 'label': 'Leave Application', 'page': LeaveApplicationDashboardRoute().location},
    {'icon': 'assets/cu.png', 'label': 'Curriculum', 'page': CurriRoute().location},
    {'icon': 'assets/smartchat.png', 'label': 'Smart Chat', 'page': SmartChatRoute().location},
  ];

  String BaseURl = Config.dynamicEndpoint ?? "";
  static String packageInfoVar = '';
  var lattest_androidVersion = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider).requireValue;

    return Scaffold(
      body: Stack(
        children: [

          /// 🔹 Background Gradient + Header & Teacher Profile
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color.fromARGB(255, 203, 13, 76), Color.fromARGB(255, 80, 148, 203)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 👩‍🏫 Teacher Profile Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/girl.png',
                          width: 50,
                          height: 60,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${auth.name}', style: AppStyles.boldb15),
                              const SizedBox(height: 5),
                              Text(
                                'Class Teacher of: ${auth.teacherDetails?.classs?.first.className ?? ""} ${auth.teacherDetails?.classs?.first.sectionName ?? ""}',
                                style: AppStyles.font14b14,
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Punch In: ',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    auth.punc?.punchInTime ?? " ",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  SizedBox(width: 25),
                                  Text(
                                    'Last Punch: ',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    auth.punc?.punchOutTime ?? "",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildExamCard(),
                ],
              ),
            ),
          ),

          /// 🧩 DRAGGABLE SHEET — My Activity + Animated Menu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DraggableScrollableSheet(
              initialChildSize: 0.14,
              minChildSize: 0.14,
              maxChildSize: 0.82,
              snap: true,
              snapSizes: const [0.14, 0.50, 0.82],
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),

                      /// Drag Indicator
                      Container(
                        height: 5,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Section Title — always visible
                      const Text(
                        "My Activity",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// 📌 Activity Grid Appears on Swipe
                      Expanded(
                        child: GridView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          itemCount: _activities.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => context.go(_activities[index]['page']),
                              child: _buildActivityCard(
                                _activities[index]['icon'],
                                _activities[index]['label'],
                              ),
                            );
                          },
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
    );
  }

  /// Widget for Activity Icon Box
  Widget _buildActivityCard(String icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 45, height: 45),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
  List<Map<String, dynamic>> examData = [
    {
      's_name': 'Mathematics',
      'study_leave': 'N',
      'date': '2025-01-15',
      'first_name': 'Today',
      'academic_yr': '2024-2054',
      'class_id': '1',
      'section_id': 'A',
      'class_name': 'Class 10A'
    },
    {
      's_name': 'Science',
      'study_leave': 'N',
      'date': '2025-01-16',
      'first_name': 'Tomorrow',
      'academic_yr': '2024-20245',
      'class_id': '1',
      'section_id': 'A',
      'class_name': 'Class 10A'
    },
  ];
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
  Widget _buildExamCard() {
    if (examData.isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // if(examData ==  '')
          // Title for the Exam section
          Text(
            'Exams',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 5.h),

          // Display exams grouped by student name, with each exam in a separate card
          Column(
            children: examData.map((exam) {
              String examSubject = exam['s_name'] ?? ''; // Fetch subject name
              bool isStudyLeave =
                  examSubject.isEmpty || exam['study_leave'] == 'Y';

              // Parse the date from the response
              DateTime examDate = DateTime.parse(exam['date']);
              DateTime today = DateTime.now();
              DateTime tomorrow = today.add(Duration(days: 1));

              // Determine if the date is Today, Tomorrow, or another day
              String displayDate;
              if (_isSameDay(examDate, today)) {
                displayDate = 'Today';
              } else if (_isSameDay(examDate, tomorrow)) {
                displayDate = 'Tomorrow';
              } else {
                displayDate = exam[
                'date']; // Use the original date format if not Today or Tomorrow
              }

              // Wrap the card with InkWell to detect taps
              return InkWell(
                // onTap: () {
                //   // Navigate to the exam details page
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => ExamTimeTablePage(
                //           shortName: shortName,
                //           academic_yr: exam['academic_yr'],
                //           classId: exam['class_id'],
                //           secId: exam['section_id'],
                //           className: exam[
                //           'class_name'] // Pass the exam data to the new page
                //       ),
                //     ),
                //   );
                // },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  color: _isSameDay(examDate, tomorrow)
                      ? Colors.grey[300]
                      : Colors.white, // Gray for Tomorrow, white otherwise
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 26.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Student's first name
                        Expanded(
                          flex: 1,
                          child: Text(
                            exam['first_name'] ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Exam date
                        Expanded(
                          flex: 0,
                          child: Text(
                            displayDate,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Show 'Study Leave' if subject name is empty, else show subject name
                        Expanded(
                          flex: 1,
                          child: Text(
                            isStudyLeave ? 'Study Leave' : examSubject,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: isStudyLeave
                                  ? Colors.redAccent
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
