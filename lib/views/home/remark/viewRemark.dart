import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teacherapp/views/home/remark/model/remark.dart';
import 'package:teacherapp/views/home/remark/model/remark_attachment.dart';
import 'package:teacherapp/views/home/remark/provider/remark_provider.dart';
import 'package:teacherapp/views/home/remark/service/remark_service.dart';
import '../../../../features/auth/providers/auth_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

class ViewRemark extends ConsumerStatefulWidget {
  final Remark remark;
  const ViewRemark({super.key, required this.remark});

  @override
  ConsumerState<ViewRemark> createState() => _ViewRemarkState();
}

class _ViewRemarkState extends ConsumerState<ViewRemark> {
  late String selectedSubject;
  late String selectedClass;
  late List<String> selectedStudents;
  List<RemarkAttachment> attachments = [];
  bool loadingAttachments = false;
  bool _isDownloading = false;

  // Initialize notifications plugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    selectedSubject = widget.remark.subName ?? '';
    selectedClass = "${widget.remark.className} ${widget.remark.secName}";
    selectedStudents = [
      "${widget.remark.firstName ?? ''} ${widget.remark.midName ?? ''} ${widget.remark.lastName ?? ''}"
    ];
    _initializeNotifications();
    fetchAttachments();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> fetchAttachments() async {
    setState(() => loadingAttachments = true);
    final remarkService = ref.read(remarkServiceProvider);
    final auth = ref.read(authProvider).requireValue;
    try {
      final res = await remarkService.getRemarkImages(
        remarkId: widget.remark.remarkId,
        remarkDate: widget.remark.remarkDate.split(' ').first,
        shortName: auth.teacherVerification?.shortName ?? '',
      );
      setState(() {
        attachments = res;
        loadingAttachments = false;
      });
    } catch (e) {
      setState(() => loadingAttachments = false);
      _showSnackBar('Failed to load attachments: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _handleDownload(RemarkAttachment attachment) async {

    try {
      if (attachment.fileSize == "0") {
        _showSnackBar( 'File not uploaded properly');
      } else {
        String originalUrl = attachment.url; // e.g., "https://sms.arnoldcentralschool.org/SACSv4test/uploads/remark/03-09-2025"
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
        String downloadUrl = '$baseDownloadUrl/${attachment.imageName}';
        print('Download URL: $downloadUrl');

        if (Platform.isAndroid) {
          await _downloadFileAndroid(downloadUrl, context, attachment.imageName);
        } else if (Platform.isIOS) {
          await _downloadFileIOS(downloadUrl, attachment.imageName);
        } else {
          _showSnackBar( 'Unsupported platform');
        }
      }
    } catch (e) {
      _showSnackBar( 'Failed to download file: $e');
    }
  }

  Future<void> onOpenAttachment(String url) async {
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
    final uri = Uri.tryParse(baseDownloadUrl);
    if (uri == null) {
      _showSnackBar( 'Invalid attachment URL');
      return;
    }
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        _showSnackBar( 'Could not open attachment');
      }
    } catch (e) {
      _showSnackBar( 'Error opening attachment: $e');
    }
  }


  Future<void> _downloadFileAndroid(String url, BuildContext context, String name) async {
    setState(() {
      _isDownloading = true;
    });

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

    // Request storage permission
    var status = await Permission.storage.status;
    // if (!status.isGranted) {
    //   status = await Permission.storage.request();
    //   if (!status.isGranted) {
    //     _showSnackBar('Storage permission denied');
    //     setState(() => _isDownloading = false);
    //     return;
    //   }
    // }

    var directory = Directory("/storage/emulated/0/Download/TeacherApp/Remarks");
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    var path = "${directory.path}/$name";
    var file = File(path);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Downloading Attachment',
      'Downloading $name...',
      platformChannelSpecifics,
    );

    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        await file.writeAsBytes(res.bodyBytes);

        await flutterLocalNotificationsPlugin.show(
          0,
          'Download Complete',
          'File saved to Download/TeacherApp/Remarks/$name',
          platformChannelSpecifics,
          payload: path,
        );

        _showSnackBar('File downloaded successfully: Download/TeacherApp/Remarks');
      } else {
        await flutterLocalNotificationsPlugin.show(
          0,
          'Download Failed',
          'Failed to download file: ${res.statusCode}',
          platformChannelSpecifics,
        );
        _showSnackBar('Failed to download file: ${res.statusCode}');
      }
    } catch (e) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Download Failed',
        'Failed to download file',
        platformChannelSpecifics,
      );
      _showSnackBar('Failed to download file: $e');
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  Future<void> _downloadFileIOS(String url, String fileName) async {
    setState(() {
      _isDownloading = true;
    });

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

        await flutterLocalNotificationsPlugin.show(
          0,
          'Download Complete',
          'File saved to $filePath',
          platformChannelSpecifics,
          payload: filePath,
        );

        _showSnackBar('Find it in the Files/On My iPhone/Teacher App/Remarks.');
      } else {
        await flutterLocalNotificationsPlugin.show(
          0,
          'Download Failed',
          'Failed to download file: ${response.statusCode}',
          platformChannelSpecifics,
        );
        _showSnackBar('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      await flutterLocalNotificationsPlugin.show(
        0,
        'Download Failed',
        'Failed to download file',
        platformChannelSpecifics,
      );
      _showSnackBar('Failed to download file: $e');
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: const Text("View Remark", style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
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
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 160.h),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("*Class", style: TextStyle(fontWeight: FontWeight.bold)),
                  _readonlyTile(selectedClass),
                  SizedBox(height: 10.h),

                  const Text("*Subject", style: TextStyle(fontWeight: FontWeight.bold)),
                  _readonlyTile(selectedSubject),
                  SizedBox(height: 10.h),

                  const Text("*Students", style: TextStyle(fontWeight: FontWeight.bold)),
                  _readonlyTile(selectedStudents.join(", ")),
                  SizedBox(height: 10.h),

                  const Text("*Subject of Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                  _readonlyTile(widget.remark.remarkSubject),
                  SizedBox(height: 10.h),

                  const Text("*Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                  _readonlyTile(widget.remark.remarkDesc ?? ''),
                  SizedBox(height: 10.h),

                  // Attach Document header row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Attach Document", style: TextStyle(fontWeight: FontWeight.bold)),
                      if (_isDownloading)
                        const CircularProgressIndicator()
                    ],
                  ),

                  if (loadingAttachments)
                    const Center(child: CircularProgressIndicator())
                  else if (attachments.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: attachments.map((att) {
                        final url = "${att.url}/${att.imageName}";
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              if(att.imageName.contains('.jpg') || att.imageName.contains('.png'))
                                const Icon(Icons.image, color: Colors.redAccent, size: 24)
                              else
                                const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(att.imageName, style: TextStyle(fontSize: 14.sp)),
                                    Text(
                                      "Size: ${_formatFileSize(att.fileSize)}",
                                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),

                              if(att.imageName.contains('.jpg') || att.imageName.contains('.png'))
                                IconButton(
                                  icon: const Icon(Icons.remove_red_eye, color: Colors.green),
                                  onPressed: () => onOpenAttachment(url),
                                ),

                              IconButton(
                                icon: const Icon(Icons.download, color: Colors.blue),
                                onPressed: _isDownloading ? null : () => _handleDownload(att),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text("No attachments", style: TextStyle(color: Colors.grey, fontSize: 14)),
                    ),

                  SizedBox(height: 20.h),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      label: const Text("Back", style: TextStyle(color: Colors.black, fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  String _formatFileSize(String? sizeInBytes) {
    if (sizeInBytes == null || sizeInBytes.isEmpty) return "Unknown";

    final bytes = double.tryParse(sizeInBytes) ?? 0;

    if (bytes < 1024) {
      return "${bytes.toStringAsFixed(0)} B";
    } else if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(2)} KB";
    } else if (bytes < 1024 * 1024 * 1024) {
      return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
    } else {
      return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB";
    }
  }

  Widget _readonlyTile(String label) => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(10.r),
      color: Colors.grey[200],
    ),
    child: Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
  );
}