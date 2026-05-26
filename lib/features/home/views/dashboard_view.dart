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
import 'package:teacherapp/features/home/views/teacher_id.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/config.dart';
import '../../../router/routers.dart';
import '../notice_board_screens/notice_board.dart';

// Add this model class for API response
class ModuleConfig {
  final int smartChat;
  final String smartChatUrl;
  final int curriculum;
  final int lms;
  final String lmsUrl;

  ModuleConfig({
    required this.smartChat,
    required this.smartChatUrl,
    required this.curriculum,
    required this.lms,
    required this.lmsUrl,
  });

  factory ModuleConfig.fromJson(Map<String, dynamic> json) {
    return ModuleConfig(
      smartChat: json["smart_chat"] ?? 0,
      smartChatUrl: json["smart_chat_url"] ?? "",
      curriculum: json["curriculum"] ?? 0,
      lms: json["lms"] ?? 0,
      lmsUrl: json["lms_url"] ?? "",
    );
  }
}

// Add provider for modules
final moduleConfigProvider = FutureProvider<ModuleConfig>((ref) async {
  final auth = ref.read(authProvider).requireValue;
  final baseUrl = auth.teacherVerification?.teacherapkUrl ??
      auth.teacherVerification?.teacherapkUrl ??
      '';

  if (baseUrl.isEmpty) {
    throw Exception('Base URL missing');
  }

  final url = Uri.parse('${baseUrl}AdminApi/show_icons_for_teacher_apk');
  print('show_icons_for_teacher_apk url: $url');

  try {
    final response = await http.post(url);
    print('show_icons_for_teacher_apk body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData["status"] == true) {
        return ModuleConfig.fromJson(jsonData["result"]);
      } else {
        throw Exception('API returned status false');
      }
    } else {
      throw Exception('Failed to load module config');
    }
  } catch (e) {
    print('Error loading module config: $e');
    // Return default config with all modules hidden
    return ModuleConfig(
      smartChat: 0,
      smartChatUrl: "",
      curriculum: 0,
      lms: 0,
      lmsUrl: "",
    );
  }
});

class ExamSubject {
  final int subjectId;
  final String subjectName;

  ExamSubject({required this.subjectId, required this.subjectName});

  factory ExamSubject.fromJson(Map<String, dynamic> json) {
    return ExamSubject(
      subjectId: json["subject_id"],
      subjectName: json["subject_name"],
    );
  }
}

class ExamSlot {
  final DateTime date;
  final bool studyLeave;
  final List<ExamSubject> subjects;

  ExamSlot({
    required this.date,
    required this.studyLeave,
    required this.subjects,
  });

  factory ExamSlot.fromJson(Map<String, dynamic> json) {
    return ExamSlot(
      date: DateTime.parse(json["date"]),
      studyLeave: json["study_leave"] == "Y",
      subjects: (json["subjects"] as List)
          .map((e) => ExamSubject.fromJson(e))
          .toList(),
    );
  }
}

class TeacherClassExam {
  final String className;
  final String sectionName;
  final String examName;
  final List<ExamSlot> timetable;

  TeacherClassExam({
    required this.className,
    required this.sectionName,
    required this.examName,
    required this.timetable,
  });
}

class DashboardView extends ConsumerWidget {
  DashboardView({super.key});

  String BaseURl = Config.dynamicEndpoint ?? "";
  static String packageInfoVar = '';
  var lattest_androidVersion = '';

  final teacherLateCountProvider = FutureProvider<int>((ref) async {
    final api = ref.watch(staffApiProvider);
    return api.getTeacherLateCountMonthly();
  });

  final teacherExamProvider = FutureProvider((ref) async {
    final api = ref.watch(staffApiProvider);
    return api.getTodayTomorrowExams();
  });

  final remindersProvider = FutureProvider<List<TeacherReminder>>((ref) async {
    final api = ref.watch(staffApiProvider);
    final list = await api.getTeacherReminders();

    return list.where((r) => r.publish == "Y" && r.readStatus == 0).toList();
  });

  final dashboardNoticeProvider =
  FutureProvider<List<DashboardNoticeConfig>>((ref) async {
    final api = ref.watch(staffApiProvider);
    return api.getTeacherMobileDashboard();
  });

  // Modified: Build activities dynamically based on module config
  // In DashboardView, modify the _getActivities method to store URLs:

  List<Map<String, dynamic>> _getActivities(ModuleConfig moduleConfig) {
    final List<Map<String, dynamic>> activities = [
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
        'icon': 'assets/almanac.png',
        'label': 'Exam Timetable',
        'isNew': true,
        'page': ExamRoute().location
      },
      {
        'icon': 'assets/leaveApp.png',
        'label': 'Leave Application',
        'page': LeaveApplicationDashboardRoute().location
      },
      {
        'icon': 'assets/user_check.jpeg',
        'label': 'Teacher ID card',
        'isNew': true,
        'page': IDRoute().location
      },
    ];

    // Add dynamic modules based on API response with URLs
    if (moduleConfig.curriculum == 1) {
      activities.add({
        'icon': 'assets/cu.png',
        'label': 'Curriculum',
        'page': CurriRoute().location
      });
    }

    if (moduleConfig.smartChat == 1) {
      activities.add({
        'icon': 'assets/smartchat.png',
        'label': 'Smart Chat',
        'isNew': true,
        'page': SmartChatRoute().location,
        'url': moduleConfig.smartChatUrl, // Pass the URL
      });
    }

    if (moduleConfig.lms == 1) {
      activities.add({
        'icon': 'assets/lms.png',
        'label': 'Past Question Paper',
        'isNew': true,
        'page': LMSWebViewRoute().location,
        'url': moduleConfig.lmsUrl, // Pass the URL
      });
    }

    return activities;
  }

// In the onTap of GridView builder:


  Map<String, NoticeItem Function(int)> _dashboardNoticeFactory(
      BuildContext context) {
    return {
      "lessonPlan": (count) => NoticeItem(
        icon: Icons.menu_book_rounded,
        title: "Weekly Lesson Plans",
        subtitle: "Lesson plans not created",
        count: count,
        onTap: () => const WLPlanRoute().push(context),
      ),
      "birthDayCard": (count) => NoticeItem(
        icon: Icons.cake_rounded,
        title: "Upcoming Birthdays",
        subtitle: "Today's birthdays",
        count: count,
        onTap: () => const BirthdayRoute().push(context),
      ),
      "homeworkCard": (count) => NoticeItem(
        icon: Icons.assignment_rounded,
        title: "Today's Homework",
        subtitle: "Homework due today",
        count: count,
        onTap: () => const TodayHomeworkRoute().push(context),
      ),
      "pendingBooks": (count) => NoticeItem(
        icon: Icons.local_library_rounded,
        title: "Library – Need to Submit",
        subtitle: "Books pending for return",
        count: count,
        onTap: () => const LibRoute().push(context),
      ),
      "defaulterCount": (count) => NoticeItem(
        icon: Icons.currency_rupee_sharp,
        title: "Pending Fees",
        subtitle: "Students with pending fees",
        count: count,
        onTap: () => const PendFeeRoute().push(context),
      ),
    };
  }

  Future<void> getVersion(BuildContext _context) async {
    print(
        'latest_version11 => ${BaseURl + '/flutter_teacher_apk_latest_version'}');

    final url = Uri.parse(BaseURl + '/flutter_teacher_apk_latest_version');

    try {
      final response = await http.post(
        url,
        body: {'type': 'android'},
      );
      print('latest_version => ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('latest_version => ${response.body}');

        if (jsonData is List && jsonData.isNotEmpty) {
          final packageInfo = await PackageInfo.fromPlatform();
          packageInfoVar = packageInfo.version;

          print('Current_version packageInfoVar=> ${packageInfoVar}');

          lattest_androidVersion = jsonData[0]['latest_version'] as String;
          final releaseNotes = jsonData[0]['release_notes'] as String;
          final forcedUpdate = jsonData[0]['forced_update'] as String;

          if (lattest_androidVersion != null) {
            print('Current_version => 22222 ${packageInfo.version}');
            print('lattest_androidVersion => 22222 ${lattest_androidVersion}');

            // lattest_androidVersion = '1.0.1';
            // Compare versions
            if (_isVersionGreater(lattest_androidVersion, packageInfoVar)) {
              print('Current_version => 3333 ${packageInfo.version}');

              if (forcedUpdate == 'N') {
                print('Current_version => NNNNN ${packageInfo.version}');

                showDialog(
                  context: _context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('V ${lattest_androidVersion}'),
                      content: Text(releaseNotes),
                      actions: [
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                'https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool.teacherapp'));
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              } else if (forcedUpdate == 'Y') {
                print('Current_version => 44444 ${packageInfo.version}');

                showDialog(
                  context: _context,
                  barrierDismissible: false, // Prevent dismissing the dialog
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => false, // Disable back button
                      child: AlertDialog(
                        title: Text('V ${lattest_androidVersion}'),
                        content: Text(releaseNotes),
                        actions: [
                          TextButton(
                            onPressed: () {
                              launchUrl(Uri.parse(
                                  'https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool.teacherapp'));
                            },
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
          }
        } else {
          print("Unexpected JSON format");
        }
      } else {
        print('Error Response: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  bool _isVersionGreater(String newVersion, String currentVersion) {
    // Split version strings into parts
    List<int> newParts =
    newVersion.split('.').map((e) => int.parse(e)).toList();
    List<int> currentParts =
    currentVersion.split('.').map((e) => int.parse(e)).toList();

    // Compare each part of the version
    for (int i = 0; i < newParts.length; i++) {
      if (i >= currentParts.length) {
        // If current version has fewer parts, new version is greater
        return true;
      }
      if (newParts[i] > currentParts[i]) {
        return true;
      } else if (newParts[i] < currentParts[i]) {
        return false;
      }
    }

    // If all parts are equal, new version is not greater
    return false;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider).requireValue;
    final sheetController = DraggableScrollableController();

    getVersion(context);

    return Scaffold(
      body: Stack(
        children: [
          /// 🔹 Background Gradient + Header & Teacher Profile
          Container(
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
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 140),
                // 🔑 space for draggable sheet

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
                                      'In: ',
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
                                      'Out: ',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      auth.punc?.punchOutTime ?? "",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    SizedBox(width: 35),
                                    Text(
                                      'Late days: ',
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Consumer(
                                      builder: (context, ref, _) {
                                        final async = ref.watch(teacherLateCountProvider);

                                        return async.when(
                                          loading: () => const Text(
                                            "...",
                                            style: TextStyle(color: Colors.orange),
                                          ),
                                          error: (_, __) => const Text(
                                            "0",
                                            style: TextStyle(color: Colors.orange),
                                          ),
                                          data: (count) => Text(
                                            "$count",
                                            style: const TextStyle(
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),

                    /// 🔔 Reminder Card
                    Consumer(
                      builder: (context, ref, _) {
                        final async = ref.watch(remindersProvider);
                        return async.when(
                          loading: () => const SizedBox(),
                          error: (_, __) => const SizedBox(),
                          data: (reminders) {
                            if (reminders.isEmpty) return const SizedBox();
                            return _buildReminderDashboardCard(
                              context,
                              reminders.length,
                              ref,
                            );
                          },
                        );
                      },
                    ),

                    /// 📢 Dashboard Notices
                    Consumer(
                      builder: (context, ref, _) {
                        final async = ref.watch(dashboardNoticeProvider);
                        return async.when(
                          loading: () => const SizedBox(),
                          error: (_, __) => const SizedBox(),
                          data: (show) {
                            if (show.isEmpty) return const SizedBox();
                            return _buildDashboardNoticeSection(context, ref);
                          },
                        );
                      },
                    ),

                    /// 📅 Exams Section
                    Consumer(
                      builder: (context, ref, _) {
                        final examAsync = ref.watch(teacherExamProvider);
                        return examAsync.when(
                          loading: () => Padding(
                            padding: EdgeInsets.all(16.w),
                            child: const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          ),
                          error: (_, __) => const SizedBox(),
                          data: (data) {
                            final today = data["today"] ?? [];
                            final tomorrow = data["tomorrow"] ?? [];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (today.isNotEmpty)
                                  _buildExamSection(
                                    "📅 Today's Exams",
                                    today,
                                    const Color(0xFFFF6B6B),
                                  ),
                                if (tomorrow.isNotEmpty)
                                  _buildExamSection(
                                    "📅 Tomorrow's Exams",
                                    tomorrow,
                                    const Color(0xFF4FACFE),
                                  ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// 🧩 DRAGGABLE SHEET — My Activity + Animated Menu
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DraggableScrollableSheet(
              controller: sheetController,
              initialChildSize: 0.14,
              minChildSize: 0.14,
              maxChildSize: 0.82,
              snap: true,
              snapSizes: const [0.14, 0.50, 0.82],
              builder: (context, scrollController) {
                return Consumer(
                  builder: (context, ref, _) {
                    final moduleAsync = ref.watch(moduleConfigProvider);

                    return moduleAsync.when(
                      loading: () => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stackTrace) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Center(
                          child: Text('Error loading modules: $error'),
                        ),
                      ),
                      data: (moduleConfig) {
                        final activities = _getActivities(moduleConfig);

                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 10)
                            ],
                          ),
                          child: Column(
                            children: [
                              /// Drag Indicator
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onVerticalDragUpdate: (details) {
                                  final height = MediaQuery.of(context).size.height;
                                  final delta = details.primaryDelta! / height;

                                  sheetController.jumpTo(
                                    (sheetController.size - delta).clamp(0.14, 0.82),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  height: 5,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade500,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 5),

                              /// Section Title — always visible
                              const Text(
                                "My Activity",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 5),

                              /// 📌 Activity Grid Appears on Swipe
                              Expanded(
                                child: GridView.builder(
                                  controller: scrollController,
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  itemCount: activities.length,
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                                  itemBuilder: (context, index) {
                                    final item = activities[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (item.containsKey('url')) {
                                          // Pass URL to the route
                                          context.go(item['page'], extra: {'url': item['url']});
                                        } else {
                                          context.go(item['page']);
                                        }
                                      },
                                      child: _buildActivityCard(
                                        item['icon'],
                                        item['label'],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderDashboardCard(
      BuildContext context, int count, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _openReminders(context, ref),
      child: Container(
        margin: EdgeInsets.only(top: 12, left: 10, right: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.notifications_active, color: Colors.redAccent, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "You have $count unread reminder${count > 1 ? 's' : ''}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "$count",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _openReminders(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => ReminderListSheet(),
    );
  }

  Widget _buildExamSection(
      String title, List<TeacherClassExam> exams, Color primaryColor) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: primaryColor.withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    "${exams.length} exam${exams.length > 1 ? 's' : ''}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Exam Cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: exams.map((exam) {
                return _buildExamCard(exam, primaryColor);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard(TeacherClassExam exam, Color primaryColor) {
    // Get the first slot for basic info
    final firstSlot = exam.timetable.first;
    final examDate = firstSlot.date;
    final hasStudyLeave = firstSlot.studyLeave;
    final examName = exam.examName;

    // Get all subjects
    final subjects = firstSlot.subjects;

    return Container(
      width: 200.w,
      margin: EdgeInsets.only(right: 10.w),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            // Show exam details
          },
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exam Header
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primaryColor,
                            primaryColor.withOpacity(0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${examDate.day}",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            examName,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(
                                Icons.class_outlined,
                                size: 15.w,
                                color: Colors.grey.shade500,
                              ),
                              Text(
                                "  ${exam.className} - ${exam.sectionName}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Date and Study Leave
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16.w,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "${examDate.day}-${examDate.month}-${examDate.year}",
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (hasStudyLeave)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4CAF50).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: Color(0xFF4CAF50).withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.beach_access_outlined,
                                size: 12.w,
                                color: Color(0xFF4CAF50),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "Study Leave",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 10.h),

                // Subjects
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subject List
                    if (subjects.length <= 3)
                      ...subjects.map((subject) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.menu_book_outlined,
                                size: 16.w,
                                color: Colors.grey.shade500,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "Subject : ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: Text(
                                  subject.subjectName,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList()
                    else
                      Column(
                        children: [
                          ...subjects.take(2).map((subject) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8.w,
                                    height: 8.w,
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(
                                      subject.subjectName,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade700,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              "+${subjects.length - 2} more subjects",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExamBox(
      String title, List<TeacherClassExam> exams, Color color) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              )),
          SizedBox(height: 8),
          ...exams.map((e) {
            final subject = e.timetable.first.subjects.first.subjectName;
            final date = e.timetable.first.date;

            return Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${e.className}${e.sectionName}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(subject, style: TextStyle(color: Colors.black87)),
                  Text("${date.day}-${date.month}-${date.year}",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildDashboardNoticeSection(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dashboardNoticeProvider);

    return async.when(
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
      data: (configs) {
        final factory = _dashboardNoticeFactory(context);

        final visible = configs
            .where((e) => e.show == 1 && factory.containsKey(e.key))
            .toList()
          ..sort((a, b) => a.priority.compareTo(b.priority));

        if (visible.isEmpty) return const SizedBox();

        final cards = visible.map((e) => factory[e.key]!(e.value)).toList();

        return Container(
          margin: EdgeInsets.only(top: 8.h),
          child: Column(
            children: cards.map((item) => NoticeCard(item: item)).toList(),
          ),
        );
      },
    );
  }

  /// Widget for Activity Icon Box
  Widget _buildActivityCard(String icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 6)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 50, height: 45),
          const SizedBox(height: 6),
          Text(label,
              textAlign: TextAlign.center,
              style:
              const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final NoticeItem item;

  const NoticeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade100,
                    Colors.blue.shade200,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Icon(
                item.icon,
                color: Colors.blue.shade800,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (item.count > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade500,
                      Colors.red.shade600,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Text(
                  item.count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}