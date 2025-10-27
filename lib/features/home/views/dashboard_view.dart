import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/common/styles.dart';
import 'package:teacherapp/features/auth/providers/providers.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';

import '../../../router/routers.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  /// **Activity List with Navigation**
  static final List<Map<String, dynamic>> _activities = [
    {
      'icon': 'assets/teacherNote.png',
      'label': 'Teacher Note',
      'page': const TeacherNoteRoute().location
    },

    {
      'icon': 'assets/homeWork.png',
      'label': 'HomeWork',
      'page': HomeWorkRoute().location
    },
    {
      'icon': 'assets/remarkPng.png',
      'label': 'Remark',
      'page': RemarkRoute().location
    },
    {
      'icon': 'assets/timeTable.png',
      'label': 'Time Table',
      'page': TimeTableRoute().location
    },
    {
      'icon': 'assets/calendar.png',
      'label': 'Daily Attendance',
      'page': DailyAttendanceRoute().location
    },
    {
      'icon': 'assets/leaveApp.png',
      'label': 'Leave Application',
      'page': LeaveApplicationDashboardRoute().location
    },
    {
      'icon': 'assets/cu.png',
      'label': 'Curriculum',
      'page': CurriRoute().location
    },
    {
      'icon': 'assets/smartchat.png',
      'label': 'Smart Chat',
      'page': SmartChatRoute().location
    },
    // {'icon': 'assets/chat.png', 'label': 'Smart Chat', 'page': const SmartChatScreen(), 'isNew': true},
    // {'icon': 'assets/curriculum.png', 'label': 'Curriculum', 'page': const CurriculumScreen()},
  ];

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider).requireValue;
    final acdYear = ref.watch(academicYearProvider).requireValue;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 13, 76),
              Color.fromARGB(255, 80, 148, 203)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:

            /// **Main Content**
            SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Teacher Profile Card**
                SizedBox(height: 120.h),
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
                const SizedBox(height: 15),

                /// **Section Title**
                Center(
                  child: const Text(
                    'My Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                // const SizedBox(height: 10),

                /// **Grid View for Activities**
                /// **Grid View for Activities**
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  children: List.generate(_activities.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => _activities[index]['page'],
                        //   ),
                        // );
                        context.go(_activities[index]['page']);
                      },
                      child: _buildActivityCard(
                        _activities[index]['icon'],
                        _activities[index]['label'],
                        _activities[index].containsKey('isNew')
                            ? _activities[index]['isNew']
                            : false,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Build Activity Card**
  Widget _buildActivityCard(String icon, String label, bool isNew) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Image.asset(icon, width: 40, height: 40), // Activity Icon
              if (isNew)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'New',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
