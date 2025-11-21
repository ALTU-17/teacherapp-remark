import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teacherapp/config/utils.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/features/teacher_note/providers/providers.dart';
import 'package:http/http.dart' as http;

import '../models/note.dart';

class ViewTeacherNoteView extends HookConsumerWidget {
  final Note note;

  const ViewTeacherNoteView({super.key, required this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teacherP = ref.read(teacherNoteProvider.notifier);
    final acdYear = ref.watch(academicYearProvider).requireValue;
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final isDownloading = useState<bool>(false);

    // Initialize notifications
    useEffect(() {
      Future.microtask(() async {
        const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
        await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      });
      return null;
    }, []);

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
      Directory("/storage/emulated/0/Download/TeacherApp/TeacherNote");
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
            'File saved to Download/TeacherApp/TeacherNote/$name',
            platformChannelSpecifics,
            payload: path,
          );

          _showSnackBar(context, 'File downloaded successfully Download/TeacherApp/TeacherNote/$name');
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

          _showSnackBar(context, 'Find it in the Files/On My iPhone/Teacher App/TeacherNote.');
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

    Future<void> _handleDownload(String url, String imageName) async {
      try {
        String originalUrl = url;
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
            reformattedDateStr = outputFormat.format(parsedDate);
            baseDownloadUrl = originalUrl.replaceFirst(extractedDate, reformattedDateStr);
          } catch (e) {
            print('Error parsing or formatting date from URL: $e');
            reformattedDateStr = "N/A";
          }
        } else {
          print('Date not found in URL path or format is unexpected.');
          reformattedDateStr = "N/A";
        }
        String downloadUrl = '$baseDownloadUrl';
        print('Teacher Note Download URL: $downloadUrl');

        if (Platform.isAndroid) {
          await _downloadFileAndroid(downloadUrl, context, imageName, flutterLocalNotificationsPlugin);
        } else if (Platform.isIOS) {
          await _downloadFileIOS(downloadUrl, imageName, flutterLocalNotificationsPlugin);
        } else {
          _showSnackBar(context, 'Unsupported platform');
        }
      } catch (e) {
        _showSnackBar(context, 'Failed to download file: $e');
      }
    }

    Widget _getFileIcon(String fileName) {
      if (fileName.toLowerCase().contains('.jpg') ||
          fileName.toLowerCase().contains('.png') ||
          fileName.toLowerCase().contains('.jpeg')) {
        return const Icon(Icons.image, color: Colors.redAccent, size: 24);
      } else if (fileName.toLowerCase().contains('.pdf')) {
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24);
      } else if (fileName.toLowerCase().contains('.doc') ||
          fileName.toLowerCase().contains('.docx')) {
        return const Icon(Icons.description, color: Colors.blue, size: 24);
      } else {
        return const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24);
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: Text(
          "View Teacher Note",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink, Colors.blue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.w, 170.h, 10.w, 40.h),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _infoTable([
                    {
                      "Class:":
                      "${note.classname ?? ""} ${note.sectionname ?? ""}"
                    },
                    {"Subject:": note.subjectname ?? ""},
                    {
                      "Created Date:": note.date != null
                          ? DateFormat('dd-MM-yyyy')
                          .format(DateTime.parse(note.date!))
                          : ""
                    },
                    {
                      "Published Date:": note.publishDate != null
                          ? DateFormat('dd-MM-yyyy').format(note.publishDate!)
                          : ""
                    },
                    {"Description:": note.description ?? ""},
                  ]),
                  FutureBuilder<List<String>>(
                    future: teacherP.getDocument(note),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final files = snapshot.data ?? [];
                      if (files.isEmpty) return const SizedBox();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(color: Colors.grey.shade300, thickness: 1),
                          SizedBox(height: 8.h),
                          Text(
                            "Attachments:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          ...files.map(
                                (fileUrl) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      _getFileIcon(fileUrl.split("/").last),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              fileUrl.split("/").last,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w500),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if ((fileUrl.toLowerCase().contains('.jpg') ||
                                          fileUrl.toLowerCase().contains('.png')) &&
                                          fileUrl.isNotEmpty)
                                        IconButton(
                                          icon: const Icon(Icons.remove_red_eye,
                                              color: Colors.green, size: 20),
                                          onPressed: () {
                                            Utils.openFileView(fileUrl);
                                          },
                                          tooltip: "View",
                                        ),
                                      if (isDownloading.value)
                                        SizedBox(
                                          width: 20.w,
                                          height: 20.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                          ),
                                        )
                                      else
                                        IconButton(
                                          icon: const Icon(Icons.download,
                                              color: Colors.blue, size: 20),
                                          onPressed: () => _handleDownload(fileUrl, fileUrl.split("/").last),
                                          tooltip: "Download",
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTable(List<Map<String, String>> data) {
    return Column(
      children: data.map(
            (row) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120.w,
                  child: Text(
                    row.keys.first,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    row.values.first,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }
}