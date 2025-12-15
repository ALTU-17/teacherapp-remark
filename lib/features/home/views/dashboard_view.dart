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

class DashboardView extends ConsumerWidget {
   DashboardView({super.key});

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
    {
      'icon': 'assets/user_check.jpeg',
      'label': 'Teacher ID card',
      'isNew': true,
      'page': IDRoute().location
    },
    // {
    //   'icon': 'assets/file_word.png',
    //   'label': 'Question Papers',
    //   'isNew': true,
    //   'page': SmartChatRoute().location
    // },
    // {
    //   'icon': 'assets/file_word.png',
    //   'label': 'Academic Timetable',
    //   'isNew': true,
    //   'page': SmartChatRoute().location
    // },
    // {
    //   'icon': 'assets/file_word.png',
    //   'label': 'Class Substitution',
    //   'isNew': true,
    //   'page': SmartChatRoute().location
    // },
    // {'icon': 'assets/chat.png', 'label': 'Smart Chat', 'page': const SmartChatScreen(), 'isNew': true},
    // {'icon': 'assets/curriculum.png', 'label': 'Curriculum', 'page': const CurriculumScreen()},
  ];

  _launchURL() async {
    const url = 'https://play.google.com/store/apps/details?id=in.aceventura.evolvuschool.teacherapp';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String BaseURl = Config.dynamicEndpoint ?? "";
   bool isBirthdayToday = false;
   List<String> birthdayStudentNames = [];
   // List<Map<String, dynamic>> examData = [];
     // Static exam data for testing UI
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


     static String packageInfoVar ='';
  // String localAndroidVersion ='';
   var lattest_androidVersion= '';


  Future<void> getVersion(BuildContext _context) async {
    print('latest_version11 => ${BaseURl + '/flutter_teacher_apk_latest_version'}');

    final url = Uri.parse(BaseURl + '/flutter_teacher_apk_latest_version');

    try {
      final response = await http.post(url,body: {
        'type':'android'
      },);
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
                                color: Colors.green, fontWeight: FontWeight.bold),
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
              }}}
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
    List<int> newParts = newVersion.split('.').map((e) => int.parse(e)).toList();
    List<int> currentParts = currentVersion.split('.').map((e) => int.parse(e)).toList();

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
   Widget build(BuildContext context, ref) {
     getVersion(context);
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
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 /// **Teacher Profile Card**
                 SizedBox(height: 80.h),

                 // Version update card
                 // if(packageInfoVar != lattest_androidVersion)
                 //   Center(
                 //     child: InkWell(
                 //       onTap: () {
                 //         _launchURL();
                 //       },
                 //       child: Card(
                 //         color: Colors.yellow.shade600,
                 //         shape: RoundedRectangleBorder(
                 //           borderRadius: BorderRadius.circular(10),
                 //         ),
                 //         elevation: 2,
                 //         child: Padding(
                 //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                 //           child: Row(
                 //             children: [
                 //               Icon(Icons.crisis_alert),
                 //               Text(" You have newer version of the app to download "),
                 //               Icon(Icons.arrow_circle_right_outlined),
                 //             ],
                 //           ),
                 //         ),
                 //       ),
                 //     ),
                 //   ),

                 SizedBox(height: 10.h),

                 // Birthday Card - MOVED ABOVE TEACHER CARD
                 // if (isBirthdayToday && birthdayStudentNames.isNotEmpty)
                 //   BirthDayCard(context),
                 SizedBox(height: 5.h),
                 // Teacher Profile Card
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

                 // _buildExamCard(),

                 const SizedBox(height: 10),
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

   bool _isSameDay(DateTime date1, DateTime date2) {
     return date1.year == date2.year &&
         date1.month == date2.month &&
         date1.day == date2.day;
   }

   Widget BirthDayCard(BuildContext context) {
     // Combine all birthday names in the format "Name1 and Name2"
     String combinedNames = birthdayStudentNames.join(" & ");

     return Padding(
       padding: const EdgeInsets.fromLTRB(8,0,8,10),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           GestureDetector(
             onTap: () {
               // Show a dialog with an image when the text is clicked
               showDialog(
                 context: context, // Use the build context here
                 builder: (BuildContext context) {
                   return AlertDialog(
                     title: Text('Happy Birthday $combinedNames'),
                     content: Image.asset('assets/hbd.jpg'),
                     actions: [
                       TextButton(
                         onPressed: () {
                           Navigator.of(context).pop();
                         },
                         child: Text('Close'),
                       ),
                     ],
                   );
                 },
               );
             },
             child: MouseRegion(
               cursor: SystemMouseCursors.click,
               child: AnimatedContainer(
                 duration: const Duration(milliseconds: 300),
                 curve: Curves.easeInOut,
                 decoration: BoxDecoration(
                   gradient: const LinearGradient(
                     colors: [
                       Color.fromARGB(255, 242, 245, 245),
                       Color.fromARGB(255, 248, 250, 252),
                     ],
                     begin: Alignment.topLeft,
                     end: Alignment.bottomRight,
                   ),
                   borderRadius: BorderRadius.circular(20),
                   boxShadow: [
                     BoxShadow(
                       color: const Color.fromARGB(255, 149, 214, 223)
                           .withOpacity(0.6),
                       spreadRadius: 5,
                       blurRadius: 15,
                       offset: const Offset(0, 8),
                     ),
                   ],
                 ),
                 width: 400,
                 height: 90,
                 child: FittedBox(
                   fit: BoxFit.scaleDown,
                   child: Row(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       const Icon(
                         Icons.cake_sharp,
                         color: Colors.pinkAccent,
                         size: 45,
                       ),
                       const SizedBox(width: 15),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const Text(
                             '🎊🎊 Happy Birthday 🎉🎉',
                             style: TextStyle(
                               fontSize: 18,
                               fontWeight: FontWeight.bold,
                               color: Colors.pinkAccent,
                             ),
                           ),
                           // Text(
                           //   combinedNames,
                           //   style: const TextStyle(
                           //     fontSize: 16,
                           //     color: Colors.pink,
                           //   ),
                           // ),
                           Text(
                             '  UKG Teacher: Kalpana Singh\n  UKG Student: Sam Altaman',
                             style: const TextStyle(
                               fontSize: 16,
                               color: Colors.pink,
                             ),
                           ),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         ],
       ),
     );
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
                 displayDate = exam['date']; // Use the original date format if not Today or Tomorrow
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
              Image.asset(icon, width: 95, height: 40), // Activity Icon
              if (isNew)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'New',
                      style: TextStyle(color: Colors.white, fontSize: 8),
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
