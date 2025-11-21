import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:teacherapp/views/home/remark/provider/remark_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../features/auth/providers/auth_provider.dart';
import 'model/remark.dart';
import 'model/remark_attachment.dart';

class EditRemark extends HookConsumerWidget {
  final Remark remark;
  const EditRemark({super.key, required this.remark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controllers
    final _dateController = useTextEditingController(text: remark.remarkDate.split(' ').first);
    final _subjectOfRemarkController = useTextEditingController(text: remark.remarkSubject);
    final _remarkController = useTextEditingController(text: remark.remarkDesc);
    final showAttachment = useState(true);
    final remarkType = useState<String>(remark.remarkType);
    final selectedSubject = useState<String>(remark.subName ?? "");
    final selectedClass = useState<String>("${remark.className} ${remark.secName}");
    final selectedStudents = useState<List<String>>([
      "${remark.firstName} ${remark.midName ?? ''} ${remark.lastName}"
    ]);
    final deleteimagelist = useState<List<String>>([]);

    // Existing attachments from server
    final attachments = useState<List<RemarkAttachment>>([]);
    final loadingAttachments = useState<bool>(false);
    final uploading = useState<bool>(false);
    final isDownloading = useState<bool>(false);

    // Track newly uploaded files
    final newlyUploadedFiles = useState<List<RemarkAttachment>>([]);
    final newlyUploadedFileNames = useState<List<String>>([]);
    final deletedExistingAttachments = useState<Set<String>>({});

    // Initialize notifications plugin
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
    Widget _getFileIcon(String fileName) {
      if (fileName.contains('.jpg') || fileName.contains('.png')) {
        return const Icon(Icons.image, color: Colors.redAccent, size: 24);
      } else if (fileName.contains('.pdf')) {
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24);
      } else if (fileName.contains('.doc') || fileName.contains('.docx')) {
        return const Icon(Icons.description, color: Colors.blue, size: 24);
      } else {
        return const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24);
      }
    }
    String formatDateForApi(String date) {
      final parts = date.split('-');
      if (parts.length == 3 && parts[0].length == 4) {
        return '${parts[2]}-${parts[1]}-${parts[0]}';
      }
      return date;
    }

    // Load attachments effect (use formatted date for API)
    useEffect(() {
      loadingAttachments.value = true;
      Future.microtask(() async {
        final remarkService = ref.read(remarkServiceProvider);
        final auth = ref.read(authProvider).requireValue;
        try {
          final res = await remarkService.getRemarkImages(
            remarkId: remark.remarkId,
            remarkDate: formatDateForApi(_dateController.text),
            shortName: auth.teacherVerification?.shortName ?? '',
          );
          attachments.value = res;
        } catch (e) {
          _showSnackBar(context, 'Failed to load attachments: $e');
        }
        loadingAttachments.value = false;
      });
      return null;
    }, [_dateController.text]);

    Future<void> _downloadFileAndroid(String url, BuildContext context, String name, FlutterLocalNotificationsPlugin notificationsPlugin) async {
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

      var directory = Directory("/storage/emulated/0/Download/TeacherApp/Remarks");
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
            'File saved to Download/TeacherApp/Remarks/$name',
            platformChannelSpecifics,
            payload: path,
          );

          _showSnackBar(context, 'File downloaded successfully: Download/TeacherApp/Remarks');
        } else {
          await notificationsPlugin.show(
            0,
            'Download Failed',
            'Failed to download file: ${res.statusCode}',
            platformChannelSpecifics,
          );
          _showSnackBar(context, 'Failed to download file: ${res.statusCode}');
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

          _showSnackBar(context, 'Find it in the Files/On My iPhone/Teacher App/Remarks.');
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

    // Advanced download functions
    Future<void> _handleDownload(RemarkAttachment attachment) async {
      try {
        if (attachment.fileSize == "0") {
          _showSnackBar(context, 'File not uploaded properly');
        } else {
          String originalUrl = attachment.url;
          String reformattedDateStr;
          String baseDownloadUrl = originalUrl;

          RegExp dateRegExp = RegExp(r'(\d{2}-\d{2}-\d{4})');
          Match? dateMatch = dateRegExp.firstMatch(originalUrl);

          if (dateMatch != null && dateMatch.group(0) != null) {
            String extractedDate = dateMatch.group(0)!;
            try {
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
          String downloadUrl = '$baseDownloadUrl/${attachment.imageName}';
          print('Download URL: $downloadUrl');

          if (Platform.isAndroid) {
            await _downloadFileAndroid(downloadUrl, context, attachment.imageName, flutterLocalNotificationsPlugin);
          } else if (Platform.isIOS) {
            await _downloadFileIOS(downloadUrl, attachment.imageName, flutterLocalNotificationsPlugin);
          } else {
            _showSnackBar(context, 'Unsupported platform');
          }
        }
      } catch (e) {
        _showSnackBar(context, 'Failed to download file: $e');
      }
    }

    Future<void> onOpenAttachment(String url) async {
      String originalUrl = url;
      String reformattedDateStr;
      String baseDownloadUrl = originalUrl;

      RegExp dateRegExp = RegExp(r'(\d{2}-\d{2}-\d{4})');
      Match? dateMatch = dateRegExp.firstMatch(originalUrl);

      if (dateMatch != null && dateMatch.group(0) != null) {
        String extractedDate = dateMatch.group(0)!;
        try {
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
      final uri = Uri.tryParse(baseDownloadUrl);
      if (uri == null) {
        _showSnackBar(context, 'Invalid attachment URL');
        return;
      }
      try {
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          _showSnackBar(context, 'Could not open attachment');
        }
      } catch (e) {
        _showSnackBar(context, 'Error opening attachment: $e');
      }
    }

    // Attachments upload handler
    Future<void> uploadAttachment() async {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true, withData: true);
      if (result == null || result.files.isEmpty) return;

      uploading.value = true;
      final remarkService = ref.read(remarkServiceProvider);
      final auth = ref.read(authProvider).requireValue;
      bool allOk = true;

      final List<String> uploadedThisCall = [];
      final List<RemarkAttachment> tempNewAttachments = [];

      for (final file in result.files) {
        try {
          final uploadOk = await remarkService.uploadRemarkDocument(
            studentIds: json.encode([remark.remarkId]),
            shortName: auth.teacherVerification?.shortName ?? '',
            filename: file.name,
            fileBytes: file.bytes!,
            uploadDate: formatDateForApi(_dateController.text),
          );

          if (uploadOk) {
            uploadedThisCall.add(file.name);

            // Create new attachment for display
            final newAttachment = RemarkAttachment(
              remarkId: remark.remarkId,
              imageName: file.name,
              fileSize: file.size?.toString() ?? (file.bytes?.length.toString() ?? '0'),
              url: "uploading", // Mark as uploading
            );
            tempNewAttachments.add(newAttachment);
          } else {
            allOk = false;
            _showSnackBar(context, 'Failed to upload ${file.name}');
          }
        } catch (e) {
          allOk = false;
          _showSnackBar(context, 'Error uploading ${file.name}: $e');
        }
      }

      uploading.value = false;

      if (uploadedThisCall.isNotEmpty) {
        // Update state for immediate UI display
        newlyUploadedFiles.value = [...newlyUploadedFiles.value, ...tempNewAttachments];
        newlyUploadedFileNames.value = [...newlyUploadedFileNames.value, ...uploadedThisCall];

        _showSnackBar(context, 'Files uploaded successfully!');

        // Refresh attachments from server after a delay
        Future.delayed(const Duration(seconds: 1), () async {
          try {
            final res = await remarkService.getRemarkImages(
              remarkId: remark.remarkId,
              remarkDate: formatDateForApi(_dateController.text),
              shortName: auth.teacherVerification?.shortName ?? '',
            );
            attachments.value = res;
          } catch (e) {
            print('Error refreshing attachments: $e');
          }
        });
      }
    }
    final deletedAttachments = useState<Set<String>>({});
    final existingAttachments = useState<List<RemarkAttachment>>([]);

    Future<void> deleteAttachment(RemarkAttachment attachment) async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Delete?"),
          content: Text("Are you sure to delete ${attachment.imageName}?"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text("Cancel")
            ),
            TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text("Delete")
            ),
          ],
        ),
      );

      if (confirmed == true) {
        final remarkService = ref.read(remarkServiceProvider);
        final auth = ref.read(authProvider).requireValue;

        try {
          final originalAttachments = List<RemarkAttachment>.from(existingAttachments.value);

          // Immediate UI update
          existingAttachments.value =
              existingAttachments.value.where((a) => attachment.imageName != attachment.imageName).toList();
          deletedAttachments.value = {...deletedAttachments.value, attachment.imageName};
          final isNewFile = newlyUploadedFiles.value.any((a) => attachment.imageName == attachment.imageName);

          if (isNewFile) {
            // Remove from newly uploaded files
            newlyUploadedFiles.value = newlyUploadedFiles.value
                .where((a) => a.imageName != attachment.imageName)
                .toList();
            newlyUploadedFileNames.value = newlyUploadedFileNames.value
                .where((n) => n != attachment.imageName)
                .toList();
            _showSnackBar(context, 'Attachment removed successfully');
          } else {
            // For existing files, call the delete API
            final remarkIdArray = json.encode([remark.remarkId]);

            print("🧨 DELETING ATTACHMENT:");
            print("  Filename: ${attachment.imageName}");
            print("  Remark ID Array: $remarkIdArray");
            print("  Upload Date: ${_dateController.text}");
            print("  Short Name: ${auth.teacherVerification?.shortName}");

            // Immediately remove from UI for better UX
            attachments.value = attachments.value
                .where((a) => a.imageName != attachment.imageName)
                .toList();

            final ok = await remarkService.NdeleteRemarkDocument(
              upload_date: formatDateForApi(_dateController.text),
              shortName: auth.teacherVerification?.shortName ?? '',
              filename: attachment.imageName,
              student_id: remarkIdArray,
            );

            if (ok) {
              _showSnackBar(context, 'Attachment deleted successfully');
              // Add to deleteimagelist for the final update API call
              deleteimagelist.value = [...deleteimagelist.value, attachment.imageName];
            } else {
              existingAttachments.value = originalAttachments;
              deletedAttachments.value =
                  deletedAttachments.value.difference({attachment.imageName});
              _showSnackBar(context, 'Attachment deleted successfully');
            }
          }
        } catch (e) {
          print("❌ DELETE ERROR DETAILS: $e");
          _showSnackBar(context, 'Error deleting attachment: ${e.toString()}');
        }
      }
    }

    void _resetForm() {
      _dateController.text = remark.remarkDate.split(' ').first;
      _subjectOfRemarkController.text = remark.remarkSubject;
      _remarkController.text = remark.remarkDesc;
      // Do not clear attachments on reset; only UI fields
    }

    Future<void> _saveRemark() async {
      final remarkService = ref.read(remarkServiceProvider);
      final auth = ref.read(authProvider).requireValue;

      try {
        final formattedDate = formatDateForApi(_dateController.text);

        // Fetch current attachments from API
        final currentAttachments = await remarkService.getRemarkImages(
          remarkId: remark.remarkId,
          remarkDate: formattedDate,
          shortName: auth.teacherVerification?.shortName ?? '',
        );

        final currentFilenames = currentAttachments.map((a) => a.imageName).toSet();
        final remainingFilenames = attachments.value.map((a) => a.imageName).toSet();

        // Deleted files = files in current but not in remaining
        final filesToDelete = currentFilenames.difference(remainingFilenames);

        // Only send newly uploaded files (not existing server files)
        final List<String> namesToSend = newlyUploadedFileNames.value;

        final String fileNamePayload = namesToSend.isNotEmpty
            ? json.encode(namesToSend)
            : "";

        final String deleteFilesPayload = filesToDelete.isNotEmpty
            ? json.encode(filesToDelete.toList())
            : "";

        print('📤 Saving remark...');
        print('➡️ New filenames: $namesToSend');
        print('➡️ Files to delete: $filesToDelete');

        final res = await remarkService.updateRemark(
          app_version: '1.70',
          remarkId: remark.remarkId,
          remarkSubject: _subjectOfRemarkController.text,
          remarkDesc: _remarkController.text,
          remarkDate: formattedDate,
          academicYr: auth.academicYr ?? '',
          teacherId: auth.regId ?? '',
          shortName: auth.teacherVerification?.shortName ?? '',
          classId: remark.classId,
          sectionId: remark.sectionId,
          subjectId: remark.subjectId,
          studentId: remark.studentId,
          remarkType: remarkType.value,
          publish: "N",
          acknowledge: "N",
          fileName: fileNamePayload,
          deleteFiles: deleteFilesPayload,
        );

        if (res['status'] == true) {
          newlyUploadedFiles.value = [];
          newlyUploadedFileNames.value = [];
          _showSnackBar(context, res['success_msg'] ?? "✅ Remark Updated Successfully!");
          Navigator.of(context).pop(true);
        } else {
          _showSnackBar(context, res['error_msg'] ?? "❌ Failed to update remark");
        }
      } catch (e, st) {
        print("❌ Exception in _saveRemark: $e");
        print(st);
        _showSnackBar(context, "Error updating remark: $e");
      }
    }

    Widget _buildAttachmentItem(RemarkAttachment attachment, bool isNewUpload) {
      final url = attachment.url != null && attachment.url!.isNotEmpty && attachment.url != "uploading"
          ? "${attachment.url}/${attachment.imageName}"
          : '';

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Card(
          elevation: 2,
          color: isNewUpload ? Colors.blue.shade50 : null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _getFileIcon(attachment.imageName),
                if (isNewUpload)
                  const Icon(Icons.new_releases, color: Colors.blue, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attachment.imageName,
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Size: ${_formatFileSize(attachment.fileSize)}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                      if (isNewUpload)
                        Text(
                          "New upload",
                          style: TextStyle(fontSize: 10.sp, color: Colors.blue, fontStyle: FontStyle.italic),
                        ),
                    ],
                  ),
                ),
                if ((attachment.imageName.contains('.jpg') || attachment.imageName.contains('.png')) &&
                    url.isNotEmpty && !isNewUpload)
                  IconButton(
                    icon: const Icon(Icons.remove_red_eye, color: Colors.green, size: 20),
                    onPressed: () => onOpenAttachment(url),
                    tooltip: "View",
                  ),
                IconButton(
                  icon: const Icon(Icons.download, color: Colors.blue, size: 20),
                  onPressed: isDownloading.value || url.isEmpty || isNewUpload
                      ? null
                      : () => _handleDownload(attachment),
                  tooltip: isNewUpload ? "Download after update" : "Download",
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: () => deleteAttachment(attachment),
                  tooltip: "Delete",
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _readonlyTile(String label) => Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.grey.shade300,
      ),
      child: Text(label, style: TextStyle(fontSize: 14.sp, color: Colors.black87)),
    );



    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: const Text("Edit Remark", style: TextStyle(color: Colors.white, fontSize: 20)),
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 150.h),
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
                  _readonlyTile(selectedClass.value),
                  SizedBox(height: 20.h),

                  const Text("*Subject", style: TextStyle(fontWeight: FontWeight.bold)),
                  _readonlyTile(selectedSubject.value),
                  SizedBox(height: 10.h),

                  const Text("*Students", style: TextStyle(fontWeight: FontWeight.bold)),
                  _readonlyTile(selectedStudents.value.join(", ")),
                  SizedBox(height: 10.h),

                  const Text("*Subject of Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _subjectOfRemarkController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  const Text("*Remark", style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    controller: _remarkController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      Checkbox(
                        value: remarkType.value == 'Observation',
                        onChanged: (val) {
                          remarkType.value = val == true ? 'Observation' : 'Remark';
                        },
                      ),
                      const Text(' Observation \n(will not be shown to parents!)'),
                    ],
                  ),

                  if (remarkType.value == 'Remark') ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Attachments", style: TextStyle(fontWeight: FontWeight.bold)),
                        if (isDownloading.value)
                          const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        else if (uploading.value)
                          const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        else
                          IconButton(
                            icon: const Icon(Icons.attach_file, color: Colors.blue),
                            onPressed: uploadAttachment,
                          ),
                      ],
                    ),

                    SizedBox(height: 2.h),
                    if (loadingAttachments.value)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: LinearProgressIndicator(),
                      )
                    else if (attachments.value.isNotEmpty || newlyUploadedFiles.value.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Existing attachments section
                          if (attachments.value.isNotEmpty) ...[
                            const Text("Existing Attachments",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                            SizedBox(height: 8.h),
                            ...attachments.value.map((attachment) => _buildAttachmentItem(attachment, false)).toList(),
                            SizedBox(height: 16.h),
                          ],

                          // Newly uploaded files section
                          if (newlyUploadedFiles.value.isNotEmpty) ...[
                            Text("New files to add (${newlyUploadedFiles.value.length}):",
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.blue)),
                            SizedBox(height: 8.h),
                            ...newlyUploadedFiles.value.map((attachment) => _buildAttachmentItem(attachment, true)).toList(),
                          ],
                        ],
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Text("No attachments", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      ),
                  ],
                  SizedBox(height: 20.h),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 78, 157, 222),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: _saveRemark,
                          icon: Icon(Icons.save, size: 16.sp, color: Colors.white),
                          label: const Text("Update", style: TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade400,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          onPressed: _resetForm,
                          icon: Icon(Icons.refresh, size: 16.sp, color: Colors.black),
                          label: const Text("Reset", style: TextStyle(color: Colors.black, fontSize: 14)),
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

  Widget _getFileIcon(String fileName) {
    if (fileName.contains('.jpg') || fileName.contains('.png')) {
      return const Icon(Icons.image, color: Colors.redAccent, size: 24);
    } else if (fileName.contains('.pdf')) {
      return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 24);
    } else if (fileName.contains('.doc') || fileName.contains('.docx')) {
      return const Icon(Icons.description, color: Colors.blue, size: 24);
    } else {
      return const Icon(Icons.insert_drive_file, color: Colors.blue, size: 24);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}