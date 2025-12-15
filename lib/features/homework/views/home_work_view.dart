import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:teacherapp/config/utils.dart';

import 'package:teacherapp/features/homework/providers/h_s_status_provider.dart';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';
import '../providers/homework_provider.dart';
import '../widgets/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class HomeWorkView extends HookConsumerWidget {
  final Homework? homework;
  const HomeWorkView(this.homework, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    final searchQuery = useState<String>('');
    final updateList = useState<List<HomeworkStatus>>([]);
    final homeworkVP = ref.read(hSStatusProvider(homework).notifier);
    final homeworP = ref.read(homeWorkPProvider.notifier);
    final selectedStatuses = useState<Map<String, String>>({});
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final isDownloading = useState<bool>(false);

    void onChecked(HomeworkStatus v) {
      final updatedList = [...updateList.value];

      if (v.homeworkStatus == null) {
        updatedList.removeWhere((e) => e.studentId == v.studentId);
        final newMap = Map<String, String>.from(selectedStatuses.value);
        newMap.remove(v.studentId);
        selectedStatuses.value = newMap;
      } else {
        updatedList.removeWhere((e) => e.studentId == v.studentId);
        updatedList.add(v);
        final newMap = Map<String, String>.from(selectedStatuses.value);
        newMap[v.studentId!] = v.homeworkStatus!;
        selectedStatuses.value = newMap;
      }
      updateList.value = updatedList;
      Utils.debLog(updateList.value.length);
    }



    Future<void> _downloadFileAndroid(
        String url,
        BuildContext context,
        String name,
        FlutterLocalNotificationsPlugin notificationsPlugin) async {
      isDownloading.value = true;

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'download_channel',
        'Download Channel',
        channelDescription: 'Notifications for file downloads',
        importance: Importance.high,
        priority: Priority.high,
        showProgress: true,
        onlyAlertOnce: true,
      );

      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      var directory =
      Directory("/storage/emulated/0/Download/TeacherApp/Homework");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      var path = "${directory.path}/$name";
      var file = File(path);

      await notificationsPlugin.show(
        0,
        'Downloading Attachment',
        'Downloading $name...',
        platformChannelSpecifics,
      );

      try {
        var res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          await file.writeAsBytes(res.bodyBytes);

          await notificationsPlugin.show(
            0,
            'Download Complete',
            'File saved to Download/TeacherApp/Homework/$name',
            platformChannelSpecifics,
            payload: path,
          );

          _showSnackBar(context, 'File downloaded successfully Download/TeacherApp/Homework/$name');
        } else {
          _showSnackBar(context, 'Failed to download file: ${res.statusCode}');
        }
      } catch (e) {
        _showSnackBar(context, 'Failed to download file: $e');
      } finally {
        isDownloading.value = false;
      }
    }

    Future<void> _downloadFileIOS(String url, String fileName, FlutterLocalNotificationsPlugin notificationsPlugin) async {
      isDownloading.value = true;

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
        'download_channel',
        'Download Channel',
        channelDescription: 'Notifications for file downloads',
        importance: Importance.high,
        priority: Priority.high,
        showProgress: true,
        onlyAlertOnce: true,
      );

      const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

      try {
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/$fileName';
        final file = File(filePath);

        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);

          await notificationsPlugin.show(
            0,
            'Download Complete',
            'File saved to $filePath',
            platformChannelSpecifics,
            payload: filePath,
          );

          _showSnackBar(context, 'Find it in the Files/On My iPhone/Teacher App/Homework.');
        } else {
          await notificationsPlugin.show(
            0,
            'Download Failed',
            'Failed to download file: ${response.statusCode}',
            platformChannelSpecifics,
          );
          _showSnackBar(context, 'Failed to download file: ${response.statusCode}');
        }
      } catch (e) {
        await notificationsPlugin.show(
          0,
          'Download Failed',
          'Failed to download file',
          platformChannelSpecifics,
        );
        _showSnackBar(context, 'Failed to download file: $e');
      } finally {
        isDownloading.value = false;
      }
    }

    Future<void> _handleDownload(String url,String imageName) async {

      try {
        // if (attachment.fileSize == "0") {
        //   _showSnackBar(context, 'File not uploaded properly');
        // } else {

        String originalUrl = url; // e.g., "https://sms.arnoldcentralschool.org/SACSv4test/uploads/remark/03-09-2025"
        String reformattedDateStr;
        String baseDownloadUrl = originalUrl;

        RegExp dateRegExp = RegExp(r'(\d{2}-\d{2}-\d{4})');
        Match? dateMatch = dateRegExp.firstMatch(originalUrl);

        if (dateMatch != null && dateMatch.group(0) != null) {
          String extractedDate = dateMatch.group(0)!;
          try {
            // Parse the extracted date (dd-MM-yyyy)
            DateFormat inputFormat = DateFormat('dd-MM-yyyy');
            DateTime parsedDate = inputFormat.parse(extractedDate);
            DateFormat outputFormat = DateFormat('yyyy-MM-dd');
            reformattedDateStr = outputFormat.format(parsedDate); // e.g., "2025-09-03"
            print('Original Date from URL: $extractedDate');
            print('Reformatted Date: $reformattedDateStr');
            baseDownloadUrl = originalUrl.replaceFirst(extractedDate, reformattedDateStr);
            print('Potentially modified base URL for download: $baseDownloadUrl');

          } catch (e) {
            print('Error parsing or formatting date from URL: $e');
            reformattedDateStr = "N/A"; // Or handle as an error
          }
        } else {
          print('Date not found in URL path or format is unexpected.');
          reformattedDateStr = "N/A";
        }
        String downloadUrl = '$baseDownloadUrl';
        print('Homework Download URL: $downloadUrl');

        if (Platform.isAndroid) {
          await _downloadFileAndroid(downloadUrl, context, imageName, flutterLocalNotificationsPlugin);
        } else if (Platform.isIOS) {
          await _downloadFileIOS(downloadUrl, imageName, flutterLocalNotificationsPlugin);
        } else {
          _showSnackBar(context, 'Unsupported platform');
        }
        // }
      } catch (e) {
        _showSnackBar(context, 'Failed to download file: $e');
      }
    }


    update() async {
      if (await homeworkVP.updateHomeWork(updateList.value)) {
        Utils.debLog("Updated");
        return context.pop();
      }
    }

    Widget _getFileIcon(String fileName) {
      if (fileName.toLowerCase().contains('.jpg') ||
          fileName.toLowerCase().contains('.png') ||
          fileName.toLowerCase().contains('.jpeg')) {
        return const Icon(Icons.image, color: Colors.blue, size: 24);
      } else if (fileName.toLowerCase().contains('.pdf')) {
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24);
      } else if (fileName.toLowerCase().contains('.doc') ||
          fileName.toLowerCase().contains('.docx')) {
        return const Icon(Icons.description, color: Colors.blue, size: 24);
      } else {
        return const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24);
      }
    }

    void onUpdatePressed() async {
      if (updateList.value.isEmpty) {
        Utils.toast("Please update at least one student's status");
        return;
      }

      final count = updateList.value.length;
      final confirm = await showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Confirm Update'),
            content: Text(
                'You are about to update status for $count student${count == 1 ? '' : 's'}. Do you want to proceed?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );

      if (confirm == true) {
        await update();
      }
    }

    final homeworkP = ref.read(homeWorkPProvider.notifier);

    // onDownload(String filename) async {
    //   final documentUrls = await homeworP.getDocument(homework!);
    //   // Save to structured folder: TeacherApp/Homework
    //   await Utils()
    //       .onDownload(filename, documentUrls, subfolder: 'TeacherApp/Homework');
    // }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Text(
          "View HomeWork",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: searchController,
              onChanged: (v) => searchQuery.value = v,
              decoration: InputDecoration(
                hintText: "Search Student...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: const Color.fromARGB(255, 215, 208, 208),
                  fontSize: 14.sp,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 238, 232, 232),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top + 70.h + 8.h,
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: RichText(
                text: TextSpan(
                  text: "Description: ",
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: homework?.description ?? 'No Description',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),

            FutureBuilder<List<String>>(
              future: homeworkP.getDocument(homework!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final files = (snapshot.data ?? [])
                    .where((u) => (u).trim().isNotEmpty)
                    .where((u) => u.split('/').isNotEmpty
                    ? u.split('/').last.trim().isNotEmpty
                    : false)
                    .toList();
                if (files.isEmpty) {
                  return const SizedBox.shrink();
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                  EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.h),
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final fileUrl = files[index];
                    final fileName = fileUrl.split("/").last;

                    return Row(
                      children: [
                        _getFileIcon(fileName),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fileName,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        if ((fileName.toLowerCase().contains('.jpg') ||
                            fileName.toLowerCase().contains('.png')) &&
                            fileName.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.remove_red_eye,
                                color: Colors.blue, size: 20),
                            onPressed: () {
                              // Utils.debLog(fileName);
                              Utils.openFileView(fileUrl);
                            },
                          ),
                        IconButton(
                          icon: const Icon(Icons.download,
                              color: Colors.white),
                          onPressed: () => _handleDownload(fileUrl,fileName),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StudentsViewList(
                homework: homework,
                searchQuery: searchQuery.value,
                onChecked: onChecked,
                selectedStatuses: selectedStatuses.value,
              ),
            ),

            /// *Update Button*
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 10.h),
              child: ElevatedButton(
                onPressed: onUpdatePressed,
                style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }
}

class StudentsViewList extends HookConsumerWidget {
  final Homework? homework;
  final String searchQuery;
  final void Function(HomeworkStatus status) onChecked;
  final Map<String, String> selectedStatuses;

  const StudentsViewList({
    super.key,
    required this.homework,
    required this.searchQuery,
    required this.onChecked,
    required this.selectedStatuses,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hsStatus = ref.watch(hSStatusProvider(homework));

    List<HomeworkStudentStatus> filterStudents(
        List<HomeworkStudentStatus> students, String query) {
      if (query.isEmpty) return students;
      final q = query.toLowerCase().trim();
      return students.where((student) {
        final fullName =
        '${student.firstName ?? ""} ${student.lastName ?? ""}'.toLowerCase();
        return fullName.contains(q);
      }).toList();
    }

    return hsStatus.when(
      data: (data) {
        final filteredData = filterStudents(data, searchQuery);

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            final student = filteredData[index];

            return HomeworkVCard(
              student, // 1st positional
                  (newStatus) => onChecked(newStatus), // 2nd positional
              selectedStatus: selectedStatuses[student.studentId], // named
            );

          },
        );
      },
      error: (_, __) => const Center(child: Text("Error loading data")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

